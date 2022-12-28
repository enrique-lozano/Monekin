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

  recalculateDestiny(event: any) {
    this.valueInDestiny = this.valueInSource * event.target.value;
  }

  recalculateExchangeRate(event: any) {
    this.exchangeRate = event.target.value / this.valueInSource;
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }

  submit() {
    this.modalCtrl.dismiss(this.exchangeRate);
  }
}
