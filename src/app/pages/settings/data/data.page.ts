import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AlertController } from '@ionic/angular';
import { IonicStorageKey } from 'src/app/constants/capacitor-storage';
import { BackupService } from 'src/app/services/backup/backup.service';
import { Account } from 'src/app/services/db/account/account.model';
import { CategoryService } from 'src/app/services/db/category/category.service';
import { CookieService } from 'src/app/services/db/cookie/cookie.service';
import { defaultCookies } from 'src/app/services/db/cookie/cookies.model';
import { defaultSettings } from 'src/app/services/db/settings/settings.model';
import { StorageService } from 'src/app/services/db/storage.service';
import { Transaction } from 'src/app/services/db/transaction/transaction.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { UserData } from 'src/app/services/db/user-data.model';
import { ToastService } from 'src/app/services/ionic/toast.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-data',
  templateUrl: './data.page.html',
  styleUrls: ['./data.page.scss'],
})
export class DataPage implements OnInit {
  lastExport: Date;

  constructor(
    private backupService: BackupService,
    private alertCtrl: AlertController,
    private router: Router,
    private toast: ToastService,
    public lang: LangService,
    private storage: StorageService,
    private transactionService: TransactionService,
    private cookieService: CookieService,
    private categoryService: CategoryService
  ) {}

  async ngOnInit() {
    this.lastExport = (await this.cookieService.getCookies()).lastExportDate;
  }

  async importData() {
    const alert = await this.alertCtrl.create({
      cssClass: 'basicAlert',
      header: this.lang.getTranslation('ACCOUNT.DELETE.warning-header'),
      message: this.lang.getTranslation('BACKUP.GUIDE.message4'),
      buttons: [
        {
          text: this.lang.getTranslation('GENERAL.cancel'),
          role: 'cancel',
          handler: () => {
            // Pass
          },
        },
        {
          text: this.lang.getTranslation('GENERAL.confirm'),
          handler: () => {
            document.getElementById('file-input').click();
          },
        },
      ],
    });

    await alert.present();
  }

  async exportData() {
    await this.backupService.exportData();
    this.lastExport = (await this.cookieService.getCookies()).lastExportDate;
  }

  async saveCSV() {
    const transactions: Transaction[] = [];

    (await this.transactionService.getTransactions()).forEach((transaction) => {
      if (transaction.repeat != undefined) {
        const transactionsToPush =
          this.transactionService.getTransactionsOfRecurringTransaction(
            transaction
          );

        transactionsToPush.forEach((trans) => {
          transactions.push(this.formatTransaction(trans, trans.account));
        });
      } else {
        transactions.push(
          this.formatTransaction(transaction, transaction.account)
        );
      }
    });

    await this.backupService.exportCSV(transactions);
  }

  private formatTransaction(trans: Transaction, account: Account) {
    let transactionToPush: any = trans;
    transactionToPush['account'] = account.name;
    if (!transactionToPush['text']) transactionToPush['text'] = '';

    // Sort the of the object
    transactionToPush = Object.keys(transactionToPush)
      .sort()
      .reduce((acc, key) => {
        acc[key] = transactionToPush[key];
        return acc;
      }, {});

    return transactionToPush;
  }

  onFileSelected() {
    const filesUpload: any = document.querySelector('#file-input');

    if (filesUpload.files && filesUpload.files.length > 0) {
      const fileReader: FileReader = new FileReader();
      fileReader.readAsText(filesUpload.files[0]);
      fileReader.onload = async () => {
        if (fileReader.result) {
          this.backupService
            .importDataFromFile(fileReader.result)
            .then(() => {
              this.router.navigate(['tabs']);
              this.toast.present('BACKUP.IMPORT.success');
            })
            .catch((err) => {
              this.toast.present('BACKUP.IMPORT.error', 'danger');
              console.error(err);
            });
        }
      };
    }
  }

  async openHelp() {
    const alert = await this.alertCtrl.create({
      cssClass: 'basicAlert',
      header: this.lang.getTranslation('BACKUP.GUIDE.title.short'),
      message:
        '<div>' +
        '<p>' +
        this.lang.getTranslation('BACKUP.GUIDE.message0') +
        '</p>' +
        '<ol><li>' +
        this.lang.getTranslation('BACKUP.GUIDE.message1') +
        '</li><li>' +
        this.lang.getTranslation('BACKUP.GUIDE.message2') +
        '</li><li>' +
        this.lang.getTranslation('BACKUP.GUIDE.message3') +
        '</li></ol>' +
        '<p> ' +
        this.lang.getTranslation('BACKUP.GUIDE.message4') +
        '</p>' +
        '</div>',
    });

    await alert.present();
  }

  async deleteAllData() {
    const alert = await this.alertCtrl.create({
      cssClass: 'basicAlert',
      header: this.lang.getTranslation('SETTINGS.delete-all-header1'),
      message: this.lang.getTranslation('SETTINGS.delete-all-message1'),
      buttons: [
        {
          text: this.lang.getTranslation('GENERAL.understood'),
          handler: async () => {
            const alert2 = await this.alertCtrl.create({
              cssClass: 'basicAlert',
              header: this.lang.getTranslation('SETTINGS.delete-all-header2'),
              message: this.lang.getTranslation('SETTINGS.delete-all-message2'),
              buttons: [
                {
                  text: this.lang.getTranslation('GENERAL.understood'),
                  handler: async () => {
                    const userData: UserData = {
                      accounts: [],
                      budgets: [],
                      transactions: [],
                      settings: defaultSettings,
                      cookies: defaultCookies,
                      categories: undefined,
                    };

                    await this.categoryService.getInitialCategories();

                    await this.storage.set(IonicStorageKey.userData, userData);

                    this.router.navigate(['tabs']);
                  },
                },
              ],
            });

            await alert2.present();
          },
        },
      ],
    });

    await alert.present();
  }
}
