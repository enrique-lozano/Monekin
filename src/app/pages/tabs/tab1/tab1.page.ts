import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { SwiperComponent } from 'swiper/angular';

// import Swiper core and required modules
import SwiperCore, { FreeMode, SwiperOptions } from 'swiper';

import { FinanceHealthService } from 'src/app/services/finance-health/finance-health.service';

import Chart from 'chart.js/auto';

//import { animate, style, transition, trigger } from '@angular/animations';
import { animate, style, transition, trigger } from '@angular/animations';
import { AccountUtilsService } from 'src/app/services/account-utils/account-utils.service';
import { Account } from 'src/app/services/db/account/account.model';
import { AccountService } from 'src/app/services/db/account/account.service';
import { UserAvatars } from 'src/app/services/db/settings/settings.model';
import { SettingsService } from 'src/app/services/db/settings/settings.service';
import { Transaction } from 'src/app/services/db/transaction/transaction.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { DateRangeService } from 'src/app/services/filters/date-range/date-range.service';
import { FilterService } from 'src/app/services/filters/filter.service';
import { StatusBarService } from 'src/app/services/ionic/status-bar.service';
import { LangService } from 'src/app/services/translate/translate.service';

// install Swiper modules
SwiperCore.use([FreeMode]);

@Component({
  selector: 'app-tab1',
  templateUrl: 'tab1.page.html',
  styleUrls: ['tab1.page.scss'],
  animations: [
    trigger('inOut', [
      transition('void => *', [
        style({ opacity: 0 }), // initial styles
        animate(
          '0.6s',
          style({ opacity: 1 }) // final style after the transition has finished
        ),
      ]),
    ]),
  ],
})
export class Tab1Page implements OnInit {
  healthy: number;
  healthyColor: number;
  healthyReview: string;
  importantTransactions: Transaction[];

  userName: string;
  userAvatar: UserAvatars;
  currentTime: 'day' | 'night' =
    new Date().getHours() < 21 && new Date().getHours() > 6 ? 'day' : 'night';

  accounts: (Account & { variation: number; money: number })[];
  //selectedPeriod: 'Weekly' | 'Monthly' | 'Quaterly' | 'Annualy' = 'Annualy';

  userTotalMoney: number;
  userMoneyVariation: number;

  userTotalIncome: number;
  userTotalExpense: number;

  @ViewChild('accountsSwiper') accountsSwiper: SwiperComponent;
  accountsSwiperConfig: SwiperOptions = {
    modules: [FreeMode],
    freeMode: true,
    slidesPerView: 'auto',
  };

  @ViewChild('healthyChart') healthyChart: ElementRef<HTMLCanvasElement>;
  healthyChartRef: Chart;

  constructor(
    public lang: LangService,
    private accountService: AccountService,
    private transactionService: TransactionService,
    private settingService: SettingsService,
    private accountUtils: AccountUtilsService,
    public dateRangeService: DateRangeService,
    private router: Router,
    private filter: FilterService,
    //  private modalService: IonModalService,
    private statusBar: StatusBarService,
    private financeHealth: FinanceHealthService
  ) {}

  ngOnInit() {}

  ionViewWillEnter() {
    this.statusBar.setPrimaryStatusBar();
    document.getElementsByTagName('ion-fab')[0].classList.remove('hide');

    this.reInitializeParams();
  }

  async ionViewDidEnter() {
    await this.getDateRangeData();

    if (this.accountsSwiper) {
      this.accountsSwiper.updateSwiper({});
    }
  }

  ionViewDidLeave() {
    this.reInitializeParams();
  }

  /** To show loadings in the different parts of the view, the variables should be undefined  */
  reInitializeParams() {
    this.importantTransactions = undefined;
    this.userTotalExpense = undefined;
    this.userTotalIncome = undefined;
    this.userMoneyVariation = undefined;
    this.accounts = undefined;
  }

  /** Update required variables. Usefull onViewEnter and when the user change the dateRangeSelected for example */
  async getDateRangeData() {
    this.dateRangeService.startDate = (
      await this.dateRangeService.getCurrentDateRange()
    )[0];
    this.dateRangeService.endDate = (
      await this.dateRangeService.getCurrentDateRange()
    )[1];

    await this.getAccounts();

    if (!this.filter.selectedAccounts)
      this.filter.selectedAccounts = this.accounts;

    if (this.accounts) {
      this.getVariables();
      this.getHealthyValue();
      this.getImportantTransactions();
    }
  }

