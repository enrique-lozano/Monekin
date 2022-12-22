import {
  formatDate,
  FormStyle,
  getLocaleDayNames,
  getLocaleMonthNames,
  TranslationWidth,
} from '@angular/common';
import { Inject, Injectable, LOCALE_ID } from '@angular/core';
import {
  currentDay,
  currentMonth,
  currentYear,
} from 'src/app/constants/constants';
import { SettingsService } from '../db/settings/settings.service';
import { LangService } from '../translate/translate.service';

@Injectable({
  providedIn: 'root',
})
export class UtilsService {
  constructor(
    @Inject(LOCALE_ID) private userLocale: string,
    private lang: LangService,
    private settings: SettingsService
  ) {}

  getMonthArray(transWidth: TranslationWidth, capitalize = true) {
    return (
      getLocaleMonthNames(
        this.userLocale,
        FormStyle.Standalone,
        transWidth
      ) as string[]
    ).map((x) => {
      if (capitalize) {
        return x.charAt(0).toUpperCase() + x.slice(1);
      } else {
        return x;
      }
    });
  }

  /** Get the days of the weeks in the lang of the user, using the Gregorian calendar
   *
   * @param transWidth Width of the string of each weekday
   * @param orderDays If true, the array of weekDays will be ordered, following the order preferred by the user (in the settings the user can specified the first day of the week). Defaults to ```true```
   * @param capitalize If true, the first letter of each weekDay will be in capital letters. Defaults to ```true```
   */
  async getDayWeeksArray(
    transWidth: TranslationWidth,
    orderDays = true,
    capitalize = true
  ) {
    // Retrieve [Sunday, Monday...] in the language of the user
    let array = getLocaleDayNames(
      this.userLocale,
      FormStyle.Standalone,
      transWidth
    ) as string[];

    array = array.slice();

    // Order the array in the case the week starts in a day other than Sunday
    if (orderDays) {
      for (
        let i = 0;
        i < (await this.settings.getSettings()).firstDayOfWeek;
        i++
      ) {
        const toPush = array.splice(0, 1);
        array.push(toPush[0]);
      }
    }

    // Return the capitalized (or not) array of names
    return array.map((x) => {
      if (capitalize) {
        return x.charAt(0).toUpperCase() + x.slice(1);
      } else {
        return x;
      }
    });
  }

  /** Returns a date with the first/last day of the current quaterly */
  getQuaterlyDate(toReturn: 'startDate' | 'endDate' | 'monthRange') {
    let startMonth: number;
    let endMonth: number;

    if (currentMonth < 3) {
      startMonth = 0;
      endMonth = 3;
    } else if (currentMonth < 6) {
      startMonth = 3;
      endMonth = 6;
    } else if (currentMonth < 9) {
      startMonth = 6;
      endMonth = 9;
    } else if (currentMonth < 12) {
      startMonth = 9;
      endMonth = 12;
    }

    if (toReturn == 'startDate') {
      return new Date(currentYear, startMonth, 1);
    } else if (toReturn == 'endDate') {
      return new Date(currentYear, endMonth, 1);
    }
  }

  /** Get locale first date of the current week */
  async getDateOfFirstDayOfWeek() {
    for (let i = 1; i <= 7; i++) {
      const dateToCheck = new Date(currentYear, currentMonth, currentDay - i);

      if (
        dateToCheck.getDay() ==
        (await this.settings.getSettings()).firstDayOfWeek
      )
        return dateToCheck;
    }
  }

  /** Return a date in string format in the language of the user
   *
   * @param date The date to format
   * @param formatWidth Format of the date. See https://angular.io/api/common/DatePipe#usage-notes
   * @param showTodayAndYesterdayText It can be 'no' to always return the date in the specified format or 'i18nKeys' | 'translated' to return the text 'today' or 'yesterday' if applicable, as a key to the i18n files or as a translation directly, respectively
   */
  setDateInDOM(
    date: Date,
    formatWidth: 'shortDate' | 'mediumDate' | 'longDate' = 'mediumDate',
    showTodayAndYesterdayText: 'no' | 'i18nKeys' | 'translated' = 'i18nKeys'
  ): string {
    if (date == undefined) {
      if (showTodayAndYesterdayText == 'i18nKeys') return 'GENERAL.today';
      else if (showTodayAndYesterdayText == 'translated')
        return this.lang.getTranslation('GENERAL.today');
      else return '';
    } else if (
      date.getDate() == currentDay &&
      date.getMonth() == currentMonth &&
      date.getFullYear() == currentYear
    ) {
      if (showTodayAndYesterdayText == 'i18nKeys') return 'GENERAL.today';
      else if (showTodayAndYesterdayText == 'translated')
        return this.lang.getTranslation('GENERAL.today');
      else return formatDate(date, formatWidth, this.userLocale);
    } else if (
      date.getDate() + 1 == currentDay &&
      date.getMonth() == currentMonth &&
      date.getFullYear() == currentYear
    ) {
      if (showTodayAndYesterdayText == 'i18nKeys') return 'GENERAL.yesterday';
      else if (showTodayAndYesterdayText == 'translated')
        return this.lang.getTranslation('GENERAL.yesterday');
      else return formatDate(date, formatWidth, this.userLocale);
    } else {
      return formatDate(date, formatWidth, this.userLocale);
    }
  }

  /** Get the difference between two dates in days
   *
   * @note The number returned can be a decimal number, so the normal return will be something like 6.2622892 (6 days and some hours)
   */
  getDateDiff(date1: Date, date2: Date) {
    return (date1.getTime() - date2.getTime()) / (1000 * 60 * 60 * 24);
  }

  /**
   * Converts an HSL color value to HEX. Conversion formula
   * adapted from http://en.wikipedia.org/wiki/HSL_color_space.
   * Assumes h, s, and l are contained in the set [0, 1]
   *
   * @param h The hue
   * @param s The saturation, a value between 0 and 100
   * @param l The lightness, a value between 0 and 100
   * @return The hex representation
   */
  hslToHex(h: number, s: number, l: number) {
    l /= 100;
    const a = (s * Math.min(l, 1 - l)) / 100;
    const f = (n) => {
      const k = (n + h / 30) % 12;
      const color = l - a * Math.max(Math.min(k - 3, 9 - k, 1), -1);
      return Math.round(255 * color)
        .toString(16)
        .padStart(2, '0'); // convert to Hex and prefix "0" if needed
    };

    return `${f(0)}${f(8)}${f(4)}`;
  }
}
