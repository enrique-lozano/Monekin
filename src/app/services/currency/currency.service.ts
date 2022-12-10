import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';
import { currencyNames } from 'src/app/constants/currencies/i18n/currencies';
import { Currency } from 'src/app/models/currency.model';
import { AppLanguageCode } from 'src/app/modules/i18n/availableLangs';
import { SettingsService } from '../db/settings/settings.service';
import { LangService } from '../translate/translate.service';

@Injectable({
  providedIn: 'root',
})
export class CurrencyService {
  private currencies: Currency[];
  private selectedCurrency: Currency;
  onChangeCurrency: BehaviorSubject<Currency> = new BehaviorSubject(undefined);

  constructor(
    private settingsService: SettingsService,
    private langService: LangService
  ) {}

  /** Set the preferred currency of the user.
   *
   * @param currency The new preferred currency of the user
   * @param saveToStorage True to save the changes to the permanent storage. Defaults to true
   */
  async setUserCurrency(currency: Currency, saveToStorage = true) {
    this.selectedCurrency = currency;

    if (saveToStorage) {
      await this.settingsService.setSettings({
        preferredCurrency: currency.code,
      });
    }

    this.onChangeCurrency.next(currency);
  }

  async getUserCurrency() {
    if (!this.selectedCurrency) {
      this.selectedCurrency = this.getAppCurrencies().find(
        async (x) =>
          x.code == (await this.settingsService.getSettings()).preferredCurrency
      );
    }

    return this.selectedCurrency;
  }

  /** Called in the app.component.ts (every time the user enters in the app) */
  async initializeUserCurrency(selectedLang: AppLanguageCode) {
    const settings = await this.settingsService.getSettings();

    if (settings.preferredCurrency)
      this.setUserCurrency(
        this.getCurrencyByCode(settings.preferredCurrency),
        false
      );
    else {
      if (selectedLang == AppLanguageCode.es) {
        this.setUserCurrency(this.getCurrencyByCode(ISOCorrencyCodes.EUR));
      } else {
        this.setUserCurrency(this.getCurrencyByCode(ISOCorrencyCodes.USD));
      }
    }
  }

  /** Get the name of a currency in a specific language
   *
   * @param currencyCode The ISO code of the currency to get
   * @param lang The language used for the result
   */
  protected getCurrencyName(
    currencyCode: ISOCorrencyCodes,
    lang: AppLanguageCode
  ) {
    return currencyNames.find((nameArray) => nameArray.lang === lang).names[
      currencyCode
    ];
  }

  /** Find a currency in the app currencies
   *
   * @param code The ISO code of the currency to find
   */
  getCurrencyByCode(code: ISOCorrencyCodes) {
    return this.getAppCurrencies().find((x) => x.code == code);
  }

  getAppCurrencies() {
    if (this.currencies) return this.currencies;

    this.currencies = Object.keys(ISOCorrencyCodes).map((code) => ({
      code: ISOCorrencyCodes[code],
      name: this.getCurrencyName(
        ISOCorrencyCodes[code],
        this.langService.getSelectedLang()
      ),
    }));

    return this.currencies;
  }

  setAppCurrencies(currencies: Currency[]) {
    this.currencies = currencies;
  }
}
