import { formatDate, formatNumber, TranslationWidth } from '@angular/common';
import {
  ChangeDetectorRef,
  Component,
  ElementRef,
  Inject,
  Input,
  LOCALE_ID,
  OnChanges,
  OnInit,
  ViewChild,
} from '@angular/core';
import { PopoverController } from '@ionic/angular';
import { OverlayEventDetail } from '@ionic/core';
import Chart from 'chart.js/auto';
import { AccountUtilsService } from 'src/app/services/account-utils/account-utils.service';
import { AccountService } from 'src/app/services/db/account/account.service';
import {
  Category,
  MainCategory,
} from 'src/app/services/db/category/category.model';
import { SettingsService } from 'src/app/services/db/settings/settings.service';
import { Transaction } from 'src/app/services/db/transaction/transaction.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { DateRange } from 'src/app/services/filters/date-range/date-range.enum';
import { DateRangeService } from 'src/app/services/filters/date-range/date-range.service';
import { FilterService } from 'src/app/services/filters/filter.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { UtilsService } from 'src/app/services/utils/utils.service';
import { SelectTypeOfCategoryComponent } from '../select-type-of-category/select-type-of-category.component';

@Component({
  selector: 'app-statistics',
  templateUrl: './statistics.component.html',
  styleUrls: ['./statistics.component.scss'],
})
export class StatisticsComponent implements OnInit, OnChanges {
  protected transactions: Transaction[];
  @Input() startDate: Date;
  @Input() endDate: Date;

  @ViewChild('balanceChart') balanceChart: ElementRef<HTMLCanvasElement>;
  balanceChartRef: Chart;

  months: string[];
  weekDays: string[];
  firstDayOfWeek: number;

  categoriesToShow: 'income' | 'expense' = 'expense';
  categoriesExpense: {
    category: MainCategory;
    transactions: Transaction[];
    value: number;
  }[] = [];
  categoriesIncome: {
    category: MainCategory;
    transactions: Transaction[];
    value: number;
  }[] = [];

  totalExpenses = 0;
  totalIncomes = 0;
  balance = 0;
  variation = 0;

  dateDiff: number;

  @ViewChild('evolutionChart') evolutionChart: ElementRef<HTMLCanvasElement>;
  evolutionChartRef: Chart;

  loading: boolean;

  constructor(
    private popoverController: PopoverController,
    private lang: LangService,
    @Inject(LOCALE_ID) private readonly userLocale: string,
    public filterService: FilterService,
    private dateRangeService: DateRangeService,
    private utils: UtilsService,
    private changeDet: ChangeDetectorRef,
    private modal: IonModalService,
    private accountService: AccountService,
    private readonly transactionService: TransactionService,
    private readonly accountUtils: AccountUtilsService,
    private readonly settings: SettingsService
  ) {
    this.settings
      .getSettings()
      .then((res) => (this.firstDayOfWeek = res.firstDayOfWeek));
  }

  async ngOnInit() {
    this.months = this.utils.getMonthArray(TranslationWidth.Abbreviated);

    this.weekDays = await this.utils.getDayWeeksArray(
      TranslationWidth.Short,
      false
    );
  }

  async ngOnChanges() {
    if ((this.startDate && this.endDate) || this.balanceChartRef) {
      this.loading = true;
      this.changeDet.detectChanges();

      this.transactions = await this.transactionService.getTransactions(
        {
          startDate: this.startDate,
          endDate: this.endDate,
          accountIds:
            this.filterService.selectedAccounts == 'all'
              ? 'all'
              : this.filterService.selectedAccounts.map((x) => x.id),
          categoriesIds:
            this.filterService.selectedCategories == 'all'
              ? 'all'
              : this.filterService.selectedCategories.map((x) => x.id),
        },
        (
          await this.settings.getSettings()
        ).preferredCurrency
      );

      if (this.filterService.selectedCategories != 'all')
        this.evolutionChartRef = undefined;

      this.dateDiff = this.utils.getDateDiff(this.endDate, this.startDate);

      this.getNumericalStats();
      this.getCategoriesInfo();

      await new Promise((r) => setTimeout(r, 800));

      this.createBalanceChart();
      this.createEvolutionChart();

      this.loading = false;
      this.changeDet.detectChanges();
    }
  }

