import { Injectable } from '@angular/core';
import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';
import {
  MainCategory,
  unknownCategory,
} from 'src/app/services/db/category/category.model';
import {
  IncomeOrExpense,
  RecurrentOption,
  Transaction,
  TransactionInStorage,
  Transfer,
} from 'src/app/services/db/transaction/transaction.model';
import { ExchangeRatesService } from '../../currency/exchange-rates.service';
import { LangService } from '../../translate/translate.service';
import { AccountService } from '../account/account.service';
import { CategoryService } from '../category/category.service';
import { UserDataService } from '../user-data.service';

@Injectable({
  providedIn: 'root',
})
export class TransactionService {
  private transactions: Transaction[];

  constructor(
    private readonly accountService: AccountService,
    private readonly categoryService: CategoryService,
    private lang: LangService,
    private exchangeService: ExchangeRatesService,
    private userDataService: UserDataService
  ) {}

  addTransaction(transaction: Transaction) {
    if (
      !(
        transaction instanceof IncomeOrExpense ||
        transaction instanceof Transfer
      )
    )
      throw new Error('You should pass an instance of a class to this method');

    this.transactions.push(transaction);

    return this.userDataService.setUserData({
      transactions: this.transactionsToStorage(this.transactions),
    });
  }

  /** Removes a transaction
   *
   * @param id The id of the transaction to remove
   */
  async removeTransaction(id: string) {
    this.transactions = this.transactions.filter((x) => x.id != id);

    return this.userDataService.setUserData({
      transactions: this.transactionsToStorage(this.transactions),
    });
  }

  /** Edits a transaction
   *
   * @param uuid The id of the transaction to edit
   * @param editedTransaction The new transaction instance to replace the found transaction
   */
  editTransaction(uuid: string, editedTransaction: Transaction) {
    if (
      !(
        editedTransaction instanceof IncomeOrExpense ||
        editedTransaction instanceof Transfer
      )
    )
      throw new Error('You should pass an instance of a class to this method');

    this.transactions = this.transactions.map((trans) => {
      if (trans.id === uuid) return editedTransaction;
      else return trans;
    });

    return this.userDataService.setUserData({
      transactions: this.transactionsToStorage(this.transactions),
    });
  }

  async refreshTransactions() {
    this.transactions = await this.transactionsToMemory(
      (
        await this.userDataService.getUserData()
      ).transactions
    );
  }

  transactionsToStorage(transactions: Transaction[]) {
    return transactions.map((x) => {
      const result: TransactionInStorage = {
        accountID: x.account.id,
        date: x.date,
        id: x.id,
        value: x.value,
        ...(x.text && { text: x.text }),
        ...(x.valueInDestiny && { valueInDestiny: x.valueInDestiny }),
        ...(x.category && { categoryID: x.category.id }),
        ...(x.receivingAccount && {
          receivingAccountID: x.receivingAccount.id,
        }),
        ...(x.repeat && { repeat: x.repeat }),
      };

      return result;
    });
  }

  async transactionsToMemory(transactionsInStorage: TransactionInStorage[]) {
    const transactions: Transaction[] = [];

    for (const x of transactionsInStorage) {
      if (x.categoryID) {
        transactions.push(
          new IncomeOrExpense({
            account: await this.accountService.getAccountByUUID(x.accountID),
            date: x.date,
            id: x.id,
            value: x.value,
            ...(x.text && { text: x.text }),
            ...(x.repeat && { repeat: x.repeat }),
            category:
              (await this.categoryService.getCategoryByUUID(x.categoryID)) ??
              new MainCategory({
                ...unknownCategory,
                name: this.lang.getTranslation('CATEGORIES.unknown'),
              }),
          })
        );
      } else if (x.receivingAccountID) {
        transactions.push(
          new Transfer({
            account: await this.accountService.getAccountByUUID(x.accountID),
            date: x.date,
            id: x.id,
            value: x.value,
            ...(x.text && { text: x.text }),
            ...(x.valueInDestiny && { valueInDestiny: x.valueInDestiny }),
            ...(x.repeat && { repeat: x.repeat }),
            receivingAccount: await this.accountService.getAccountByUUID(
              x.receivingAccountID
            ),
          })
        );
      }
    }

    return transactions;
  }

