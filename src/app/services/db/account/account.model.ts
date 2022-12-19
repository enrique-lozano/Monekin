import { v4 as generateUUID } from 'uuid';
import { ISOCorrencyCodes } from '../../../constants/currencies/currency-code.enum';

export class Account {
  readonly id: string;

  /** Name of the account. Must be unique, a user can not have two or more accounts with the same name */
  name: string;

  /** The initial value of the account, the amount of money of the account before any transaction */
  iniValue: number;

  /** Creation date of the account */
  readonly date: Date;

  /** Short description text of the account */
  text?: string;

  readonly type: 'normal' | 'saving';

  icon: string;

  /** Currency of all the transactions of this account. When you change this currency all transactions in this account will have the new currency but their amount/value will remain the same. */
  currency: ISOCorrencyCodes;

  iban?: string;
  swift?: string;

  constructor(obj: Account | Omit<Account, 'id'>) {
    Object.assign(this, obj);

    if (!this.id) this.id = generateUUID();
  }
}
