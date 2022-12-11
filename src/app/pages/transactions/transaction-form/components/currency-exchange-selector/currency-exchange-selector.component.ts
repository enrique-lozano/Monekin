import { Component, OnInit } from '@angular/core';
import { ModalController } from '@ionic/angular';

@Component({
  selector: 'app-currency-exchange-selector',
  templateUrl: './currency-exchange-selector.component.html',
  styleUrls: ['./currency-exchange-selector.component.scss'],
})
export class CurrencyExchangeSelectorComponent implements OnInit {
  valueInSource: number;
  exchangeRate: number;
  valueInDestiny: number;

  constructor(private modalCtrl: ModalController) {}

  ngOnInit() {}

  recalculateDestiny() {
    this.valueInDestiny = this.valueInSource * this.exchangeRate;
  }

  recalculateExchangeRate() {
    this.exchangeRate = this.valueInDestiny / this.valueInSource;
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }

  submit() {
    this.modalCtrl.dismiss(this.valueInDestiny);
  }
}
