import { ISOCorrencyCodes } from '../constants/currency-code.enum';

export interface Currency {
  code: ISOCorrencyCodes;
  name: string;
}
