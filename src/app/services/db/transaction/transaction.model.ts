import { v4 as generateUUID } from 'uuid';
import { Account } from '../account/account.model';
import { Category } from '../category/category.model';

export enum RecurrentOption {
  week = 'week',
  month = 'month',
  year = 'year',
}

/** Common attributes that will be saved in the permanent storage and in memory */
abstract class TransactionBase {
  readonly id: string;
  /** The date of the movement, or the date of the first movement in the case of a recurring movement */ date: Date;
  /** Value of the movement in the currency chosen by the user. Can not be 0 */ value: number;
  /** Description of the movement */ text?: string;
  repeat?: {
    temp: RecurrentOption;
    /** Completion date of the recurring movement. If not specified, the movement will be repeated until the end of times */ endDate?: Date;
  };

  account: Account;

  constructor(obj: any) {
    Object.assign(this, obj);

    this.date = new Date(obj.date);

    if (!this.id) this.id = generateUUID();

    if (obj.repeat && obj.repeat.endDate) {
      this.repeat.endDate = new Date(obj.repeat.endDate);
    }
  }
}

export class IncomeOrExpense extends TransactionBase {
  category: Category;

  receivingAccount?: never;
  valueInDestiny?: never;

  constructor(obj: IncomeOrExpense | Omit<IncomeOrExpense, 'id'>) {
    super(obj);
  }
}

export class Transfer extends TransactionBase {
  receivingAccount: Account;
  valueInDestiny?: number;

  category?: never;

  constructor(obj: Transfer | Omit<Transfer, 'id'>) {
    super(obj);
  }
}

export type Transaction = IncomeOrExpense | Transfer;

class IncomeOrExpenseInStorage extends TransactionBase {
  categoryID: string;

  receivingAccountID?: never;
  valueInDestiny?: never;
}

class TransferInStorage extends TransactionBase {
  receivingAccountID: string;
  valueInDestiny?: number;

  categoryID?: never;
}

export type TransactionInStorage = Omit<
  IncomeOrExpenseInStorage | TransferInStorage,
  'account'
> & { accountID: string };
