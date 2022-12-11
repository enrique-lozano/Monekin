import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AlertController, NavController } from '@ionic/angular';
import {
  IncomeOrExpense,
  Transaction,
  Transfer,
} from 'src/app/services/db/transaction/transaction.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { IonPopoverService } from 'src/app/services/ionic/ion-popover.service';
import { ToastService } from 'src/app/services/ionic/toast.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-recurring-transaction-details',
  templateUrl: './transaction-details.page.html',
  styleUrls: ['./transaction-details.page.scss'],
})
export class TransactionDetailsPage {
  transaction: Transaction;

  valueTillNow: number;

  constructor(
    public lang: LangService,
    private toast: ToastService,
    private router: Router,
    private activeRoute: ActivatedRoute,
    private transactionService: TransactionService,
    private alertController: AlertController,
    private popoverService: IonPopoverService,
    private navController: NavController
  ) {}

  async ionViewWillEnter() {
    const idToFind = this.activeRoute.snapshot.paramMap.get('id');

    if (!idToFind) {
      console.warn('Transaction ID not found');
      this.navController.back({
        animated: true,
        animationDirection: 'forward',
      });
    }

    this.transaction = await this.transactionService.getTransactionById(
      idToFind
    );

    this.valueTillNow = this.getValueTillNow();
  }

  goToEditTransaction() {
    this.router.navigate(['transaction-form', this.transaction.id], {
      queryParams: {
        mode: this.transaction.receivingAccount ? 'transfer' : 'transaction',
      },
    });
  }

  async openTransactionOptions(event: any) {
    const popoverResult = await this.popoverService.openPopoverMenu(event, [
      {
        id: 'duplicate',
        labelKey: 'TRANSACTION.duplicate',
        icon: 'duplicate-outline',
        hidden: this.transaction.repeat != undefined,
      },
      {
        id: 'pause',
        labelKey: 'RECURRENT-TRANSACTIONS.DETAILS.pause-header',
        icon: 'pause-outline',
        hidden: !this.transaction.repeat || this.isPauseDisabled(),
      },
      {
        id: 'delete',
        labelKey: 'GENERAL.delete',
        icon: 'trash-outline',
      },
    ]);

    if (popoverResult.data == 'delete') {
      await this.deleteTransaction();
    } else if (popoverResult.data == 'pause') {
      await this.pause();
    } else if (popoverResult.data == 'duplicate') {
      await this.cloneTransaction();
    }
  }

  protected isPauseDisabled() {
    if (!this.transaction?.repeat.endDate) return false;
    else if (this.transaction?.repeat.endDate > new Date()) return false;
    else return true;
  }

  protected async pause() {
    const alert = await this.alertController.create({
      cssClass: 'basicAlert',
      header: this.lang.getTranslation(
        'RECURRENT-TRANSACTIONS.DETAILS.pause-header'
      ),
      message: this.lang.getTranslation(
        'RECURRENT-TRANSACTIONS.DETAILS.pause-message'
      ),
      buttons: [
        {
          text: this.lang.getTranslation('GENERAL.confirm'),
          handler: () => {
            this.transaction.repeat.endDate = new Date();

            this.transactionService
              .editTransaction(this.transaction.id, this.transaction)
              .then(() => {});
          },
        },
      ],
    });

    await alert.present();
  }

  async deleteTransaction() {
    const alert = await this.alertController.create({
      cssClass: 'basicAlert',
      header: this.lang.getTranslation(
        this.transaction.repeat
          ? 'RECURRENT-TRANSACTIONS.DETAILS.delete-header'
          : 'TRANSACTION.delete'
      ),
      message: this.lang.getTranslation(
        this.transaction.repeat
          ? 'RECURRENT-TRANSACTIONS.DETAILS.delete-message'
          : 'TRANSACTION.delete.warning-message'
      ),
      buttons: [
        {
          text: this.lang.getTranslation('GENERAL.confirm'),
          handler: () => {
            this.transactionService
              .removeTransaction(this.transaction.id)
              .then(() => {
                this.navController.back({
                  animated: true,
                  animationDirection: 'forward',
                });

                this.toast.present(
                  this.transaction.repeat
                    ? 'RECURRENT-TRANSACTIONS.DETAILS.delete.success'
                    : 'TRANSACTION.delete.success'
                );
              });
          },
        },
      ],
    });

    await alert.present();
  }

  protected async cloneTransaction() {
    if (this.transaction instanceof IncomeOrExpense) {
      await this.transactionService.addTransaction(
        new IncomeOrExpense({
          account: this.transaction.account,
          category: this.transaction.category,
          date: this.transaction.date,
          value: this.transaction.value,
          repeat: this.transaction.repeat,
          text: this.transaction.text,
        })
      );
    } else if (this.transactionService instanceof Transfer) {
      await this.transactionService.addTransaction(
        new Transfer({
          account: this.transaction.account,
          receivingAccount: this.transaction.receivingAccount,
          date: this.transaction.date,
          value: this.transaction.value,
          valueInDestiny: this.transaction.valueInDestiny,
          repeat: this.transaction.repeat,
          text: this.transaction.text,
        })
      );
    }

    this.toast.present('TRANSACTION.duplicate.success');
  }

  protected getValueTillNow() {
    if (!this.transaction.repeat) return undefined;

    const transactions =
      this.transactionService.getTransactionsOfRecurringTransaction(
        this.transaction
      );

    let result = 0;
    transactions.forEach((trans) => {
      result += trans.value;
    });

    return Math.abs(result);
  }

  getTransactionIcon() {
    return this.transactionService.getTransactionIcon(this.transaction);
  }

  getTransactionColor() {
    return this.transactionService.getTransactionColor(this.transaction);
  }
}
