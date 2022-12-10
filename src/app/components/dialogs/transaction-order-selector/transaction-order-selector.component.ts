import { Component, Input, OnInit } from '@angular/core';
import { ModalController } from '@ionic/angular';
import {
  TransactionListOrder,
  TransactionListOrderKey,
} from 'src/app/constants/transaction-list-order';

@Component({
  selector: 'app-transaction-order-selector',
  templateUrl: './transaction-order-selector.component.html',
  styleUrls: ['./transaction-order-selector.component.scss'],
})
export class TransactionOrderSelectorComponent implements OnInit {
  @Input() order: TransactionListOrder;

  transactionListOrderKeyType = TransactionListOrderKey;
  keys = Object.keys(TransactionListOrderKey);

  constructor(private modalCtrl: ModalController) {}

  ngOnInit() {}

  selectOrder(selectedKey: string) {
    if (this.transactionListOrderKeyType[selectedKey] == this.order.orderBy) {
      return this.modalCtrl.dismiss({
        dir: this.order.dir == 'asc' ? 'desc' : 'asc',
        orderBy: this.order.orderBy,
      });
    } else {
      return this.modalCtrl.dismiss({
        dir: this.order.dir,
        orderBy: this.transactionListOrderKeyType[selectedKey],
      });
    }
  }
}
