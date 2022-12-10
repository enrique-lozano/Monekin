import { Injectable } from '@angular/core';
import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';
import { ExchangeRatesService } from '../currency/exchange-rates.service';
import { Account } from '../db/account/account.model';
import { AccountService } from '../db/account/account.service';
import { SettingsService } from '../db/settings/settings.service';
import { TransactionService } from '../db/transaction/transaction.service';

@Injectable({
  providedIn: 'root',
})
export class AccountUtilsService {
  constructor(
    private readonly accountService: AccountService,
    private settingService: SettingsService,
    private exchangeService: ExchangeRatesService,
    private readonly transactionsService: TransactionService
  ) {}

  /** Get the amount of money that an account had at a given time, in the currency of the account */
  protected async getAccountMoney(account: Account, date: Date) {
    const result = account.iniValue;

    const balance = await this.getAccountsData(
      'Balance',
      {
        endDate: date,
        accounts: [account],
      },
      account.currency
    );

    return result + balance;
  }

  /** Get the amount of money that exists in an array of accounts for a specific date
   *
   * @param accounts
   * @param currency Currency to convert the result to. If not specified, the user's preferred currency will be used, unless only one account is passed as a parameter, in which case the currency of that account will be used.
   * @param date If specified, the function will return the amount of money that the accounts have in that moment. Defaults to the current time. That is, if not specified, retrieves the amount of money in the accounts right now
   */
  async getAccountsMoney(
    accounts: Account[],
    currency?: ISOCorrencyCodes,
    date: Date = new Date()
  ) {
    if (!currency) {
      currency =
        accounts.length == 1
          ? accounts[0].currency
          : (await this.settingService.getSettings()).preferredCurrency;
    }

    let totalBalance = 0;

    for (const account of accounts) {
      const exchangeRate = await this.exchangeService.getExchangeRate(
        account.currency,
        currency
      );

      totalBalance +=
        (await this.getAccountMoney(account, date)) * exchangeRate;
    }

    return totalBalance;
  }

  /** Get the variation of money for a period of time and for specific accounts (in percentage)
   *
   * @param accounts
   * @param currency Currency to convert the result to. If not specified, the user's preferred currency will be used, unless only one account is passed as a parameter, in which case the currency of that account will be used.
   *
   * @return A number between 0 and 1 with the required percentage
   */
  async getAccountsMoneyVariation(
    accounts: Account[],
    currency?: ISOCorrencyCodes,
    startDate?: Date,
    endDate: Date = new Date()
  ) {
    const variation = await this.getAccountsData(
      'Balance',
      {
        accounts,
        startDate,
        endDate,
      },
      currency
    );

    const totalBalance = await this.getAccountsMoney(
      accounts,
      currency,
      endDate
    );

    const accountBalancePrevPeriod = totalBalance - variation;

    return (totalBalance - accountBalancePrevPeriod) / accountBalancePrevPeriod;
  }

  /** Get information about user accounts, based on certain filters.
   *
   * @param data The info to get. Eye! Do not confuse balance with the amount of money in the account. In this case it simply refers to (income - expenses)
   * @param filters Filters to apply
   * @param currency Currency to convert the result to. If not specified, the user's preferred currency will be used, unless only one account is passed in the filters, in which case the currency of that account will be used.
   *
   * @returns The income/expense/balance absolute value
   * */
  async getAccountsData(
    data: 'Income' | 'Expense' | 'Balance',
    filters?: {
      /** Date from which to start looking for movements. If not specified, the function will start searching from the beginning of time */
      startDate?: Date;

      /** Date up to which to search for movements. If not specified, the function will not have a search deadline. */
      endDate?: Date;

      /** A search text, useful to filter or search transactions by category or description */
      queryText?: string;

      /** If specified, the results will refer only to the accounts in this array. If not, all user accounts will be used to get the result */
      accounts?: 'all' | Account[];

      /** If specified and not equal to "all", the results will be filtered by the IDs of the categories in this array */
      categoriesIDs?: 'all' | string[];
    },

    currency?: ISOCorrencyCodes
  ) {
    let result = 0;

    if (!(await this.accountService.getAccounts())) return result;

    if (!currency) {
      currency =
        filters?.accounts != 'all' && filters?.accounts?.length == 1
          ? filters.accounts[0].currency
          : (await this.settingService.getSettings()).preferredCurrency;
    }

    const transactions = await this.transactionsService.getTransactions(
      {
        startDate: filters?.startDate,
        endDate: filters?.endDate,
        accountIds:
          filters?.accounts == 'all'
            ? 'all'
            : filters?.accounts?.map((x) => x.id),
        categoriesIds:
          filters?.categoriesIDs == 'all' ? 'all' : filters?.categoriesIDs,
        queryText: filters?.queryText,
      },
      currency
    );

    for (const trans of transactions) {
      if (data == 'Balance') {
        result += trans.value;
      } else if (data == 'Expense' && trans.value < 0) {
        result += Math.abs(trans.value);
      } else if (data == 'Income' && trans.value > 0) {
        result += trans.value;
      }
    }

    // TRANSFERS CALCULATIONS:

    // We do not want the transfers if the data to get is Expense/Income. Also, since the transfer between account don't influence the total balance, we do not make any modifications in it if all the accounts are selected
    if (data != 'Balance' || !filters?.accounts || filters?.accounts == 'all')
      return result;

    const transfers = await this.transactionsService.getTransactions({
      startDate: filters?.startDate,
      endDate: filters?.endDate,
      accountIds: filters?.accounts.map((x) => x.id),
      queryText: filters?.queryText,
      typeOfTransaction: 'Transfer',
    });

    const accountsInFilter = filters.accounts as Account[];

    accountsInFilter.forEach((account) => {
      transfers.forEach((transfer) => {
        if (
          accountsInFilter.some((x) => x.id == transfer.account.id) &&
          accountsInFilter.some((x) => x.id == transfer.receivingAccount.id)
        ) {
          return;
        }

        if (account.id == transfer.account.id) result -= transfer.value;
        if (account.id == transfer.receivingAccount.id)
          result += transfer.valueInDestiny ?? transfer.value;
      });
    });

    return result;
  }
}
