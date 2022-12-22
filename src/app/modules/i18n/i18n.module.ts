import { registerLocaleData } from '@angular/common';
import { APP_INITIALIZER, Injectable, LOCALE_ID } from '@angular/core';
import { getBrowserCultureLang } from '@ngneat/transloco';
import { AppInjector } from 'src/app/app.module';
import { SettingsService } from 'src/app/services/db/settings/settings.service';
import { LOCALE_LIST } from './locales';
// import { loadTranslations } from '@angular/localize';

@Injectable({
  providedIn: 'root',
})
class I18n {
  userLocale: string;

  async setLocale() {
    const userSettings = AppInjector.get(SettingsService);

    this.userLocale =
      (await userSettings.getSettings()).locale || getBrowserCultureLang();

    await userSettings.setSettings({
      locale: this.userLocale as LOCALE_LIST,
    });

    // Use web pack magic string to only include required locale data
    let localeModule: any;
    const loadLocale = async () => {
      localeModule = await import(
        `/node_modules/@angular/common/locales/${this.userLocale}.mjs`
      );
      console.log(`Locale '${this.userLocale}' setted correctly!`);
    };

    try {
      await loadLocale();
    } catch (err) {
      console.warn(
        'The user culture lang is not supported by Angular.' +
          ' Trying the user lang...'
      );
      try {
        this.userLocale = this.userLocale.split('-')[0];
        await loadLocale();
      } catch (err) {
        console.warn(
          'The user lang is not supported by Angular.' +
            'Angular will use en-US as default'
        );
      }
    }

    // Set locale for built in pipes, etc.
    if (localeModule) {
      registerLocaleData(localeModule.default);
    }

    // // Load translation file
    // const localeTranslationsModule = await import(
    //   `src/assets/i18n/${this.locale}.json`
    // );

    // // Load translations for the current locale at run-time
    // loadTranslations(localeTranslationsModule.default);
  }
}

// Load locale data at app start-up
function setLocale() {
  return {
    provide: APP_INITIALIZER,
    useFactory: (i18n: I18n) => () => i18n.setLocale(),
    deps: [I18n],
    multi: true,
  };
}

// Set the runtime locale for the app
function setLocaleId() {
  return {
    provide: LOCALE_ID,
    useFactory: (i18n: I18n) => i18n.userLocale,
    deps: [I18n],
  };
}

export const I18nModule = {
  setLocale: setLocale,
  setLocaleId: setLocaleId,
};
