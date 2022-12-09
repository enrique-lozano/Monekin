export enum AppLanguageCode {
  en = 'en',
  es = 'es',
}

export const appLanguages = Object.values(AppLanguageCode); // -> ["en", "es", ...]

/** The default language of the app. Usefull if we don't have the data from the DB */
export const defaultLang = AppLanguageCode.en;
