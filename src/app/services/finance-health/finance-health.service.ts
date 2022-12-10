import { Injectable } from '@angular/core';
import { currentYear } from 'src/app/constants/constants';
import { AccountUtilsService } from '../account-utils/account-utils.service';
import { AccountService } from '../db/account/account.service';
import { DateRangeService } from '../filters/date-range/date-range.service';
import { UtilsService } from '../utils/utils.service';

@Injectable({
  providedIn: 'root',
})
export class FinanceHealthService {
  constructor(
    private accountService: AccountService,
    private accountUtils: AccountUtilsService,
    private utils: UtilsService,
    private dateRangeService: DateRangeService
  ) {}

  /** Returns the number of months that the user can live without income, taking into account their spending rate in the last 12 months. */
  async getMonthsWithoutIncome() {
    const totalExpenses = await this.accountUtils.getAccountsData('Expense', {
      startDate: new Date(new Date().setFullYear(currentYear - 1)),
    });

    const avgPerDay =
      totalExpenses /
      this.utils.getDateDiff(
        new Date(),
        new Date(new Date().setFullYear(currentYear - 1))
      );

    if (avgPerDay === 0) return NaN;

    let currentBalance = await this.accountUtils.getAccountsMoney(
      await this.accountService.getAccounts()
    );
    let daysToReturn = 0;

    while (currentBalance > 0) {
      currentBalance = currentBalance - avgPerDay;
      daysToReturn += 1;
    }

    return Math.floor(daysToReturn / 30);
  }

  /** Get a i18n key usefull to display some info about the number of months without income that the user can live */
  getMonthsWithoutIncomeReview(months: number) {
    if (isNaN(months)) return 'insufficient_data';
    else if (months <= 1) return 'very_bad';
    else if (months < 5) return 'bad';
    else if (months < 10) return 'normal';
    else return 'good';
  }

  /** Returns a number (from 0 to 100) with the user's savings percentage */
  async getSavingPercentage() {
    const accounts = (await this.accountService.getAccounts()).slice();

    const income = await this.accountUtils.getAccountsData('Income', {
      startDate: this.dateRangeService.startDate,
      endDate: this.dateRangeService.endDate,
      accounts,
    });
    const expense = await this.accountUtils.getAccountsData('Expense', {
      startDate: this.dateRangeService.startDate,
      endDate: this.dateRangeService.endDate,
      accounts,
    });

    let result = 0;
    if (income == 0 || (income == 0 && expense == 0)) {
      return result;
    } else {
      result = ((income - expense) / income) * 100;
    }

    if (result <= 0) {
      result = 0;
    }

    return result;
  }

  /** Get a i18n key usefull to display some info about the saving percentage of the user */
  getSavingsPercentageReview(months: number) {
    if (months <= 1) return 'very_bad';
    else if (months < 5) return 'bad';
    else if (months < 10) return 'normal';
    else return 'good';
  }

  /** Get the hsla hue value of the color to display some elements of this module, parting of a value (between 0 and 100).
   *
   * So, the final color to display will usually be "hsla(${getHealthyColor(value)},100%,35%,1)"
   *
   * @param value Usually refers to the healthy value
   */
  getHealthyColor(value: number) {
    /*     let result = Math.pow(value, 1.4);
    if (result > 118) {
      result = 118;
    } */

    return value + 5;
  }

  /** Return a decimal number between 0 and 100 with the healthy value */
  async getHealthyValue() {
    const monthsWithoutIncome = await this.getMonthsWithoutIncome();
    const savingPercentage = await this.getSavingPercentage();

    // 50% savingPercentage + 50% monthsWithoutIncome
    return (
      0.5 * savingPercentage +
      (!isNaN(monthsWithoutIncome)
        ? 5 * Math.min(monthsWithoutIncome, 10)
        : 5 * 2.5)
    );
  }

  /** Get a i18n key usefull to display some info about a healthy value */
  getHealthyValueReview(healthyValue: number) {
    if (healthyValue < 20) return 'very_bad';
    else if (healthyValue < 40) return 'bad';
    else if (healthyValue < 60) return 'normal';
    else if (healthyValue < 80) return 'good';
    else return 'very_good';
  }
}
