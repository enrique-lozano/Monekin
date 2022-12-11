import { TranslationWidth } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import {
  AppLanguageCode,
  appLanguages,
} from 'src/app/modules/i18n/availableLangs';
import { SettingsService } from 'src/app/services/db/settings/settings.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { UtilsService } from 'src/app/services/utils/utils.service';

@Component({
  selector: 'app-general',
  templateUrl: './general.page.html',
  styleUrls: ['./general.page.scss'],
})
export class GeneralPage implements OnInit {
  languages: string[];

  selectedLang: AppLanguageCode;

  weekDays: string[];
  selectedWeekDay: 0 | 1 | 2 | 3 | 4 | 5 | 6;

  constructor(
    public langService: LangService,
    private utils: UtilsService,
    private settings: SettingsService
  ) {
    this.languages = appLanguages;
    this.selectedLang = this.langService.getSelectedLang();
  }

  async ngOnInit() {
    await this.getWeekDays();
    this.selectedWeekDay = (await this.settings.getSettings()).firstDayOfWeek;
  }

  async getWeekDays() {
    this.weekDays = await this.utils.getDayWeeksArray(
      TranslationWidth.Wide,
      false
    );
  }

  async setLanguage() {
    await this.langService.setLanguage(this.selectedLang);
    await this.getWeekDays();
  }

  async setWeekDay() {
    await this.settings.setSettings({ firstDayOfWeek: this.selectedWeekDay });
  }
}
