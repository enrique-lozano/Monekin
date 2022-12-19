import { Injectable } from '@angular/core';
import {
  currentDay,
  currentMonth,
  currentYear,
} from 'src/app/constants/constants';
import { Budget } from 'src/app/services/db/budget/budget.model';
import { Transaction } from 'src/app/services/db/transaction/transaction.model';
import { UtilsService } from '../../utils/utils.service';
import { SettingsService } from '../settings/settings.service';
import { TransactionService } from '../transaction/transaction.service';
import { UserDataService } from '../user-data.service';

@Injectable({
  providedIn: 'root',
})
export class BudgetService {
  private budgets: Budget[];

  constructor(
    private readonly transactionService: TransactionService,
    private utils: UtilsService,
    private settings: SettingsService,
    private userDataService: UserDataService
  ) {}

  async getBudgets() {
    if (!this.budgets) {
      await this.refreshBudgets();
    }

    return this.budgets;
  }

  async refreshBudgets() {
    this.budgets = (await this.userDataService.getUserData()).budgets || [];
    this.budgets = this.budgets.map((x) => new Budget(x));
  }

  addBudget(budget: Budget) {
    if (!(budget instanceof Budget))
      throw new Error('You should pass an instance of a class to this method');

    this.budgets.push(budget);

    return this.userDataService.setUserData({ budgets: this.budgets });
  }

  editBudget(newBudgetObject: Budget, budgetToEditName: string) {
    if (!(newBudgetObject instanceof Budget))
      throw new Error('You should pass an instance of a class to this method');

    this.budgets = this.budgets.map((budget) => {
      if (budget.name === budgetToEditName) return newBudgetObject;
      else return budget;
    });

    return this.userDataService.setUserData({ budgets: this.budgets });
  }

  deleteBudget(budgetName: string) {
    this.budgets = this.budgets.filter((bud) => bud.name != budgetName);

    return this.userDataService.setUserData({ budgets: this.budgets });
  }

  /** Get the state of the budget. Only valid for the non-periodacally budgets.
   *
   * @returns A string that can be 'Active' | 'Pending' | 'Finished'
   */
  getBudgetState(budget: Budget) {
    if (budget.repeat != 'no') {
      throw new Error("Budget repeat type should be set to 'no'");
    }
    const currentDate = new Date(currentYear, currentMonth, currentDay);
    const budgetDate = new Date(budget.startDate);
    const budgetEndDate = new Date(budget.endDate);

    if (currentDate > budgetDate && currentDate < budgetEndDate) {
      return 'Active';
    } else if (currentDate < budgetDate) {
      return 'Pending';
    } else if (currentDate > budgetEndDate) {
      return 'Finished';
    }
  }

  /** Get all the transactions involved in a budget. The transactions returned will be ordered by date */
  async getBudgetTransactions(budget: Budget) {
    let result: Transaction[];

    const userPreferredCurrency = (await this.settings.getSettings())
      .preferredCurrency;

    if (budget.repeat == 'month') {
      result = await this.transactionService.getTransactions(
        {
          startDate: new Date(currentYear, currentMonth, 1),
          endDate: new Date(currentYear, currentMonth + 1, 1),
          accountIds: budget.accounts,
          categoriesIds: budget.categories,
        },
        userPreferredCurrency
      );
    } else if (budget.repeat == 'week') {
      const startDate = await this.utils.getDateOfFirstDayOfWeek();
      result = await this.transactionService.getTransactions(
        {
          startDate,
          endDate: new Date(
            startDate.getFullYear(),
            startDate.getMonth(),
            startDate.getDate() + 7
          ),
          accountIds: budget.accounts,
          categoriesIds: budget.categories,
        },
        userPreferredCurrency
      );
    } else if (budget.repeat == 'year') {
      result = await this.transactionService.getTransactions(
        {
          startDate: new Date(currentYear, 0, 1),
          endDate: new Date(currentYear + 1, 0, 1),
          accountIds: budget.accounts,
          categoriesIds: budget.categories,
        },
        userPreferredCurrency
      );
    } else if (budget.repeat == 'no') {
      result = await this.transactionService.getTransactions(
        {
          startDate: budget.startDate,
          endDate: budget.endDate,
          accountIds: budget.accounts,
          categoriesIds: budget.categories,
        },
        userPreferredCurrency
      );
    }

    result = result
      .filter((trans) => trans.value < 0)
      .sort((a, b) => (a.date < b.date ? 1 : -1));

    return result;
  }

  async getBudgetDaysLeft(budget: Budget) {
    let daysLeft: number;

    if (budget.repeat == 'month') {
      daysLeft = this.utils.getDateDiff(
        new Date(currentYear, currentMonth + 1, 0),
        new Date()
      );
    } else if (budget.repeat == 'week') {
      const startDate = await this.utils.getDateOfFirstDayOfWeek();

      daysLeft = this.utils.getDateDiff(
        new Date(
          startDate.getFullYear(),
          startDate.getMonth(),
          startDate.getDate() + 7
        ),
        new Date()
      );
    } else if (budget.repeat == 'year') {
      daysLeft = this.utils.getDateDiff(
        new Date(currentYear, 11, 31),
        new Date()
      );
    } else if (budget.repeat == 'no') {
      if (this.getBudgetState(budget) == 'Active') {
        daysLeft = this.utils.getDateDiff(budget.endDate, new Date());
      } else if (this.getBudgetState(budget) == 'Finished') {
        daysLeft = this.utils.getDateDiff(new Date(), budget.endDate);
      } else if (this.getBudgetState(budget) == 'Pending') {
        daysLeft = this.utils.getDateDiff(budget.startDate, new Date());
      }
    }

    return Math.ceil(daysLeft);
  }
}