  /** Get stats that don't require a heavy DOM update. The creation of graphics and animations will therefore be left out of this function */
  async getNumericalStats() {
    this.totalExpenses = await this.accountUtils.getAccountsData('Expense', {
      startDate: this.startDate,
      endDate: this.endDate,
      accounts: this.filterService.selectedAccounts,
      categoriesIDs:
        this.filterService.selectedCategories == 'all'
          ? 'all'
          : this.filterService.selectedCategories.map((x) => x.id),
    });

    this.totalIncomes = await this.accountUtils.getAccountsData('Income', {
      startDate: this.startDate,
      endDate: this.endDate,
      accounts: this.filterService.selectedAccounts,
      categoriesIDs:
        this.filterService.selectedCategories == 'all'
          ? 'all'
          : this.filterService.selectedCategories.map((x) => x.id),
    });

    const accountToSearch =
      this.filterService.selectedAccounts == 'all'
        ? await this.accountService.getAccounts()
        : this.filterService.selectedAccounts;

    this.balance = await this.accountUtils.getAccountsMoney(
      accountToSearch,
      undefined,
      this.endDate
    );

    this.variation = await this.accountUtils.getAccountsMoneyVariation(
      accountToSearch,
      undefined,
      this.startDate,
      this.endDate
    );
  }

  async selectTypeOfCategoryToShow(event: any) {
    const popover = await this.popoverController.create({
      event,
      component: SelectTypeOfCategoryComponent,
      componentProps: {
        currentSelection: this.categoriesToShow,
      },
    });

    await popover.present();

    popover
      .onDidDismiss()
      .then((res: OverlayEventDetail<'expense' | 'income'>) => {
        if (res.data) this.categoriesToShow = res.data;
      });
  }

