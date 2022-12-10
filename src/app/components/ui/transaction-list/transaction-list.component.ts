import { Component, Input, OnInit } from '@angular/core';
import {
  currentDay,
  currentMonth,
  currentYear,
} from 'src/app/constants/constants';

import { TransactionListOrderKey } from 'src/app/constants/transaction-list-order';
import {
  RecurrentOption,
  Transaction,
} from 'src/app/services/db/transaction/transaction.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { LangService } from 'src/app/services/translate/translate.service';

import {
  animate,
  query,
  stagger,
  style,
  transition,
  trigger,
} from '@angular/animations';

@Component({
  selector: 'app-transaction-list',
  templateUrl: './transaction-list.component.html',
  styleUrls: ['./transaction-list.component.scss'],
  animations: [
    trigger('listAnimation', [
      transition('* => *', [
        // each time the binding value changes

        query(
          ':enter',
          [
            style({ transform: 'scaleX(0)' }),
            stagger(50, [animate('0.35s', style({ transform: 'scaleX(1)' }))]),
          ],
          { optional: true }
        ),
      ]),
    ]),
  ],
})
export class TransactionListComponent implements OnInit {
  @Input() transactions: Transaction[];

  @Input() order: TransactionListOrderKey = TransactionListOrderKey.date;

  /** If true, display a text in the case that the date/category of the next transaction if different than the current one
   *
   * @default true */
  @Input() displayTextSeparator = true;

  /** The style of the line separator between the transactions (the rows). Bear in mind that the line separator will not appear if a text separator is already in the next row. If "hide", there will be no line separator in any case */
  @Input() lineBetweenTransaction: 'hide' | 'light' | 'medium' = 'light';

  /** Only applicable if we are in the list of recurring transactions. Otherwise it will be undefined. It is used to show the periodic cost in the event that the selected period is not the same as that of the recurring transaction
   *
   * @default undefined  */
  @Input() recurrentListTemporality: RecurrentOption = undefined;

  constructor(
    public lang: LangService,
    private transactionService: TransactionService
  ) {}

  ngOnInit() {}

  /** Returns true if the transaction has been done today */
  getIfToday(transaction: Transaction) {
    if (
      transaction.date.getDate() == currentDay &&
      transaction.date.getMonth() == currentMonth &&
      transaction.date.getFullYear() == currentYear
    ) {
      return true;
    } else {
      return false;
    }
  }

  /** Returns true if the transaction has been done yesterday */
  getIfYesterday(transaction: Transaction) {
    if (
      transaction.date.getDate() - 1 == currentDay &&
      transaction.date.getMonth() == currentMonth &&
      transaction.date.getFullYear() == currentYear
    ) {
      return true;
    } else {
      return false;
    }
  }

  /** Checks if two transactions are on the same day */
  checkIfSameDay(trans1: Transaction, trans2: Transaction) {
    if (
      trans1.date.getFullYear() == trans2.date.getFullYear() &&
      trans1.date.getMonth() == trans2.date.getMonth() &&
      trans1.date.getDate() == trans2.date.getDate()
    ) {
      return true;
    } else {
      return false;
    }
  }

  convertTransactionQuantity(transaction: Transaction) {
    return this.transactionService.getRecurrentTransactionValueByTemp(
      transaction,
      this.recurrentListTemporality
    );
  }

  getTransactionIcon(transaction: Transaction) {
    return this.transactionService.getTransactionIcon(transaction);
  }

  getTransactionColor(transaction: Transaction) {
    return this.transactionService.getTransactionColor(transaction);
  }
}
