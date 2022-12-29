import { formatDate } from '@angular/common';
import { Component, Inject, LOCALE_ID } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { AlertController, NavController } from '@ionic/angular';
import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';
import { ExchangeRatesService } from 'src/app/services/currency/exchange-rates.service';
import { Account } from 'src/app/services/db/account/account.model';
import { AccountService } from 'src/app/services/db/account/account.service';
import {
  Category,
  ChildCategory,
  MainCategory,
} from 'src/app/services/db/category/category.model';
import { CategoryService } from 'src/app/services/db/category/category.service';
import { SettingsService } from 'src/app/services/db/settings/settings.service';
import {
  IncomeOrExpense,
  RecurrentOption,
  Transaction,
  Transfer,
} from 'src/app/services/db/transaction/transaction.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { ToastService } from 'src/app/services/ionic/toast.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { UtilsService } from 'src/app/services/utils/utils.service';

@Component({
  selector: 'app-transaction-form',
  templateUrl: './transaction-form.page.html',
  styleUrls: ['./transaction-form.page.scss'],
})
export class TransactionFormPage {
  // --------- PARAMS OF THE CURRENT TRANSACTION TO POST ------------ //

  value = '0';
  selectedDate = new Date();
  description = '';

  movementFrom: Account;

  /** Can be the specific data of the selected category (in case of transactions) or the destiny account data (for transfers) */
  movementDestiny: Account | Category;

  repetition: 'no' | RecurrentOption = 'no';
  /** Only used for recurrent movements */ dateEnd: Date;

  /** Movement to edit (only defined when editing) */
  movementToEdit: Transaction;

  /** Selected exchange rate in a transfer between accounts with different currencies. Should be undefined or 1 in any other cases  */
  exchangeRateForTransfer: number;

  // --------- OTHER USEFULL PARAMS ------------ //

  /** To see if we are going to post a transfer between accounts or an Income/Expense */
  mode: 'Transfer' | 'Transaction';

