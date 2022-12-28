import { Injectable } from '@angular/core';
import { Directory, Encoding, Filesystem } from '@capacitor/filesystem';
import { Share } from '@capacitor/share';
import { Platform } from '@ionic/angular';
import {
  currentDay,
  currentMonth,
  currentYear,
} from 'src/app/constants/constants';
import * as XLSX from 'xlsx';
import { AccountService } from '../db/account/account.service';
import { BudgetService } from '../db/budget/budget.service';
import { CategoryService } from '../db/category/category.service';
import { CookieService } from '../db/cookie/cookie.service';
import { Cookies, defaultCookies } from '../db/cookie/cookies.model';
import { defaultSettings } from '../db/settings/settings.model';
import { SettingsService } from '../db/settings/settings.service';
import { StorageService } from '../db/storage.service';
import { Transaction } from '../db/transaction/transaction.model';
import { TransactionService } from '../db/transaction/transaction.service';
import { UserData } from '../db/user-data.model';
import { UserDataService } from '../db/user-data.service';
import { FilterService } from '../filters/filter.service';
import { ToastService } from '../ionic/toast.service';

@Injectable({
  providedIn: 'root',
})
export class BackupService {
  constructor(
    private storage: StorageService,
    private userDataService: UserDataService,
    private toast: ToastService,
    private platform: Platform,

    private accountService: AccountService,
    private cookieService: CookieService,
    private categoryService: CategoryService,
    private settingsService: SettingsService,
    private budgetService: BudgetService,
    private transactionService: TransactionService,
    private filterService: FilterService
  ) {}

  /** Resets all the user data to its default values */
  async resetAllData() {
    const userData: UserData = {
      accounts: [],
      budgets: [],
      transactions: [],
      settings: defaultSettings,
      cookies: defaultCookies,
      categories: undefined,
    };

    await this.categoryService.getInitialCategories();

    await this.storage.setItem('userData', userData);
  }

  /**
   * @param fileReaderResult The result of the fileReader.onload() function
   */
  async importDataFromFile(fileReaderResult: string | ArrayBuffer) {
    let data = JSON.parse(fileReaderResult as string);

    if ((data.cookies as Cookies).modelVersion === '1') {
      data = await this.storage.migrateFromV1(data);
    }

    await this.userDataService.setUserData(data);

    await this.budgetService.refreshBudgets();
    await this.accountService.refreshAccounts();
    await this.categoryService.refreshCategories();
    await this.transactionService.refreshTransactions();
    await this.settingsService.refreshSettings();
    await this.cookieService.refreshCookies();

    this.filterService.selectedAccounts = 'all';
    this.filterService.selectedCategories = 'all';
  }

  async exportData() {
    const obj = await this.userDataService.getUserData();

    this.downloadFile(
      JSON.stringify(obj),
      `Monekin_backup_${currentYear}_${currentMonth}_${currentDay}`,
      'json'
    ).then(() => {
      this.cookieService.setCookies({ lastExportDate: new Date() });
    });
  }

  /** Convert a transaction array (json object) to a spreadsheet format, and export the converted result
   *
   * @param data The array of transactions
   * @param format The spreadsheet format (CSV or Excel)
   * @param separator The separator to use for the CSV columns
   */
  async exportSpreadsheet(
    data: Transaction[],
    format: 'csv' | 'xlsx' = 'csv',
    separator: ';' | ',' = ','
  ) {
    let csvData = '';

    let keys = [
      'ID',
      'Amount',
      'Date',
      'Note',
      'Account',
      'Category',
      'Subcategory',
    ];

    if (data[0]) {
      keys.forEach((key) => {
        csvData += key + separator;
      });
    }

    csvData += '\n';

    data.forEach((transaction) => {
      csvData +=
        transaction.id +
        separator +
        transaction.value +
        separator +
        transaction.date +
        separator +
        (transaction.text ?? '') +
        separator +
        transaction.account.name +
        separator +
        (transaction.category.parentCategory
          ? transaction.category.parentCategory.name
          : transaction.category.name) +
        separator +
        (transaction.category.parentCategory ? transaction.category.name : '');

      csvData += '\n';
    });

    if (format == 'csv') {
      await this.downloadFile(csvData, 'transactions', 'csv');
    } else if (format == 'xlsx') {
      const arrayOfArrayCsv = csvData.split('\n').map((row: string) => {
        return row.split(separator);
      });

      const wb = XLSX.utils.book_new();
      const newWs = XLSX.utils.aoa_to_sheet(arrayOfArrayCsv);
      XLSX.utils.book_append_sheet(wb, newWs);
      const rawExcel = XLSX.write(wb, { type: 'buffer' });

      await this.downloadFile(rawExcel, 'transactions', 'xlsx' as any);
    }
  }

  async downloadFile(
    data: string,
    filename: string,
    filetype: 'json' | 'csv' | 'xlsx'
  ) {
    if (this.platform.is('hybrid')) {
      if (await Share.canShare()) {
        Filesystem.writeFile({
          path: filename + '.' + filetype,
          data,
          directory: Directory.Cache,
          encoding: Encoding.UTF8,
        }).then((file) => {
          Share.share({
            dialogTitle: 'Export',
            title: filename,
            url: file.uri,
          })
            .then(() => {
              this.toast.present('BACKUP.EXPORT.success_in_data', 'default');
            })
            .catch(() => {
              this.toast.present('BACKUP.EXPORT.error', 'danger');
            });
        });

        return;
      }

      Filesystem.writeFile({
        path: filename + '.' + filetype,
        data,
        directory: Directory.Data,
        encoding: Encoding.UTF8,
      })
        .then(() => {
          this.toast.present(
            'BACKUP.EXPORT.success_in_documents',
            'default',
            8000
          );
        })
        .catch(() => {
          Filesystem.writeFile({
            path: filename + '.' + filetype,
            data,
            directory: Directory.Data,
            encoding: Encoding.UTF8,
          })
            .then(() => {
              this.toast.present(
                'BACKUP.EXPORT.success_in_data',
                'default',
                8000
              );
            })
            .catch(() => {
              this.toast.present('BACKUP.EXPORT.error', 'danger');
            });
        });
    } else {
      /** Mimitype of the file, based on the parameter passed to the function. For a list of all mimetypes check: https://docs.w3cub.com/http/basics_of_http/mime_types/complete_list_of_mime_types.html */
      let mimetype: string;

      if (filetype == 'json') mimetype = 'application/json';
      else if (filetype == 'csv') mimetype = 'text/csv';
      else if (filetype == 'xlsx')
        mimetype =
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';

      const a = document.createElement('a');
      a.style.display = 'none';
      document.body.appendChild(a);

      // Set the HREF to a Blob representation of the data to be downloaded
      a.href = window.URL.createObjectURL(new Blob([data], { type: mimetype }));

      // Use download attribute to set set desired file name
      a.setAttribute('download', filename);

      // Trigger the download by simulating click
      a.click();

      // Cleanup
      window.URL.revokeObjectURL(a.href);
      document.body.removeChild(a);

      this.toast.present('BACKUP.EXPORT.success_in_data');
    }
  }
}