  createBalanceChart() {
    const ctx = this.balanceChart.nativeElement;
    Chart.defaults.font.size = 12;
    Chart.defaults.maintainAspectRatio = false;

    const chartData = this.getDataByPeriods();

    if (this.balanceChartRef) {
      this.balanceChartRef.data.labels = chartData.labels;
      this.balanceChartRef.data.datasets[0].data = chartData.balance;
      this.balanceChartRef.data.datasets[1].data = chartData.income;
      this.balanceChartRef.data.datasets[2].data = chartData.expense;

      this.balanceChartRef.update();
      return;
    }

    this.balanceChartRef = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: chartData.labels,
        datasets: [
          {
            type: 'line',
            label: this.lang.getTranslation('TABS.TAB2.balance'),
            data: chartData.balance, // array should have same number of elements as number of dataset
            backgroundColor: 'rgba(0,0,0,0)',
            borderColor: 'rgba(0,83,211,0.5)',
            borderWidth: 3,
            tension: 0.1,
          },
          {
            label: this.lang.getTranslation('GENERAL.income'),
            data: chartData.income,
            backgroundColor: getComputedStyle(
              document.documentElement
            ).getPropertyValue('--ion-color-success'),
            borderColor: getComputedStyle(
              document.documentElement
            ).getPropertyValue('--ion-color-success-contrast'),
            borderWidth: 0,
            borderRadius: 5,
          },
          {
            label: this.lang.getTranslation('GENERAL.expense'),
            data: chartData.expense,
            backgroundColor: getComputedStyle(
              document.documentElement
            ).getPropertyValue('--ion-color-danger'),
            borderColor: getComputedStyle(
              document.documentElement
            ).getPropertyValue('--ion-color-danger-contrast'),
            borderWidth: 0,
            borderRadius: 5,
          },
        ],
      },
      options: {
        responsive: true,
        scales: {
          x: {
            stacked: true,
            grid: {
              display: false,
            },
          },
          y: {
            stacked: true,
            suggestedMax: 20,
            suggestedMin: -20,
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

  getDataByPeriods(
    dateRangeSelected: DateRange = this.dateRangeService.dateRangeSelected
  ) {
    const balance: number[] = [];
    const income: number[] = [];
    const expense: number[] = [];

    let labels: string[] = [];

    if (dateRangeSelected == DateRange.Weekly) {
      labels = this.weekDays;

      for (let i = 0; i < this.weekDays.length; i++) {
        let toPushIncome = 0;
        let toPushExpense = 0;

        this.transactions.forEach((transaction) => {
          let transDay = transaction.date.getDay() - this.firstDayOfWeek;

          if (transDay < 0) {
            transDay = this.weekDays.length - this.firstDayOfWeek;
          }
          if (transDay == i) {
            if (transaction.value > 0) toPushIncome += transaction.value;
            else if (transaction.value < 0) toPushExpense += transaction.value;
          }
        });

        income.push(toPushIncome);
        expense.push(toPushExpense);
        balance.push(toPushIncome + toPushExpense);
      }
    } else if (dateRangeSelected == DateRange.Monthly) {
      [
        [1, 5],
        [6, 10],
        [11, 15],
        [16, 20],
        [21, 25],
        [26, 80],
      ].forEach((el) => {
        labels.push(el[0] + '-' + (el[1] < 79 ? el[1] : ''));

        let toPushIncome = 0;
        let toPushExpense = 0;

        this.transactions.forEach((transaction) => {
          if (
            transaction.date.getDate() >= el[0] &&
            transaction.date.getDate() <= el[1]
          ) {
            if (transaction.value > 0) toPushIncome += transaction.value;
            else if (transaction.value < 0) toPushExpense += transaction.value;
          }
        });

        income.push(toPushIncome);
        expense.push(toPushExpense);
        balance.push(toPushIncome + toPushExpense);
      });
    } else if (dateRangeSelected == DateRange.Infinite) {
      /** Year to start in the graph */ let oldestYear: number;

      if (this.transactions.length === 0) {
        oldestYear = new Date().getFullYear() - 5;
      } else {
        if (this.dateRangeService.dateRangeSelected === DateRange.Custom) {
          oldestYear = this.startDate.getFullYear();
        } else {
          oldestYear = this.transactions
            .sort((x, y) => x.date.getTime() - y.date.getTime())[0]
            .date.getFullYear();
        }
      }

      for (let i = oldestYear; i < new Date().getFullYear() + 1; i++) {
        labels.push(String(i));

        let toPushIncome = 0;
        let toPushExpense = 0;

        this.transactions.forEach((transaction) => {
          if (transaction.date.getFullYear() == i) {
            if (transaction.value > 0) toPushIncome += transaction.value;
            else if (transaction.value < 0) toPushExpense += transaction.value;
          }
        });

        income.push(toPushIncome);
        expense.push(toPushExpense);
        balance.push(toPushIncome + toPushExpense);
      }
    } else if (dateRangeSelected == DateRange.Quaterly) {
      for (
        let i = this.startDate.getMonth();
        i < this.startDate.getMonth() + 3;
        i++
      ) {
        labels.push(this.months[i]);

        let toPushIncome = 0;
        let toPushExpense = 0;

        this.transactions.forEach((transaction) => {
          if (transaction.date.getMonth() == i) {
            if (transaction.value > 0) toPushIncome += transaction.value;
            else if (transaction.value < 0) toPushExpense += transaction.value;
          }
        });

        income.push(toPushIncome);
        expense.push(toPushExpense);
        balance.push(toPushIncome + toPushExpense);
      }
    } else if (dateRangeSelected == DateRange.Annualy) {
      for (let i = 0; i < 12; i++) {
        labels.push(this.months[i]);

        let toPushIncome = 0;
        let toPushExpense = 0;

        this.transactions.forEach((transaction) => {
          if (transaction.date.getMonth() == i) {
            if (transaction.value > 0) toPushIncome += transaction.value;
            else if (transaction.value < 0) toPushExpense += transaction.value;
          }
        });

        income.push(toPushIncome);
        expense.push(toPushExpense);
        balance.push(toPushIncome + toPushExpense);
      }
    } else {
      if (this.dateDiff <= 7) return this.getDataByPeriods(DateRange.Weekly);
      else if (this.dateDiff < 31)
        return this.getDataByPeriods(DateRange.Monthly);
      else if (this.dateDiff < 365)
        return this.getDataByPeriods(DateRange.Annualy);
      else return this.getDataByPeriods(DateRange.Infinite);
    }

    return {
      income,
      expense,
      balance,
      labels,
    };
  }

  getCategoriesInfo() {
    this.categoriesExpense = [];
    this.categoriesIncome = [];

    // EXPENSES:

    this.transactions
      .filter((x) => x.value < 0)
      .forEach((transaction) => {
        const categoryToEdit = this.categoriesExpense.find(
          (cat) =>
            cat.category?.id == transaction.category?.id ||
            cat.category?.id == transaction.category?.parentCategory?.id
        );

        if (categoryToEdit) {
          categoryToEdit.value += Math.abs(transaction.value);
          categoryToEdit.transactions.push(transaction);
        } else {
          this.categoriesExpense.push({
            category:
              transaction.category instanceof MainCategory
                ? transaction.category
                : transaction.category.parentCategory,
            value: Math.abs(transaction.value),
            transactions: [transaction],
          });
        }
      });

    this.categoriesExpense.sort((x, y) => y.value - x.value);

    // INCOMES:

    this.transactions
      .filter((x) => x.value > 0)
      .forEach((transaction) => {
        const categoryToEdit = this.categoriesIncome.find(
          (cat) =>
            cat.category?.id == transaction.category?.id ||
            cat.category?.id == transaction.category?.parentCategory?.id
        );
        if (categoryToEdit) {
          categoryToEdit.value += transaction.value;
          categoryToEdit.transactions.push(transaction);
        } else {
          this.categoriesIncome.push({
            category:
              transaction.category instanceof MainCategory
                ? transaction.category
                : transaction.category.parentCategory,
            value: transaction.value,
            transactions: [transaction],
          });
        }
      });

    this.categoriesIncome.sort((x, y) => y.value - x.value);
  }

  async openCategoryStats(item: {
    category: Category;
    transactions: Transaction[];
    value: number;
  }) {
    const modal = await this.modal.openCategoryStatsModal(item);

    modal.present();
  }

  async createEvolutionChart() {
    if (this.filterService.selectedCategories != 'all') return;

    const ctx = this.evolutionChart.nativeElement;

    const chartData = (await this.getEvolutionChartData()).data;
    const chartLabels = (await this.getEvolutionChartData()).labels;

    if (this.evolutionChartRef) {
      this.evolutionChartRef.data.labels = chartLabels;
      this.evolutionChartRef.data.datasets[0].data = chartData;
      this.evolutionChartRef.update();
      return;
    }

    const gradient = ctx.getContext('2d').createLinearGradient(0, 0, 0, 600);
    const ionColorPrimary = getComputedStyle(
      document.documentElement
    ).getPropertyValue('--ion-color-primary-rgb');

    gradient.addColorStop(1, `rgba(${ionColorPrimary}, 0)`);
    gradient.addColorStop(0, `rgba(${ionColorPrimary}, 0.4)`);

    this.evolutionChartRef = new Chart(ctx, {
      type: 'line',
      data: {
        labels: chartLabels,
        datasets: [
          {
            label: this.lang.getTranslation('TABS.TAB2.balance'),
            data: chartData,
            backgroundColor: gradient,
            borderColor: getComputedStyle(
              document.documentElement
            ).getPropertyValue('--ion-color-primary'),
            borderWidth: 3,
            fill: true,
            tension: 0.1,
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
            ticks: {
              display: false,
            },
          },
          y: {
            suggestedMax: 100,

            ticks: {
              callback(x, index, ticks) {
                x = Number(x);

                let result: string;

                /** Difference between the bigger label and the smallest one */
                const valueMaxDiff = Math.abs(
                  ticks[0].value - ticks[ticks.length - 1].value
                );

                function getResultFromRange(value: number, range: number) {
                  const decimalFormat =
                    valueMaxDiff > range ? '1.1-1' : '1.0-0';

                  if (
                    index === 0 ||
                    index === ticks.length - 1 ||
                    (Math.abs(ticks[index].value - ticks[0].value) >= range &&
                      Math.abs(
                        ticks[index].value - ticks[ticks.length - 1].value
                      ) >= range)
                  ) {
                    const floorNumber = Math.floor(value / range) / 10;
                    return formatNumber(floorNumber, 'en', decimalFormat) + 'K';
                  } else {
                    return undefined;
                  }
                }

                // TODO: Check how we can access this.lang

                if (x >= 1000000000 || x <= -1000000000) {
                  result = getResultFromRange(x, 100000000);
                } else if (x >= 1000000 || x <= -1000000) {
                  result = getResultFromRange(x, 100000);
                } else if (x >= 1000 || x <= -1000) {
                  result = getResultFromRange(x, 100);
                } else {
                  result = String(ticks[index].value);
                }

                let lastLabelIndex = ticks.length;
                while (lastLabelIndex--) {
                  if (ticks[lastLabelIndex].label != undefined) break;
                }

                if (
                  index === 0 ||
                  index === ticks.length - 1 ||
                  result != ticks[lastLabelIndex].label
                )
                  return result;
              },
            },
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

  async getEvolutionChartData() {
    const labels: string[] = [];
    const data: number[] = [];

    let balance = await this.accountUtils.getAccountsMoney(
      await this.accountService.getAccounts(),
      undefined,
      this.startDate
    );

    const stepDays = 1000 * 60 * 60 * 24;

    for (
      let i = this.startDate
        ? this.startDate.getTime()
        : this.transactions
            .sort((x, y) => x.date.getTime() - y.date.getTime())[0]
            .date.getTime();
      i < (this.endDate ? this.endDate.getTime() : new Date().getTime());
      i += stepDays
    ) {
      const loopDay = new Date(i);

      this.transactions.forEach((transaction) => {
        if (
          transaction.date.getDate() == loopDay.getDate() &&
          transaction.date.getMonth() == loopDay.getMonth() &&
          transaction.date.getFullYear() == loopDay.getFullYear()
        ) {
          balance += transaction.value;
        }
      });

      data.push(balance);
      labels.push(formatDate(loopDay, 'mediumDate', this.userLocale));
    }

    return { data, labels };
  }
}
