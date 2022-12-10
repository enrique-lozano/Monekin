import { Injectable } from '@angular/core';
import { Storage } from '@ionic/storage-angular';
import * as CordovaSQLiteDriver from 'localforage-cordovasqlitedriver';
import { IonicStorageKey } from 'src/app/constants/capacitor-storage';
import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';
import { Account } from 'src/app/services/db/account/account.model';
import { Budget } from 'src/app/services/db/budget/budget.model';
import { CategoryInStorage } from 'src/app/services/db/category/category.model';
import {
  Cookies,
  defaultCookies,
} from 'src/app/services/db/cookie/cookies.model';
import {
  defaultSettings,
  UserAvatars,
  UserSettings,
} from 'src/app/services/db/settings/settings.model';
import {
  Transaction,
  TransactionInStorage,
} from 'src/app/services/db/transaction/transaction.model';
import { UserData } from 'src/app/services/db/user-data.model';
import { v4 as generateUUID } from 'uuid';

@Injectable({
  providedIn: 'root',
})
export class StorageService {
  private appStorage: Storage | null = null;
  cookies: Cookies;

  constructor(private storage: Storage) {}

  async set(key: IonicStorageKey, value: any) {
    if (!this.appStorage) {
      await this.init();
    }

    return this.appStorage.set(key, value);
  }

  async get(key: IonicStorageKey) {
    if (!this.appStorage) {
      await this.init();
    }

    return this.appStorage.get(key);
  }

  async remove(key: IonicStorageKey) {
    if (!this.appStorage) {
      await this.init();
    }
    return this.appStorage.remove(key);
  }

  async removeAll() {
    for (const key of Object.keys(IonicStorageKey)) {
      await this.remove(IonicStorageKey[key]);
    }
  }

  async init() {
    await this.storage.defineDriver(CordovaSQLiteDriver);
    this.appStorage = await this.storage.create();
    await this.initializeDB();
  }

  private async initializeDB() {
    if (await this.get(IonicStorageKey.userData)) return;

    let userData: UserData;

    if (
      ((await this.get(IonicStorageKey.cookies)) as Cookies)?.modelVersion ==
      '1'
    ) {
      userData = this.transformDataToV2({
        accounts: await this.get(IonicStorageKey.accounts),
        budgets: await this.get(IonicStorageKey.budgets),
        transfers: await this.get(IonicStorageKey.transfers),
        categories: await this.get(IonicStorageKey.categories),
        cookies: await this.get(IonicStorageKey.cookies),
        settings: await this.get(IonicStorageKey.settings),
      });
    } else {
      userData = {
        accounts: [],
        budgets: [],
        transactions: [],
        settings: defaultSettings,
        cookies: defaultCookies,
        categories: undefined, //Initialized later on the app.component
      };
    }

    await this.set(IonicStorageKey.userData, userData);
  }

  transformDataToV2(data: {
    accounts: any[];
    transfers: any[];
    categories: any[];
    budgets: Budget[];
    settings: UserSettings;
    cookies: Cookies;
  }) {
    const result: Partial<UserData> = {
      cookies: { ...data.cookies, ...{ modelVersion: '2' } },
      settings: { ...data.settings, avatar: UserAvatars.man },
      budgets: data.budgets,
      accounts: (data.accounts as Omit<Account, 'id'>[]).map((x) => ({
        id: generateUUID(),
        date: x.date,
        icon: x.icon,
        iniValue: x.iniValue,
        name: x.name,
        type: x.type,
        currency: data.settings.preferredCurrency as ISOCorrencyCodes,
        ...(x.text && { text: x.text }),
      })),
    };

    const categories: CategoryInStorage[] = [];

    (
      data.categories as {
        name: string;
        icon: string;
        color: string;
        type: 'E' | 'I' | 'B';
        subcategories?: { name: string; icon: string }[];
      }[]
    ).forEach((categoryInFile) => {
      const mainCategoryUUID = generateUUID();
      categories.push({
        id: mainCategoryUUID,
        icon: categoryInFile.icon,
        name: categoryInFile.name,
        type: categoryInFile.type,
        color: categoryInFile.color,
      });

      if (categoryInFile.subcategories) {
        categoryInFile.subcategories.forEach((subcatInFile) => {
          categories.push({
            id: generateUUID(),
            parentCategoryID: mainCategoryUUID,
            icon: subcatInFile.icon,
            name: subcatInFile.name,
          });
        });
      }
    });

    result.categories = categories;

    const transactionsToStorage: TransactionInStorage[] = [];

    (
      data.transfers as (Omit<
        Transaction,
        'id' | 'account' | 'receivingAccount' | 'category'
      > & { from: string; to: string; category: string })[]
    ).forEach((el) => {
      const transAccount = result.accounts.find((acc) => acc.name === el.from);

      if (!transAccount) return;

      transactionsToStorage.push({
        accountID: transAccount.id,
        date: el.date,
        id: generateUUID(),
        value: el.value,
        receivingAccountID: result.accounts.find((acc) => acc.name === el.to)
          .id,
        ...(el.repeat && { repeat: el.repeat }),
        ...(el.text && { text: el.text }),
      });
    });

    (
      data.accounts as (Omit<Account, 'id'> & {
        transactions: (Omit<
          Transaction,
          'id' | 'category' | 'receivingAccount'
        > & { category: string })[];
      })[]
    ).forEach((el) => {
      el.transactions.forEach((trans) => {
        transactionsToStorage.push({
          accountID: result.accounts.find((acc) => acc.name === el.name).id,
          date: trans.date,
          id: generateUUID(),
          value: trans.value,
          categoryID: categories.find((x) => x.name === trans.category).id,
          ...(trans.repeat && { repeat: trans.repeat }),
          ...(trans.text && { text: trans.text }),
        });
      });
    });

    result.transactions = transactionsToStorage;

    const budgetsToStorage: Budget[] = [];

    data.budgets.forEach((budget) => {
      budgetsToStorage.push({
        ...budget,
        ...{
          categories:
            budget.categories == 'all'
              ? 'all'
              : budget.categories.map(
                  (x) => result.categories.find((cat) => cat.name == x).id
                ),
        },
        ...{
          accounts:
            budget.accounts == 'all'
              ? 'all'
              : budget.accounts.map(
                  (x) => result.accounts.find((cat) => cat.name == x).id
                ),
        },
      });
    });

    result.budgets = budgetsToStorage;

    return result as UserData;
  }
}
