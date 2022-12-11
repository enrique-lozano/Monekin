import {
  AfterContentChecked,
  ChangeDetectorRef,
  Component,
  ElementRef,
  ViewChild,
} from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AlertController } from '@ionic/angular';
import { Chart } from 'chart.js';
import {
  currentDay,
  currentMonth,
  currentYear,
} from 'src/app/constants/constants';
import { Budget } from 'src/app/services/db/budget/budget.model';
import { BudgetService } from 'src/app/services/db/budget/budget.service';
import { Transaction } from 'src/app/services/db/transaction/transaction.model';
import { IonPopoverService } from 'src/app/services/ionic/ion-popover.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { UtilsService } from 'src/app/services/utils/utils.service';
import { SwiperOptions } from 'swiper';
import { SwiperComponent } from 'swiper/angular';

@Component({
  selector: 'app-budget-detail',
  templateUrl: './budget-details.page.html',
  styleUrls: ['./budget-details.page.scss'],
})
export class BudgetDetailsPage implements AfterContentChecked {
  budget: Budget;
  /** Money already spended on the budget */ currentValue: number;
  /** % of the total already spended on the budget */ percentaje: number;
  /** Days to finish the budget */ daysLeft: number;
  transactions: Transaction[] = [];

  segmentValue: 'Statistics' | 'Transactions' = 'Statistics';

  constructor(
    public lang: LangService,
    private router: Router,
    private readonly budgetService: BudgetService,
    private changeDet: ChangeDetectorRef,
    private activeRoute: ActivatedRoute,
    private utils: UtilsService,
    private popoverService: IonPopoverService,
    private alertController: AlertController
  ) {}

  @ViewChild('swiper') swiper: SwiperComponent;
  config: SwiperOptions = {
    autoHeight: true,
  };

  ngAfterContentChecked() {
    if (this.swiper) {
      this.swiper.updateSwiper({});
    }
  }

  async ionViewDidEnter() {
    this.budget = (await this.budgetService.getBudgets()).find(
      (x) => x.name == this.activeRoute.snapshot.paramMap.get('id')
    );

    await this.getBudgetStatistics();

    this.createBarChart();
  }

  slideChanged() {
    if (this.swiper.swiperRef.activeIndex == 0) {
      this.segmentValue = 'Statistics';
    } else if (this.swiper.swiperRef.activeIndex == 1) {
      this.segmentValue = 'Transactions';
    }

    this.changeDet.detectChanges();
  }

  // Go to the next and the prev slide
  next() {
    this.swiper.swiperRef.slideNext();
  }

  prev() {
    this.swiper.swiperRef.slidePrev();
  }

  /** Return the amount of diary money that the user should spend to success the budget */
  getDiarySpendLeft(): number {
    return (this.budget.limit - this.currentValue) / (this.daysLeft + 1);
  }

  getBarColor(percentage: number) {
    if (!percentage) return '000000';

    return this.utils.hslToHex(percentage, 100, 35);
  }

  async getBudgetStatistics() {
    this.transactions = await this.budgetService.getBudgetTransactions(
      this.budget
    );

    this.daysLeft = await this.budgetService.getBudgetDaysLeft(this.budget);

    let value = 0;
    this.transactions.forEach((trans) => {
      value += Math.abs(trans.value);
    });

    this.currentValue = value;
    this.percentaje = this.currentValue / this.budget.limit;
    if (this.percentaje > 1) this.percentaje = 1;
  }

  @ViewChild('chart') chart: ElementRef<HTMLCanvasElement>;
  chartRef: Chart;