  async getTransactionById(id: string) {
    if (!this.transactions) await this.refreshTransactions();

    return this.transactions.find((x) => x.id === id);
  }

  getTransactionIcon(trans: Transaction) {
    if (trans instanceof IncomeOrExpense) {
      return trans.category.icon;
    } else if (trans instanceof Transfer) {
      return 'swap-vertical';
    }
  }

  getTransactionColor(trans: Transaction) {
    if (trans instanceof IncomeOrExpense) {
      return this.categoryService.getCategoryColor(trans.category);
    } else if (trans instanceof Transfer) {
      return getComputedStyle(document.documentElement).getPropertyValue(
        '--ion-color-primary'
      );
    }
  }

  /** Get the transactions of the user
   *
   * @param filters Filter the transactions to be returned based on certain parameters. If not specified, it will return all the expenses and income of the user
   * @param convertToCurrency If specified, the value of each transaction will be converted to the indicated currency.
   * @param getRecurrentTransactions If true, it will calculate and return all transactions related to recurring transactions as well. Defaults to true
   */
  async getTransactions(
    filters?: {
      /** Date from which to start looking for movements. If not specified, the function will start searching from the beginning of time */
      startDate?: Date;

      /** Date up to which to search for movements. If not specified, the function will not have a search deadline. */
      endDate?: Date;

      /** If specified and not equal to "all", the results will be filtered by the ids of the accounts in this array */
      accountIds?: 'all' | string[];

      /** A search text, useful to filter or search transactions by category or description */
      queryText?: string;

      /** Useful to search only the transfers between accounts, or to search only the movements that are expenses/income.
       *
       * @default "IncomeOrExpense"
       */
      typeOfTransaction?: 'all' | 'IncomeOrExpense' | 'Transfer';

      /** If specified and not equal to "all", the results will be filtered by the ids of the categories in this array. If we introduce a mainCategory, the transactions of its subcategories will appear to */
      categoriesIds?: 'all' | string[];
    },
    convertToCurrency?: ISOCorrencyCodes,
    getRecurrentTransactions = true
  ) {
    if (!this.transactions) await this.refreshTransactions();

    let results: Transaction[] = [];

    const pushTransToResult = (x: Transaction) => {
      if (x instanceof IncomeOrExpense) {
        results.push(new IncomeOrExpense(x));
      } else if (x instanceof Transfer) {
        results.push(new Transfer(x));
      } else {
        console.warn(
          'A transaction must be an instance of IncomeOrExpense or Transfer'
        );
      }
    };

    // PUSH ALL TRANSACTIONS:
    this.transactions.forEach((x) => {
      if (x.repeat) {
        if (getRecurrentTransactions) {
          this.getTransactionsOfRecurringTransaction(
            x,
            filters?.startDate,
            filters?.endDate
          ).forEach((trans) => {
            if (trans.category) {
              results.push(new IncomeOrExpense(trans as IncomeOrExpense));
            } else if (trans.receivingAccount) {
              results.push(new Transfer(trans as Transfer));
            } else {
              console.warn(
                'Looks like this recurrent transaction is not IncomeOrExpense or Transfer'
              );
            }
          });
        } else {
          pushTransToResult(x);
        }
      } else {
        pushTransToResult(x);
      }
    });

    if (convertToCurrency) {
      for (const trans of results) {
        if (trans.account.currency != convertToCurrency) {
          trans.value =
            trans.value *
            (await this.exchangeService.getExchangeRate(
              trans.account.currency,
              convertToCurrency
            ));
        }
      }
    }

    if (!filters) return results.filter((x) => x instanceof IncomeOrExpense);

    // APPLY FILTERS:

    // Filter by dates:
    if (filters.startDate) {
      results = results.filter((x) => x.date > filters.startDate);
    }
    if (filters.endDate) {
      results = results.filter((x) => x.date < filters.endDate);
    }

    // Filter by accounts:
    if (filters.accountIds && filters.accountIds != 'all') {
      results = results.filter(
        (x) =>
          filters.accountIds.includes(x.account.id) ||
          filters.accountIds.includes(x.receivingAccount?.id)
      );
    }

    // Filter by type of movement:
    if (filters.typeOfTransaction != 'all') {
      if (
        !filters.typeOfTransaction ||
        filters.typeOfTransaction == 'IncomeOrExpense'
      ) {
        results = results.filter((x) => x instanceof IncomeOrExpense);
      } else if (filters.typeOfTransaction == 'Transfer') {
        results = results.filter((x) => x instanceof Transfer);
      }
    }

    // Filter by a query text:
    if (filters.queryText?.trim()) {
      results = results.filter(
        (x) =>
          (x instanceof Transfer &&
            this.lang
              .getTranslation('TRANSFER.display')
              .toLowerCase()
              .indexOf(filters.queryText.toLowerCase()) > -1) ||
          (x instanceof IncomeOrExpense &&
            x.category.name
              .toLowerCase()
              .indexOf(filters.queryText.toLowerCase()) > -1) ||
          (x.text &&
            x.text.toLowerCase().indexOf(filters.queryText.toLowerCase()) > -1)
      );
    }

    // Filter by categories:
    if (filters.categoriesIds && filters.categoriesIds != 'all') {
      results = results.filter(
        (x) =>
          x.category &&
          (filters.categoriesIds.includes(x.category.id) ||
            (x.category.parentCategory &&
              filters.categoriesIds.includes(x.category.parentCategory.id)))
      );
    }

    // END OF THE FILTERS. RETURN THE RESULT:
    return results;
  }

