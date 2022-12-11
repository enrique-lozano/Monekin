import {
  AfterContentChecked,
  ChangeDetectorRef,
  Component,
  NgZone,
  ViewChild,
} from '@angular/core';
import { Router } from '@angular/router';
import { Currency } from 'src/app/services/currency/currency.model';
import { Budget } from 'src/app/services/db/budget/budget.model';
import { BudgetService } from 'src/app/services/db/budget/budget.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { UtilsService } from 'src/app/services/utils/utils.service';
import { SwiperOptions } from 'swiper';
import { SwiperComponent } from 'swiper/angular';

@Component({
  selector: 'app-budgets',
  templateUrl: './budgets.page.html',
  styleUrls: ['./budgets.page.scss'],
})
export class BudgetsPage implements AfterContentChecked {
  typesOfBudgets = ['week', 'month', 'year'];
  budgets: Budget[];
  currentValues: number[] = []; // Money already spended on each budget
  daysLeft: number[] = []; // Days to finish the budget

  segmentValue: 'Period' | 'One' = 'Period';

  userCurrency: Currency;

  constructor(
    private router: Router,
    public lang: LangService,
    private budgetService: BudgetService,
    private changeDet: ChangeDetectorRef,
    private zone: NgZone,
    private utils: UtilsService
  ) {}

  @ViewChild('swiper') swiper: SwiperComponent;
  config: SwiperOptions = {};
  ngAfterContentChecked() {
    if (this.swiper) {
      this.swiper.updateSwiper({});
    }
  }

  async ionViewWillEnter() {
    this.budgets = await this.budgetService.getBudgets();

    this.getTransactionsValueForBudgets();
  }

  // Go to the next and the prev slide
  next() {
    this.swiper.swiperRef.slideNext();
  }

  prev() {
    this.swiper.swiperRef.slidePrev();
  }

  swiperSlideChanged() {
    if (this.swiper.swiperRef.activeIndex == 0) {
      this.segmentValue = 'Period';
    } else if (this.swiper.swiperRef.activeIndex == 1) {
      this.segmentValue = 'One';
    }

    this.changeDet.detectChanges();
  }

  goToAddBudget() {
    this.router.navigate(['budgets', 'budget-form']);
  }

  /** Returns if a type of budget exists or no. Usefull to prevent the print of the headlines in the DOM when ther aren't budgets
   *
   * @param param Can be: 'year'| 'month' | 'week' | 'no-active' | 'no-pending' | 'no-finished'
   */
  budgetTypeExists(param: string): boolean {
    for (const budget of this.budgets) {
      if (budget.repeat == param) {
        return true;
      } else if (budget.repeat == 'no') {
        if (this.getBudgetState(budget) == 'Active' && param == 'no-active')
          return true;

        if (this.getBudgetState(budget) == 'Finished' && param == 'no-finished')
          return true;

        if (this.getBudgetState(budget) == 'Pending' && param == 'no-pending')
          return true;
      }
    }

    return false;
  }

  /** @returns A percentage value between 0 and 100 (0% - 100%) */
  getPercentageToSpend(current: number, budget: Budget) {
    let value = 100 * (1 - current / budget.limit);
    if (value < 0) value = 0;
    return value;
  }

  /** Get the state of the budget. Only valid for the non-periodacally budgets.
   *
   * @returns A string that can be 'Active' | 'Pending' | 'Finished'
   */
  getBudgetState(budget: Budget): 'Active' | 'Pending' | 'Finished' {
    return this.budgetService.getBudgetState(budget);
  }

  /** Function to get the value of the budget that has been expense already and the days remaining */
  async getTransactionsValueForBudgets() {
    this.currentValues = [];
    this.daysLeft = [];

    for (const budget of this.budgets) {
      const transactions = await this.budgetService.getBudgetTransactions(
        budget
      );

      let valueToPush = 0;
      transactions.forEach((trans) => {
        valueToPush += Math.abs(trans.value);
      });

      this.currentValues.push(Math.round(valueToPush));

      this.daysLeft.push(await this.budgetService.getBudgetDaysLeft(budget));
    }
  }

  getBarColor(percentage: number) {
    return this.utils.hslToHex(percentage, 100, 35);
  }
}
