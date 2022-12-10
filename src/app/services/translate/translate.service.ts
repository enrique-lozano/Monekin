import { getLocaleFirstDayOfWeek } from '@angular/common';
import { Injectable } from '@angular/core';
import { getBrowserLang, TranslocoService } from '@ngneat/transloco';
import {
  AppLanguageCode,
  appLanguages,
  defaultLang,
} from 'src/app/modules/i18n/availableLangs';
import { SettingsService } from '../db/settings/settings.service';

@Injectable({
  providedIn: 'root',
})
export class LangService {
  constructor(
    private translate: TranslocoService,
    private settingsService: SettingsService
  ) {}

  /** Called in the app.component.ts (every time the user enters in the app) */
  async setInitialAppLang() {
    const settings = await this.settingsService.getSettings();

    if (settings.preferredLanguage) {
      this.setLanguage(settings.preferredLanguage, false);
    } else {
      // If is the first time that we enter in the app
      const browserLang = getBrowserLang();

      await this.setLanguage(browserLang as any);

      this.settingsService.setSettings({
        firstDayOfWeek: getLocaleFirstDayOfWeek(browserLang),
      });
    }
  }

  /** Retrieves the key/code of the current active language */
  getSelectedLang() {
    return this.translate.getActiveLang() as AppLanguageCode;
  }

  /** Change the app language.
   *
   * @param lng The new language to use in the app
   * @param save True if the new language will be saved to the permanent storage. Defaults to true
   */
  async setLanguage(lng: AppLanguageCode, save = true) {
    let langToSet: AppLanguageCode;

    if (!appLanguages.some((x) => x === lng)) {
      // Falback for not supported languages
      langToSet = defaultLang;
    } else {
      langToSet = lng;
    }

    this.translate.setActiveLang(langToSet);

    if (save)
      await this.settingsService.setSettings({ preferredLanguage: lng });
  }

  /** Returns the translation of a JSON key. Must be a valid key (assets/i18n folder) */
  getTranslation(key: string, interpolateParams?: object) {
    return this.translate.translate(key, interpolateParams);
  }
}