  async getAccounts() {
    await new Promise((r) => setTimeout(r, 500));

    this.accounts = await Promise.all(
      (
        await this.accountService.getAccounts()
      ).map(async (acc) => ({
        ...acc,
        ...{
          money: await this.accountUtils.getAccountsMoney([acc]),
          variation: await this.accountUtils.getAccountsMoneyVariation(
            [acc],
            undefined,
            this.dateRangeService.startDate,
            this.dateRangeService.endDate
          ),
        },
      }))
    );
  }

  async getVariables() {
    const userSettings = await this.settingService.getSettings();

    this.userName = userSettings.userName;
    this.userAvatar = userSettings.avatar;

    const userCurrency = userSettings.preferredCurrency;

    this.userTotalMoney = await this.accountUtils.getAccountsMoney(
      this.accounts,
      userCurrency
    );

    this.userMoneyVariation = await this.accountUtils.getAccountsMoneyVariation(
      this.accounts,
      userCurrency,
      this.dateRangeService.startDate,
      this.dateRangeService.endDate
    );

    this.userTotalIncome = await this.accountUtils.getAccountsData('Income', {
      startDate: this.dateRangeService.startDate,
      endDate: this.dateRangeService.endDate,
    });
    this.userTotalExpense = await this.accountUtils.getAccountsData('Expense', {
      startDate: this.dateRangeService.startDate,
      endDate: this.dateRangeService.endDate,
    });
  }

  async getImportantTransactions() {
    if (!this.accounts) this.importantTransactions = undefined;

    const transactions: Transaction[] = (
      await this.transactionService.getTransactions({
        startDate: this.dateRangeService.startDate,
        endDate: this.dateRangeService.endDate,
      })
    )
      .sort((x, y) => x.value - y.value)
      .filter((z) => z.value < 0);

    this.importantTransactions = transactions.slice(0, 5);
  }

  async getHealthyValue() {
    this.healthy = await this.financeHealth.getHealthyValue();

    this.healthyColor = this.financeHealth.getHealthyColor(this.healthy);
    this.healthyReview = this.financeHealth.getHealthyValueReview(this.healthy);

    document.getElementById('health-value').style.color =
      'hsla(' + this.healthyColor + ', 100%, 35%, 1)';

    this.createHealthyChart();
  }

  protected createHealthyChart() {
    const ctx = this.healthyChart.nativeElement;

    const chartData = [this.healthy, 100 - this.healthy];
    const chartColors = [
      'hsla(' + this.healthyColor + ', 100%, 35%, 1)',
      'hsla(' + this.healthyColor + ', 100%, 35%, 0.25)',
    ];

    if (this.healthyChartRef) {
      this.healthyChartRef.data.datasets[0].data = chartData;

      this.healthyChartRef.data.datasets[0].backgroundColor = chartColors;
      this.healthyChartRef.data.datasets[0].borderColor = chartColors;

      this.healthyChartRef.update();
      return;
    }

    //! Type hinting seems to be broken. See: https://github.com/chartjs/Chart.js/issues/10896
    this.healthyChartRef = new Chart(ctx, {
      type: 'doughnut',
      data: {
        datasets: [
          {
            label: this.lang.getTranslation('FINANCIAL-HEALTH.display'),
            data: chartData,
            backgroundColor: chartColors,
            borderColor: chartColors,
            borderWidth: 0,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        rotation: 262,
        circumference: 200,
        plugins: {
          legend: {
            display: false,
          },
        },
        cutout: '80%',
      },
    });
  }

  async openDateModal() {
    /*  const newDateRange = await this.modalService.openDateRangeModal();

    if (newDateRange.data) {
      if (newDateRange.data != DateRange.Custom) {
        this.dateRangeService.dateRangeSelected = newDateRange.data;
        this.reInitializeParams();
        this.getDateRangeData();
      } else {
        const customDateModal =
          await this.modalService.openCustomDateRangeModal();

        customDateModal
          .onDidDismiss()
          .then((hasSubmitted: OverlayEventDetail<boolean>) => {
            if (hasSubmitted.data) {
              this.reInitializeParams();
              this.getDateRangeData();
            }
          });

        return customDateModal.present();
      }
    } */
  }

  goToAddAccount() {
    this.router.navigate(['account-form']);
  }

  previousScroll = 0;
  toggleFab(event: any) {
    if (event.detail.scrollTop > this.previousScroll) {
      document.getElementsByTagName('ion-fab')[0].classList.add('hide');
    } else if (event.detail.scrollTop < this.previousScroll) {
      document.getElementsByTagName('ion-fab')[0].classList.remove('hide');
    }
    this.previousScroll = event.detail.scrollTop;
  }
}
