import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Share } from '@capacitor/share';
import { AlertController } from '@ionic/angular';
import { BackupService } from 'src/app/services/backup/backup.service';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';
import { UserAvatars } from 'src/app/services/db/settings/settings.model';
import { SettingsService } from 'src/app/services/db/settings/settings.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { ToastService } from 'src/app/services/ionic/toast.service';
import { LangService } from 'src/app/services/translate/translate.service';
@Component({
  selector: 'app-settings',
  templateUrl: './settings.page.html',
  styleUrls: ['./settings.page.scss'],
})
export class SettingsPage {
  username: string;
  userAvatar: UserAvatars;
  userCurrency: Currency;

  canShare: boolean;

  constructor(
    private router: Router,
    private settings: SettingsService,
    private lang: LangService,
    private currencyService: CurrencyService,
    private modalService: IonModalService,
    private backupService: BackupService,
    private alertCtrl: AlertController,
    private toast: ToastService
  ) {}

  async ionViewWillEnter() {
    const userSettings = await this.settings.getSettings();
    this.canShare = (await Share.canShare()).value;

    this.username = userSettings.userName;
    this.userAvatar = userSettings.avatar;

    this.currencyService
      .getUserCurrency()
      .then((currency) => (this.userCurrency = currency));
  }

  goTo(path: string) {
    if (path == '/categories-list') {
      return this.router.navigate([path], {
        queryParams: { returnTo: 'category' },
      });
    }

    this.router.navigate([path]);
  }

  async shareLink() {
    if (!this.canShare) return;

    await Share.share({
      url: 'https://play.google.com/store/apps/details?id=com.monekin.app',
      text: this.lang.getTranslation('SETTINGS.HELP_US.share.text'),
      title: this.lang.getTranslation('SETTINGS.HELP_US.share'),
      dialogTitle: this.lang.getTranslation('SETTINGS.HELP_US.share'),
    });
  }

  async deleteAllData() {
    const alert = await this.alertCtrl.create({
      cssClass: 'basicAlert',
      header: this.lang.getTranslation('SETTINGS.DATA.delete-all-header1'),
      message: this.lang.getTranslation('SETTINGS.DATA.delete-all-message1'),
      buttons: [
        {
          text: this.lang.getTranslation('GENERAL.understood'),
          handler: async () => {
            const alert2 = await this.alertCtrl.create({
              cssClass: 'basicAlert',
              header: this.lang.getTranslation(
                'SETTINGS.DATA.delete-all-header2'
              ),
              message: this.lang.getTranslation(
                'SETTINGS.DATA.delete-all-message2'
              ),
              buttons: [
                {
                  text: this.lang.getTranslation('GENERAL.understood'),
                  handler: async () => {
                    await this.backupService.resetAllData();

                    this.router.navigate(['onboarding/login']);
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

  async openCurrencyModal() {
    const modalResult = await this.modalService.openCurrencySelectorModal();

    if (modalResult.data) {
      this.userCurrency = modalResult.data;
      this.currencyService.setUserCurrency(this.userCurrency);
    }
  }

  private importAlert: HTMLIonAlertElement;
  async importData() {
    this.importAlert = await this.alertCtrl.create({
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

    await this.importAlert.present();
  }

  onFileSelected() {
    const filesUpload: HTMLInputElement = document.querySelector('#file-input');

    if (filesUpload.files && filesUpload.files.length > 0) {
      const fileReader: FileReader = new FileReader();
      fileReader.readAsText(filesUpload.files[0]);
      fileReader.onload = async () => {
        if (fileReader.result) {
          this.backupService
            .importDataFromFile(fileReader.result)
            .then(async () => {
              await this.importAlert.dismiss();
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

  /** Edit the avatar and the display name of the user */
  async editUserProfile() {
    await this.modalService.openUserProfileEdition();

    const userSettings = await this.settings.getSettings();

    this.username = userSettings.userName;
    this.userAvatar = userSettings.avatar;
  }
}
