import { exchangeRate } from '../currency/currency.model';
import { UserData } from './user-data.model';

export interface StorageSchema {
  userData: UserData;
  exchangeRates: exchangeRate;
}

/** Keys in the ionic-storage V1. Since Monekin 3, the keys types are stored in an interface */
export enum IonicStorageKeyV1 {
  settings = 'settings',
  categories = 'categories',
  accounts = 'accounts',
  budgets = 'budgets',
  cookies = 'cookies',
  transfers = 'transfers',
}
