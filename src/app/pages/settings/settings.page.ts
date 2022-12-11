import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';
import { UserAvatars } from 'src/app/services/db/settings/settings.model';
import { SettingsService } from 'src/app/services/db/settings/settings.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
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

  constructor(
    private router: Router,
    private settings: SettingsService,
    public lang: LangService,
    private currencyService: CurrencyService,
    private modalService: IonModalService
  ) {}

  async ionViewWillEnter() {
    const userSettings = await this.settings.getSettings();

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

  async openCurrencyModal() {
    const modalResult = await this.modalService.openCurrencySelectorModal();

    if (modalResult.data) {
      this.userCurrency = modalResult.data;
      this.currencyService.setUserCurrency(this.userCurrency);
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
