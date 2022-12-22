import { LOCALE_LIST } from 'src/app/modules/i18n/locales';
import { ISOCorrencyCodes } from '../../../constants/currencies/currency-code.enum';
import { AppLanguageCode } from '../../../modules/i18n/availableLangs';

export enum UserAvatars {
  man = 'man',
  woman = 'woman',
  executiveMan = 'executive_man',
  executiveWoman = 'executive_woman',
  blondeMan = 'blonde_man',
  blondeWoman = 'blonde_woman',
  blackMan = 'black_man',
  blackWoman = 'black_woman',
  bangs = 'woman_with_bangs',
  goatee = 'man_with_goatee',
}

/** Settings and variables that the user can modify in the settings page */
export interface UserSettings {
  /** The user display name */
  userName: string;

  avatar: UserAvatars;

  darkMode: 'auto' | 'enabled' | 'disabled';

  /** The app language.
   *
   * Unlike localization, which comes directly from Angular, this parameter is limited by the amount of translation files you have. */
  preferredLanguage: AppLanguageCode;

  /** The user locale/region. Used to change the format of dates, numbers... throw the Angular pipes
   *
   *  @since `v3.0.0` */
  locale: LOCALE_LIST;

  preferredCurrency: ISOCorrencyCodes;

  /** First day of the week to show in calendars and other components, with 0 being Sunday, 1 being Monday, 2 being Tuesday... */
  firstDayOfWeek: 0 | 1 | 2 | 3 | 4 | 5 | 6;
}

export const defaultSettings: UserSettings = {
  userName: 'User',
  avatar: UserAvatars.man,
  darkMode: 'auto',
  preferredLanguage: undefined,
  preferredCurrency: undefined,
  firstDayOfWeek: undefined,
  locale: undefined,
};
