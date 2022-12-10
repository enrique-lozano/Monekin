import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Clipboard } from '@capacitor/clipboard';
import { AlertController } from '@ionic/angular';
import { OverlayEventDetail } from '@ionic/core';
import { DateRange } from 'src/app/components/dialogs/date-range-selector/date-range-selector.component';
import { AccountUtilsService } from 'src/app/services/account-utils/account-utils.service';
import { Account } from 'src/app/services/db/account/account.model';
import { AccountService } from 'src/app/services/db/account/account.service';
import { Transaction } from 'src/app/services/db/transaction/transaction.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { DateRangeService } from 'src/app/services/filters/date-range/date-range.service';
import { FilterService } from 'src/app/services/filters/filter.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { IonPopoverService } from 'src/app/services/ionic/ion-popover.service';
import { ToastService } from 'src/app/services/ionic/toast.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-account-details',
  templateUrl: './account-details.page.html',
  styleUrls: ['./account-details.page.scss'],
})
export class AccountDetailsPage {
  account: Account;

  startDate: Date;
  endDate: Date;

  /** All transactions of this account since the beggining of the times */ allTransactions: Transaction[];
  /** Transactions for this account in the selected period */ transactions: Transaction[];

  moneyInAccount: number;
  income: number;
  expense: number;

  constructor(
    public lang: LangService,
    public dateRangeService: DateRangeService,
    private modalService: IonModalService,
    private accountService: AccountService,
    private activeRoute: ActivatedRoute,
    private toast: ToastService,
    private transactionService: TransactionService,
    private accountUtils: AccountUtilsService,
    private popoverService: IonPopoverService,
    private alertController: AlertController,
    private router: Router,
    private filterService: FilterService
  ) {}

  async ionViewDidEnter() {
    this.account = await this.accountService.getAccountByUUID(
      this.activeRoute.snapshot.paramMap.get('id')
    );

    await this.initializeAccountStats();
    await this.getDateRangeStats(0);
  }

  async initializeAccountStats() {
    this.allTransactions = await this.transactionService.getTransactions({
      accountIds: [this.account.id],
    });

    this.moneyInAccount = await this.accountUtils.getAccountsMoney([
      this.account,
    ]);
  }

  async getDateRangeStats(delay: number) {
    this.transactions = undefined;
    this.income = undefined;
    this.expense = undefined;

    await new Promise((r) => setTimeout(r, delay));

    this.startDate = (await this.dateRangeService.getCurrentDateRange())[0];
    this.endDate = (await this.dateRangeService.getCurrentDateRange())[1];

    this.transactions = await this.transactionService.getTransactions({
      startDate: this.startDate,
      endDate: this.endDate,
      accountIds: [this.account.id],
    });

    this.income = await this.accountUtils.getAccountsData('Income', {
      accounts: [this.account],
      startDate: this.startDate,
      endDate: this.endDate,
    });
    this.expense = await this.accountUtils.getAccountsData('Expense', {
      accounts: [this.account],
      startDate: this.startDate,
      endDate: this.endDate,
    });
  }

  async openDateModal() {
    const newDateRange = await this.modalService.openDateRangeModal();

    if (newDateRange.data) {
      if (newDateRange.data != DateRange.Custom) {
        this.dateRangeService.dateRangeSelected = newDateRange.data;
        this.getDateRangeStats(100);
      } else {
        const customDateModal =
          await this.modalService.openCustomDateRangeModal();

        customDateModal
          .onDidDismiss()
          .then((hasSubmitted: OverlayEventDetail<boolean>) => {
            if (hasSubmitted.data) {
              this.getDateRangeStats(100);
            }
          });

        return customDateModal.present();
      }
    }
  }

  getImportantTransactions() {
    if (!this.transactions) return undefined;

    const transactions: Transaction[] = this.transactions
      ?.sort((x, y) => x.value - y.value)
      .filter((z) => z.value < 0);

    return transactions.slice(0, 5);
  }

