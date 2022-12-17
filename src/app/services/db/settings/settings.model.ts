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
  userName: string;
  avatar: UserAvatars;
  darkMode: 'auto' | 'enabled' | 'disabled';
  preferredLanguage: AppLanguageCode;
  /** @since Monekin 3.0.0 */ locale: string;
  preferredCurrency: ISOCorrencyCodes;
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
