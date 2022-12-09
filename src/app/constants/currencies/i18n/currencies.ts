import { AppLanguageCode } from 'src/app/modules/i18n/availableLangs';
import { currencyNamesEN } from './en';
import { currencyNamesES } from './es';

export const currencyNames: {
  lang: AppLanguageCode;
  names: { [key: string]: string };
}[] = [
  {
    lang: AppLanguageCode.es,
    names: currencyNamesES,
  },
  {
    lang: AppLanguageCode.en,
    names: currencyNamesEN,
  },
];