  /** Get the data of the transactions until the current day. Data from the current day
   * until the budgetEndDay will not be filled, but should appear in the chart like blank
   * data. For that we push blank labels (see getChartLabels).
   *
   * @returns Array of numbers with the data */
  getChartData(): number[] {
    let result: number[] = [];
    let current = 0;
    if (this.budget.repeat == 'month') {
      for (let i = 1; i <= currentDay; i++) {
        this.transactions.forEach((trans) => {
          if (trans.date.getDate() == i) {
            current += Math.abs(trans.value);
          }
        });
        result.push(current);
      }
    } else if (this.budget.repeat == 'year') {
      for (let month = 0; month <= currentMonth; month++) {
        for (
          let day = 1;
          day <= new Date(currentYear, month + 1, 0).getDate();
          day++
        ) {
          this.transactions.forEach((trans) => {
            if (trans.date.getDate() == day && trans.date.getMonth() == month) {
              current += Math.abs(trans.value);
            }
          });
          result.push(current);
        }
      }
    } else if (this.budget.repeat == 'week') {
      result = new Array(7).fill(0);

      this.transactions.forEach((trans) => {
        const index = trans.date.getDay() - 1;
        result[index] = result[index] + trans.value;
      });

      for (let i = 0; i < result.length; i++) {
        current += result[i];
        result[i] = current;
      }
    } else if (this.budget.repeat == 'no' && this.budget.endDate != undefined) {
      for (
        let i = this.budget.startDate.getTime();
        i < this.budget.endDate.getTime();
        i += 86400000
      ) {
        const loopDay = new Date(i);
        this.transactions.forEach((trans) => {
          if (
            loopDay.getDate() == trans.date.getDate() &&
            loopDay.getMonth() == trans.date.getMonth() &&
            loopDay.getFullYear() == trans.date.getFullYear()
          ) {
            current += Math.abs(trans.value);
          }
        });

        result.push(current);
      }
    }

    return result;
  }

  getChartLabels(): string[] {
    let result: string[] = [];
    if (this.budget.repeat == 'month') {
      for (
        let i = 1;
        i <= new Date(currentYear, currentMonth, 0).getDate();
        i++
      ) {
        result.push('');
      }
    } else if (this.budget.repeat == 'year') {
      for (let month = 0; month <= 11; month++) {
        for (
          let day = 1;
          day <= new Date(currentYear, month, 0).getDate();
          day++
        ) {
          result.push('');
        }
      }
    } else if (this.budget.repeat == 'week') {
      result = new Array(7).fill('');
    } else if (this.budget.repeat == 'no' && this.budget.endDate != undefined) {
      for (
        let i = this.budget.startDate.getTime();
        i < this.budget.endDate.getTime();
        i += 86400000
      ) {
        result.push('');
      }
    }
    return result;
  }

  createBarChart() {
    const ctx = this.chart.nativeElement;

    Chart.defaults.font.size = 12;
    Chart.defaults.maintainAspectRatio = false;

    const labels = this.getChartLabels();
    const data = this.getChartData();

    if (this.chartRef) {
      this.chartRef.data.labels = labels;
      this.chartRef.data.datasets[0].data = data;
      this.chartRef.update();

      return;
    }

    this.chartRef = new Chart(ctx, {
      type: 'line',
      data: {
        labels,
        datasets: [
          {
            data,
            backgroundColor: '#004aad',
            borderColor: '#004aad',
            borderWidth: 5,
            tension: 0.25,
          },
        ],
      },
      options: {
        elements: {
          point: {
            radius: 0,
          },
        },
        responsive: true,
        scales: {
          x: {
            grid: {
              display: false,
            },
          },
          y: {
            suggestedMax: this.budget.limit,
            suggestedMin: 0,
          },
        },
        plugins: {
          legend: {
            display: false,
          },
        },
      },
    });
  }

  async openBudgetActions(event: any) {
    const popoverResult = await this.popoverService.openPopoverMenu(event, [
      {
        id: 'edit',
        labelKey: 'GENERAL.edit',
        icon: 'pencil-outline',
      },
      {
        id: 'delete',
        labelKey: 'GENERAL.delete',
        icon: 'trash-outline',
      },
    ]);

    if (popoverResult.data == 'edit') {
      this.router.navigate(['budgets', 'budget-form', this.budget.name]);
    } else if (popoverResult.data == 'delete') {
      this.deleteBudget();
    }
  }

  async deleteBudget() {
    const alert = await this.alertController.create({
      cssClass: 'basicAlert',
      header: this.lang.getTranslation('BUDGETS.delete'),
      message: this.lang.getTranslation('BUDGETS.delete-warning'),
      buttons: [
        {
          text: this.lang.getTranslation('GENERAL.confirm'),
          handler: () => {
            this.budgetService.deleteBudget(this.budget.name);

            this.router.navigate(['budgets']);
          },
        },
      ],
    });

    await alert.present();
  }
}
