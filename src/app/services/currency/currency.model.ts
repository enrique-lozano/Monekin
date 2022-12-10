import { ISOCorrencyCodes } from '../../constants/currencies/currency-code.enum';

export interface Currency {
  code: ISOCorrencyCodes;
  name: string;
}