  getTransactionsOfRecurringTransaction(
    transaction: Transaction,
    startDate?: Date,
    endDate?: Date
  ) {
    let currentDate = transaction.date;
    const result: Transaction[] = [];

    while (
      currentDate < new Date() &&
      (!transaction.repeat.endDate || currentDate < transaction.repeat.endDate)
    ) {
      if (
        (!endDate || currentDate < endDate) &&
        (!startDate || currentDate >= startDate)
      ) {
        result.push({ ...transaction, ...{ date: currentDate } });
      }

      if (transaction.repeat.temp == 'week') {
        currentDate = new Date(
          currentDate.getFullYear(),
          currentDate.getMonth(),
          currentDate.getDate() + 7
        );
      } else if (transaction.repeat.temp == 'month') {
        currentDate = new Date(
          currentDate.getFullYear(),
          currentDate.getMonth() + 1,
          currentDate.getDate()
        );
      } else if (transaction.repeat.temp == 'year') {
        currentDate = new Date(
          currentDate.getFullYear() + 1,
          currentDate.getMonth(),
          currentDate.getDate()
        );
      }
    }

    return result;
  }

  /** Returns the periodic cost of the transaction in the specified time format */
  getRecurrentTransactionValueByTemp(
    transaction: Transaction,
    time: RecurrentOption
  ) {
    if (time == transaction.repeat.temp) return transaction.value;

    if (time == RecurrentOption.month) {
      if (transaction.repeat.temp == RecurrentOption.year)
        return transaction.value / 12;
      if (transaction.repeat.temp == RecurrentOption.week)
        return transaction.value * 4.34524;
    } else if (time == RecurrentOption.year) {
      if (transaction.repeat.temp == RecurrentOption.month)
        return transaction.value * 12;
      if (transaction.repeat.temp == RecurrentOption.week)
        return transaction.value * 52;
    } else if (time == RecurrentOption.week) {
      if (transaction.repeat.temp == RecurrentOption.year)
        return transaction.value / 52;
      if (transaction.repeat.temp == RecurrentOption.month)
        return transaction.value / 4.34524;
    }
  }
}
