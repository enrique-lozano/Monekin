import { ISOCorrencyCodes } from '../../constants/currencies/currency-code.enum';
import { defaultLang } from '../../modules/i18n/availableLangs';
import { Account } from './account/account.model';
import { Budget } from './budget/budget.model';
import { CategoryInStorage } from './category/category.model';
import { Cookies, defaultCookies } from './cookie/cookies.model';
import { defaultSettings, UserSettings } from './settings/settings.model';
import { TransactionInStorage } from './transaction/transaction.model';

export class UserData {
  accounts: Account[];
  transactions: TransactionInStorage[];
  categories: CategoryInStorage[];
  budgets: Budget[];
  settings: UserSettings;
  cookies: Cookies;
}

export const userDataMock: UserData = {
  cookies: defaultCookies,
  settings: {
    ...defaultSettings,
    ...{
      preferredCurrency: ISOCorrencyCodes.EUR,
      preferredLanguage: defaultLang,
    },
  },
  budgets: [],
  accounts: [
    {
      id: 'acc_id1',
      icon: 'home',
      iniValue: 1000,
      name: 'Test Account 1',
      date: new Date(),
      type: 'normal',
      currency: ISOCorrencyCodes.EUR,
    },
    {
      id: 'acc_id2',
      icon: 'home',
      iniValue: 2500,
      name: 'Test Account 2',
      date: new Date(),
      type: 'normal',
      currency: ISOCorrencyCodes.EUR,
    },
  ],
  categories: [
    {
      id: 'cat_id1',
      icon: 'home',
      name: 'Home expenses',
      type: 'E',
      color: '014051',
    },
    {
      id: 'cat_id2',
      icon: 'car',
      name: 'Car expenses',
      type: 'E',
      color: 'B1C051',
    },
    {
      id: 'cat_id3',
      icon: 'person',
      name: 'Salary',
      type: 'I',
      color: '019851',
    },
  ],
  transactions: [
    {
      id: 'tr_id1',
      categoryID: 'cat_id1',
      accountID: 'acc_id1',
      date: new Date(2020, 3, 20),
      value: -20,
      text: 'Aaaaaa tabbbb',
    },
    {
      id: 'tr_id2',
      categoryID: 'cat_id2',
      accountID: 'acc_id2',
      date: new Date(2020, 5, 20),
      value: -50,
    },
    {
      id: 'tr_id3',
      categoryID: 'cat_id1',
      accountID: 'acc_id2',
      date: new Date(2020, 5, 12),
      value: -50,
    },

    {
      id: 'tr_id4',
      categoryID: 'cat_id3',
      accountID: 'acc_id1',
      date: new Date(2020, 4, 10),
      value: 200,
      text: 'mi paga',
    },
    {
      id: 'tr_id5',
      accountID: 'acc_id1',
      receivingAccountID: 'acc_id2',
      date: new Date(2021, 1, 22),
      value: 100,
      text: 'A transfer',
    },
  ],
};
