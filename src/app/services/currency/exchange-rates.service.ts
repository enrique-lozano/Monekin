import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';
import { defaultExhangeRates } from 'src/app/constants/default-exchange-rates';
import { StorageService } from '../db/storage.service';
import { UtilsService } from '../utils/utils.service';
import { exchangeRate } from './currency.model';

@Injectable({
  providedIn: 'root',
})
export class ExchangeRatesService {
  private exchangeRates: exchangeRate;

  constructor(
    private http: HttpClient,
    private storage: StorageService,
    private utils: UtilsService
  ) {}

  /** Get a exchange rate */
  async getExchangeRate(from: ISOCorrencyCodes, to: ISOCorrencyCodes) {
    if (from === to) return 1;

    const exchangeRates = (await this.getExchangeRates()).rates;

    return Number(exchangeRates[to]) / Number(exchangeRates[from]);
  }

  /** Get all the exchange rates in the app and save it again in the storage if needed. Call the API to refresh the data if is old */
  async getExchangeRates() {
    if (this.exchangeRates) return this.exchangeRates;

    this.exchangeRates = await this.storage.getItem('exchangeRates');

    if (!this.exchangeRates || (await this.getDaysWithoutUpdate()) > 7) {
      let dataFromAPI: {
        data: { currency: string; rates: { [key: string]: string } };
      };

      try {
        dataFromAPI = await this.getExchangesRatesFromAPI();
      } catch (error) {
        console.warn('API not avalaible');
      }

      this.exchangeRates = dataFromAPI
        ? {
            lastUpdate: new Date(),
            baseCurrency: dataFromAPI.data.currency,
            rates: dataFromAPI.data.rates,
          }
        : defaultExhangeRates;

      await this.storage.setItem('exchangeRates', this.exchangeRates);
    }

    return this.exchangeRates;
  }

  /** Get the number of days the application has been without updating the exchange rates from the API */
  async getDaysWithoutUpdate() {
    return this.utils.getDateDiff(
      new Date(),
      new Date((await this.getExchangeRates()).lastUpdate)
    );
  }

  /** Get exchanges rates from the coinbase API */
  protected getExchangesRatesFromAPI() {
    const url = 'https://api.coinbase.com/v2/exchange-rates';
    return this.http
      .get<{
        data: { currency: string; rates: { [key: string]: string } };
      }>(url, {
        headers: {
          // eslint-disable-next-line @typescript-eslint/naming-convention
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
      })
      .toPromise();
  }
}