  buttons = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    ['.', 0, '<-'],
  ];

  userPreferredCurrency: ISOCorrencyCodes;

  /** In the event that the currency of the transaction to be added is different from the one preferred by the user, we indicate the current equivalent of the transaction in their preferred currency */
  exchangeToPreferredCurrency = 0;

  constructor(
    @Inject(LOCALE_ID) private readonly userLocale: string,
    private lang: LangService,
    private toast: ToastService,
    private ionModal: IonModalService,
    private alertCtrl: AlertController,
    private utils: UtilsService,
    private categoryService: CategoryService,
    private exchangeRateService: ExchangeRatesService,
    private navController: NavController,
    private activeRoute: ActivatedRoute,
    private readonly accountService: AccountService,
    private transactionService: TransactionService,
    private settingsService: SettingsService
  ) {}

  async ionViewWillEnter() {
    if (this.activeRoute.snapshot.queryParamMap.get('mode') == 'transfer') {
      this.mode = 'Transfer';
    } else if (
      this.activeRoute.snapshot.queryParamMap.get('mode') == 'transaction'
    ) {
      this.mode = 'Transaction';
    } else {
      throw new Error(
        "Route has a mandatory queryparam called 'mode', that should be 'transfer' or 'transaction'"
      );
    }

    const idToFind = this.activeRoute.snapshot.paramMap.get('id');

    // EDIT MODE ->
    if (idToFind) {
      this.movementToEdit = await this.transactionService.getTransactionById(
        idToFind
      );

      if (this.movementToEdit) this.fillData();

      return;
    }

    // ADD MODE ->
    if (this.activeRoute.snapshot.queryParamMap.get('from')) {
      this.movementFrom = await this.accountService.getAccountByName(
        this.activeRoute.snapshot.queryParamMap.get('from')
      );
    } else {
      this.movementFrom = (await this.accountService.getAccounts())[0];
    }

    if (this.mode == 'Transaction') {
      if (this.categoryService.selectedCategory)
        this.movementDestiny = this.categoryService.selectedCategory;
    } else if (this.mode == 'Transfer') {
      if (this.activeRoute.snapshot.queryParamMap.get('to')) {
        this.movementDestiny = await this.accountService.getAccountByName(
          this.activeRoute.snapshot.queryParamMap.get('to')
        );

        this.exchangeRateForTransfer =
          await this.exchangeRateService.getExchangeRate(
            this.movementFrom.currency,
            (this.movementDestiny as Account).currency
          );

        await this.setExchangeRateForTransfers();

        return;
      }

      this.movementDestiny = (await this.accountService.getAccounts()).find(
        (x) => x.name != this.movementFrom.name
      );
    }
  }

  async ionViewDidEnter() {
    this.userPreferredCurrency = (
      await this.settingsService.getSettings()
    ).preferredCurrency;
  }

  /** Set the page params in case we are editing a transaction */
  fillData() {
    this.repetition = this.movementToEdit.repeat
      ? this.movementToEdit.repeat.temp
      : 'no';
    if (this.movementToEdit.repeat) {
      this.selectedDate = this.movementToEdit.date;
      this.dateEnd = this.movementToEdit.repeat.endDate;
    }

    this.value = String(Math.abs(this.movementToEdit.value));
    this.description = this.movementToEdit.text;
    this.selectedDate = this.movementToEdit.date;

    this.movementFrom = this.movementToEdit.account;

    if (this.mode == 'Transaction') {
      this.movementDestiny = this.movementToEdit.category;
      if (
        this.movementDestiny instanceof MainCategory &&
        this.movementDestiny.type == 'B'
      ) {
        if (this.movementToEdit.value > 0) this.movementDestiny.type = 'I';
        else if (this.movementToEdit.value < 0) this.movementDestiny.type = 'E';
      } else if (
        this.movementDestiny instanceof ChildCategory &&
        this.movementDestiny.parentCategory.type == 'B'
      ) {
        if (this.movementToEdit.value > 0)
          this.movementDestiny.parentCategory.type = 'I';
        else if (this.movementToEdit.value < 0)
          this.movementDestiny.parentCategory.type = 'E';
      }
    } else if (this.mode == 'Transfer') {
      this.movementDestiny = this.movementToEdit.receivingAccount;
      this.exchangeRateForTransfer =
        this.movementToEdit.valueInDestiny / this.movementToEdit.value;
    }

    this.getExchangeToPreferredCurrency().then((res) => {
      this.exchangeToPreferredCurrency = res;
    });
  }

  toNumber(x: string) {
    return Number(x);
  }

  getDateInDom() {
    // Recurrent:
    if (this.repetition != 'no') {
      if (this.selectedDate && this.dateEnd) {
        return (
          formatDate(this.selectedDate, 'mediumDate', this.userLocale) +
          ' - ' +
          formatDate(this.dateEnd, 'mediumDate', this.userLocale)
        );
      } else if (this.selectedDate) {
        return (
          formatDate(this.selectedDate, 'mediumDate', this.userLocale) +
          ' - ' +
          this.lang.getTranslation('GENERAL.TIME.infinite')
        );
      }
    }

    // Non-recurrent:
    const date = this.utils.setDateInDOM(this.selectedDate);
    if (date == 'GENERAL.today' || date == 'GENERAL.yesterday') {
      return (
        this.lang.getTranslation(date) +
        ', ' +
        formatDate(this.selectedDate, 'mediumDate', this.userLocale)
      );
    } else {
      return date;
    }
  }

  butPress(num: any) {
    if (num == '<-') {
      this.value = this.value.slice(0, -1);
      if (this.value == '') {
        this.value = '0';
      }
    } else if (num == 'AC') {
      this.value = '0';
    } else {
      if (
        this.value.length > 13 ||
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
      }
    }

    if (this.value.length > 9) {
      document.getElementById('value').style.fontSize = '3.75vh';
    } else if (this.value.length > 6) {
      document.getElementById('value').style.fontSize = '5vh';
    } else if (this.value.length > 4) {
      document.getElementById('value').style.fontSize = '6vh';
    } else {
      document.getElementById('value').style.fontSize = '8vh';
    }

    this.getExchangeToPreferredCurrency().then((res) => {
      this.exchangeToPreferredCurrency = res;
    });
  }

  async getExchangeToPreferredCurrency() {
    return (
      Number(this.value) *
      (await this.exchangeRateService.getExchangeRate(
        this.movementFrom.currency,
        this.userPreferredCurrency ??
          (
            await this.settingsService.getSettings()
          ).preferredCurrency
      ))
    );
  }

  async selectDate() {
    if (this.repetition != 'no') return this.setRecurrent();

    const dateModal = await this.ionModal.openDatePickerModal(
      this.selectedDate
    );

    dateModal.onDidDismiss().then((res) => {
      if (res.data) this.selectedDate = res.data;
    });

    return dateModal.present();
  }

  /** Edit or add a description for the current transaction */
  async setDescription() {
    const alert = await this.alertCtrl.create({
      inputs: [
        {
          name: 'note',
          placeholder: this.lang.getTranslation(
            'TRANSACTION.FORM.description.add'
          ),
          value: this.description,
        },
      ],
      header: this.lang.getTranslation('TRANSACTION.FORM.description'),
      message: this.lang.getTranslation('TRANSACTION.FORM.description-info'),
      buttons: [
        {
          text: this.lang.getTranslation('GENERAL.cancel'),
          role: 'cancel',
          handler: () => {
            console.log('Cancel clicked');
          },
        },
        {
          text: 'OK',
          handler: (data) => {
            this.description = data.note;
          },
        },
      ],
    });

    await alert.present().then(() => {
      const firstInput: HTMLElement = document.querySelector('ion-alert input');
      firstInput.focus();
      firstInput.setAttribute('maxlength', '30');
      return;
    });
  }

  async setRecurrent() {
    const modalResult = await this.ionModal.openRecurrentModal(
      this.repetition,
      this.selectedDate,
      this.dateEnd
    );

    if (modalResult.data) {
      this.repetition = modalResult.data.repetition;
      this.selectedDate = modalResult.data.dateStart;
      if (modalResult.data.dateEnd) {
        this.dateEnd = modalResult.data.dateEnd;
      } else {
        this.dateEnd = undefined;
      }
    }
  }

  async openTransferObjetiveModal() {
    const valueInDestiny = Number(this.value) * this.exchangeRateForTransfer;

    const modalResult = await this.ionModal.openCurrencyExchangeSelector(
      Number(this.value),
      Math.round((this.exchangeRateForTransfer + Number.EPSILON) * 100) / 100,
      Math.round((valueInDestiny + Number.EPSILON) * 100) / 100
    );

    if (modalResult.data) {
      this.exchangeRateForTransfer = modalResult.data;
    }
  }

  /** Calculate and set the exchange rate for a transfer between two accounts of different currencies */
  async setExchangeRateForTransfers() {
    if (
      this.mode != 'Transfer' ||
      this.movementFrom.currency === (this.movementDestiny as Account).currency
    ) {
      this.exchangeRateForTransfer = undefined;
      return;
    }

    this.exchangeRateForTransfer =
      await this.exchangeRateService.getExchangeRate(
        this.movementFrom.currency,
        (this.movementDestiny as Account).currency
      );
  }

  async openAccountSelector(toSelect: 1 | 2 = 1) {
    const modalResult = await this.ionModal.openAccountSelectorModal(
      toSelect == 1
        ? [this.movementFrom]
        : [await this.accountService.getAccountByUUID(this.movementDestiny.id)],
      false,
      this.mode == 'Transaction'
    );

    if (modalResult.data) {
      if (modalResult.data == 'all') {
        throw new Error('Multiple accounts should not be selected here');
      } else {
        if (toSelect == 1) this.movementFrom = modalResult.data[0];
        if (toSelect == 2) this.movementDestiny = modalResult.data[0];

        this.getExchangeToPreferredCurrency().then((res) => {
          this.exchangeToPreferredCurrency = res;
        });
      }

      this.setExchangeRateForTransfers().then(() => {});
    }
  }

  async goToCategoriesList() {
    const modalResult = await this.ionModal.openCategorySelectorModal(
      'modal-with-subcats'
    );

    if (modalResult.data) {
      if (modalResult.data == 'all') {
        throw new Error('Multiple categories should not be selected here');
      } else {
        this.movementDestiny = modalResult.data[0];
      }
    }

    return;
  }

  getCategoryColor() {
    return this.categoryService.getCategoryColor(
      this.movementDestiny as Category
    );
  }

  async postMovement() {
    // If category not selected
    if (!this.movementDestiny) {
      //this.openAlert('Selecciona una categoria antes de continuar');
      document.getElementById('category-selector').classList.add('headShake');
      setTimeout(() => {
        document
          .getElementById('category-selector')
          .classList.remove('headShake');
      }, 1000);
      return;
    }

    this.postTransaction();
  }

  private postTransaction() {
    let postObject: Transaction;

    if (this.mode == 'Transaction') {
      postObject = new IncomeOrExpense({
        value: Number(
          (this.movementDestiny.type == 'I' ? '+' : '-').concat(this.value)
        ),
        date: this.selectedDate,
        account: this.movementFrom,
        ...(this.movementToEdit && {
          id: this.movementToEdit.id,
        }),
        category: this.movementDestiny as Category,
      });
    } else if (this.mode == 'Transfer') {
      postObject = new Transfer({
        value: Number(this.value),
        date: this.selectedDate,
        account: this.movementFrom,
        ...(this.movementToEdit && {
          id: this.movementToEdit.id,
        }),
        ...(this.exchangeRateForTransfer && {
          valueInDestiny: Number(this.value) * this.exchangeRateForTransfer,
        }),
        receivingAccount: this.movementDestiny as Account,
      });
    }

    if (this.description) postObject.text = this.description;

    if (this.repetition != 'no') {
      postObject.repeat = {
        temp: this.repetition,
      };

      postObject.repeat.endDate = this.dateEnd;
    }

    if (this.movementToEdit) {
      this.transactionService
        .editTransaction(this.movementToEdit.id, postObject)
        .then(() => {
          this.navController.back({
            animated: true,
            animationDirection: 'forward',
          });

          this.toast.present('TRANSACTION.edit.success');
        });

      return;
    }

    this.transactionService.addTransaction(postObject).then(() => {
      this.navController.back({
        animated: true,
        animationDirection: 'forward',
      });

      this.toast.present('TRANSACTION.new.success');
    });
  }
}
