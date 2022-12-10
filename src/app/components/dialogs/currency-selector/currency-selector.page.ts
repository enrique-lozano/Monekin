import { Component, OnInit } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { StatusBarService } from 'src/app/services/ionic/status-bar.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-currency-selector',
  templateUrl: './currency-selector.page.html',
  styleUrls: ['./currency-selector.page.scss'],
})
export class CurrencySelectorComponent implements OnInit {
  currencies: Currency[] = [];
  searcher: string;

  constructor(
    private currencyService: CurrencyService,
    private statusBar: StatusBarService,
    private modalCtrl: ModalController,
    private modalService: IonModalService,
    public lang: LangService
  ) {}

  ngOnInit() {
    this.getCurrencies();
  }

  ionViewWillEnter() {
    this.statusBar.setPrimaryStatusBar();
  }

  ionViewDidEnter() {
    this.modalService.recalculateContentHeight();
  }

  getCurrencies() {
    this.currencies = this.currencyService.getAppCurrencies();
  }

  selectCoin(currencyClicked: Currency) {
    this.modalCtrl.dismiss(currencyClicked);
  }

  getItems() {
    this.getCurrencies();

    // if the value is an empty string don't filter the items
    if (this.searcher && this.searcher.trim() !== '') {
      this.currencies = this.currencies.filter(
        (item) =>
          item.code.toUpperCase().indexOf(this.searcher.toUpperCase()) > -1 ||
          item.name?.toLowerCase().indexOf(this.searcher.toLowerCase()) > -1
      );
    }
  }
}
