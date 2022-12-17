import { ISOCorrencyCodes } from '../../constants/currencies/currency-code.enum';

export interface Currency {
  code: ISOCorrencyCodes;
  name: string;
}

export interface exchangeRate {
  lastUpdate: Date;
  baseCurrency: string;
  rates: { [key: string]: string };
}
