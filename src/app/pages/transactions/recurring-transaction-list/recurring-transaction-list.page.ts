import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';
import {
  RecurrentOption,
  Transaction,
} from 'src/app/services/db/transaction/transaction.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-recurring-transaction-list',
  templateUrl: './recurring-transaction-list.page.html',
  styleUrls: ['./recurring-transaction-list.page.scss'],
})
export class RecurringTransactionListPage implements OnInit {
  transactions: Transaction[];
  selectedTime: RecurrentOption = RecurrentOption.month;

  userCurrency: Currency;

  constructor(
    public lang: LangService,
    private currencyService: CurrencyService,
    private transactionService: TransactionService,
    private router: Router
  ) {}

  ngOnInit() {
    this.currencyService
      .getUserCurrency()
      .then((currency) => (this.userCurrency = currency));
  }

  async ionViewDidEnter() {
    this.transactions = (
      await this.transactionService.getTransactions(
        undefined,
        this.userCurrency.code,
        false
      )
    ).filter((x) => x.repeat != undefined);
  }

  /** @returns True if the current date is between the recurring transaction start date and the recurring transaction  end date, false otherwise  */
  isActive(transaction: Transaction) {
    if (
      transaction.date < new Date() &&
      (!transaction.repeat.endDate || transaction.repeat.endDate > new Date())
    ) {
      return true;
    } else {
      return false;
    }
  }

  getTotal() {
    let result = 0;
    this.transactions.forEach((transaction) => {
      if (this.isActive(transaction)) {
        result += this.transactionService.getRecurrentTransactionValueByTemp(
          transaction,
          this.selectedTime
        );
      }
    });

    return result;
  }

  changeSelectedTime() {
    if (this.selectedTime == RecurrentOption.week)
      this.selectedTime = RecurrentOption.month;
    else if (this.selectedTime == RecurrentOption.month)
      this.selectedTime = RecurrentOption.year;
    else if (this.selectedTime == RecurrentOption.year)
      this.selectedTime = RecurrentOption.week;
  }
}