  copyToClipboard(text: string, valueCopiedTranslationKey: string) {
    Clipboard.write({ string: text })
      .then(() => {
        this.toast.present(
          this.lang.getTranslation('GENERAL.CLIPBOARD.success', {
            x: this.lang.getTranslation(valueCopiedTranslationKey),
          }),
          'default'
        );
      })
      .catch(() => {
        this.toast.present(
          this.lang.getTranslation('GENERAL.CLIPBOARD.error', {
            x: this.lang.getTranslation(valueCopiedTranslationKey),
          }),
          'danger'
        );
      });
  }

  goToAccountStats() {
    this.filterService.selectedAccounts = [this.account];

    this.router.navigate(['tabs/tab3']);
  }

  async openAccountActions(event: any) {
    const popoverResult = await this.popoverService.openPopoverMenu(event, [
      {
        id: 'add-transaction',
        labelKey: 'TRANSACTION.new',
        icon: 'add-outline',
        hidden: this.account.type != 'normal',
      },
      {
        id: 'add-transfer',
        labelKey: 'TRANSFER.new',
        icon: 'swap-horizontal-outline',
        hidden: this.account.type != 'normal',
      },
      {
        id: 'add-money',
        labelKey: 'ACCOUNT.add_money',
        icon: 'arrow-up-outline',
        hidden: this.account.type != 'saving',
      },
      {
        id: 'add-transfer',
        labelKey: 'ACCOUNT.withdraw_money',
        icon: 'arrow-down-outline',
        hidden: this.account.type != 'saving',
      },
      {
        id: 'edit',
        labelKey: 'GENERAL.edit',
        icon: 'pencil-outline',
      },
      {
        id: 'delete',
        labelKey: 'GENERAL.delete',
        icon: 'trash-outline',
      },
    ]);

    if (popoverResult.data == 'edit') {
      this.editAccount();
    } else if (popoverResult.data == 'delete') {
      this.deleteAccount();
    } else if (popoverResult.data == 'add-transfer') {
      this.goToAddTransfer();
    } else if (popoverResult.data == 'add-money') {
      this.goToAddMoney();
    } else if (popoverResult.data == 'add-transaction') {
      this.goToAddTransaction();
    }
  }

  // ------------------ POPOVER ACTIONS ---------------------- //

  async goToAddMoney() {
    if ((await this.accountService.getAccounts()).length < 2) {
      const alert = this.twoAccountsNeededAlert();

      return (await alert).present();
    }

    this.router.navigate(['transaction-form'], {
      queryParams: { mode: 'transfer', to: this.account.name },
    });
  }

  async goToAddTransfer() {
    if ((await this.accountService.getAccounts()).length < 2) {
      const alert = this.twoAccountsNeededAlert();

      return (await alert).present();
    }

    this.router.navigate(['transaction-form'], {
      queryParams: { mode: 'transfer', from: this.account.name },
    });
  }

  private twoAccountsNeededAlert() {
    return this.alertController.create({
      header: this.lang.getTranslation(
        'TRANSFER.need-two-accounts.warning.header'
      ),
      message: this.lang.getTranslation(
        'TRANSFER.need-two-accounts.warning.message'
      ),
      buttons: [
        {
          text: 'OK',
        },
      ],
    });
  }

  goToAddTransaction() {
    this.router.navigate(['transaction-form'], {
      queryParams: { mode: 'transaction', from: this.account.name },
    });
  }

  editAccount() {
    this.router.navigate(['account-form', this.account.id]);
  }

  async deleteAccount() {
    const transactions = await this.transactionService.getTransactions({
      accountIds: [this.account.id],
      typeOfTransaction: 'all',
    });

    const alert = await this.alertController.create({
      cssClass: 'basicAlert',
      header: this.lang.getTranslation('ACCOUNT.DELETE.warning-header'),
      message: this.lang.getTranslation('ACCOUNT.DELETE.warning-text'),
      buttons: [
        {
          text: 'OK',
          handler: () => {
            this.accountService
              .deleteAccount(this.account.name)
              .then(() => {})
              .then(async () => {
                for (const trans of transactions) {
                  await this.transactionService.removeTransaction(trans.id);
                }

                this.router.navigate(['tabs']);
                this.toast.present('ACCOUNT.DELETE.success');
              })
              .catch((err) => {
                this.toast.present(err, 'danger');
              });
          },
        },
      ],
    });

    await alert.present();
  }
}
