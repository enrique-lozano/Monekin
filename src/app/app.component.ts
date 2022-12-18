import { Component } from '@angular/core';
import { SplashScreen } from '@capacitor/splash-screen';
import { CurrencyService } from './services/currency/currency.service';
import { CookieService } from './services/db/cookie/cookie.service';
import { StorageService } from './services/db/storage.service';
import { LangService } from './services/translate/translate.service';

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent {
  constructor(
    private storage: StorageService,
    private currencyService: CurrencyService,
    private translateService: LangService,
    private cookieService: CookieService
  ) {
    this.storage.init().then(() => {
      this.getStartedConfig();
    });
  }

  private async getStartedConfig() {
    await this.translateService.setInitialAppLang();
    await this.currencyService.initializeUserCurrency(
      this.translateService.getSelectedLang()
    );

    await this.cookieService.setCurrentAppVersion();

    SplashScreen.hide();
  }
}
