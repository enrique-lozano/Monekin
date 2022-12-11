import { Component, OnInit } from '@angular/core';
import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';
import { ExchangeRatesService } from 'src/app/services/currency/exchange-rates.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-currency-converter',
  templateUrl: './currency-converter.page.html',
  styleUrls: ['./currency-converter.page.scss'],
})
export class CurrencyConverterPage implements OnInit {
  currency1: Currency;
  currency2: Currency;

  exchangeRate: number;

  value = '0';
  calculatedValue = 0;

  buttons = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    ['.', 0, '<-'],
  ];

  daysSinceLastUpdate: number;

  constructor(
    public lang: LangService,
    private currencyService: CurrencyService,
    private modalService: IonModalService,
    private exchangeService: ExchangeRatesService
  ) {}

  async ngOnInit() {
    const userCurrency = await this.currencyService.getUserCurrency();

    this.currencyService.getAppCurrencies().forEach((coin) => {
      if (coin.code == userCurrency.code) {
        this.currency1 = coin;
      }
    });

    this.currency2 = this.currencyService
      .getAppCurrencies()
      .find((x) => x.code === ISOCorrencyCodes.USD);

    if (this.currency2.code == this.currency1.code) {
      this.currency2 = this.currencyService
        .getAppCurrencies()
        .find((x) => x.code === ISOCorrencyCodes.EUR);
    }

    this.calculateChange();
  }

  async ionViewDidEnter() {
    this.daysSinceLastUpdate =
      await this.exchangeService.getDaysWithoutUpdate();
  }

  calculateChange() {
    this.exchangeService
      .getExchangeRate(this.currency1.code, this.currency2.code)
      .then((rate) => {
        this.exchangeRate = rate;
        this.calculatedValue = parseFloat(this.value) * rate;
      });
  }

  async openCurrencyModal(selectedCurrency: 1 | 2) {
    const modalResult = await this.modalService.openCurrencySelectorModal();

    if (modalResult.data) {
      if (selectedCurrency == 1) this.currency1 = modalResult.data;
      else if (selectedCurrency == 2) this.currency2 = modalResult.data;

      this.calculateChange();
    }
  }

  shiftValues() {
    const aux = this.currency1;
    this.currency1 = this.currency2;
    this.currency2 = aux;
    this.calculateChange();
  }

  butPress(num: any) {
    if (num == '<-') {
      this.value = this.value.slice(0, -1);
      if (this.value == '') {
        this.value = '0';
      }
      this.calculateChange();
      return;
    }

    if (num == 'AC') {
      this.value = '0';
      this.calculateChange();
    } else {
      if (
        this.value.length > 8 ||
        (this.value.split('.')[1] != undefined &&
          this.value.split('.')[1].length >= 2)
      ) {
        return;
      } else {
        if (this.value == '0') {
          this.value = num.toString();
        } else {
          this.value += num.toString();
        }
        this.calculateChange();
      }
    }
  }
}
