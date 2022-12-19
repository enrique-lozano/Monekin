import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AccountUtilsService } from 'src/app/services/account-utils/account-utils.service';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';
import { Account } from 'src/app/services/db/account/account.model';
import { AccountService } from 'src/app/services/db/account/account.service';
import { SettingsService } from 'src/app/services/db/settings/settings.service';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { ToastService } from 'src/app/services/ionic/toast.service';

@Component({
  selector: 'app-account-form',
  templateUrl: './account-form.page.html',
  styleUrls: ['./account-form.page.scss'],
})
export class AccountFormPage implements OnInit {
  icon = 'home';
  currency: Currency;
  type: 'normal' | 'saving' = 'normal';

  form = new FormGroup({
    name: new FormControl('', Validators.required),
    currency: new FormControl('', Validators.required),
    text: new FormControl(''),
    iban: new FormControl(''),
    swift: new FormControl(''),
    balance: new FormControl<number>(undefined, [
      Validators.required,
      Validators.max(10000000000),
    ]),
  });

  accountToEdit: Account;

  constructor(
    private accountService: AccountService,
    private currencyService: CurrencyService,
    private toast: ToastService,
    private modalService: IonModalService,
    private router: Router,
    private activeRoute: ActivatedRoute,
    private settingSerive: SettingsService,
    private transactionService: TransactionService,
    private readonly accountUtils: AccountUtilsService
  ) {}

  async ngOnInit() {
    this.currency = this.currencyService.getCurrencyByCode(
      (await this.settingSerive.getSettings()).preferredCurrency
    );

    if (this.activeRoute.snapshot.paramMap.get('id')) {
      this.accountToEdit = await this.accountService.getAccountByUUID(
        this.activeRoute.snapshot.paramMap.get('id')
      );

      if (!this.accountToEdit) return;

      this.currency = this.currencyService.getCurrencyByCode(
        this.accountToEdit?.currency
      );

      this.form.controls.name.setValue(this.accountToEdit.name);

      for (const key of ['text', 'iban', 'swift']) {
        if (this.accountToEdit[key])
          this.form.controls[key].setValue(this.accountToEdit[key]);
      }

      this.form.controls.balance.setValue(
        await this.accountUtils.getAccountsMoney([this.accountToEdit])
      );

      this.icon = this.accountToEdit.icon;
    }

    this.form.controls.currency.setValue(this.currency.name);
  }

  async openCurrencyModal() {
    const modalResult = await this.modalService.openCurrencySelectorModal();

    if (modalResult.data) {
      this.currency = modalResult.data;
      this.form.controls.currency.setValue(this.currency.name);
    }
  }

  async openIconSelector() {
    const iconModalResult = await this.modalService.openIconSelectorModal(
      'ICON-SELECTOR.select-icon',
      this.icon,
      false,
      getComputedStyle(document.documentElement).getPropertyValue(
        '--ion-color-tertiary'
      ),
      getComputedStyle(document.documentElement).getPropertyValue(
        '--ion-color-primary'
      )
    );

    if (iconModalResult.data) {
      this.icon = iconModalResult.data.icon;
    }
  }

  async submit() {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    if (
      (await this.accountService.getAccountByName(this.form.value.name)) &&
      !(
        this.accountToEdit &&
        this.accountToEdit.name.toLowerCase() ==
          this.form.value.name.toLowerCase()
      )
    ) {
      this.toast.present('ACCOUNT.FORM.already-exists', 'danger');
      return;
    }

    const objToPost: Account = new Account({
      ...(this.accountToEdit && { id: this.accountToEdit.id }),
      iniValue: this.accountToEdit
        ? this.accountToEdit.iniValue +
          this.form.value.balance -
          (await this.accountUtils.getAccountsMoney([this.accountToEdit]))
        : this.form.value.balance,
      icon: this.icon,
      name: this.form.value.name,
      currency: this.currency.code,
      date: this.accountToEdit?.date ?? new Date(),
      type: this.accountToEdit?.type ?? this.type,
    });

    // Optional data:
    for (const key of ['text', 'iban', 'swift']) {
      if (objToPost[key]) objToPost[key] = this.form.value[key];
    }

    if (this.accountToEdit) {
      // ----- EDIT -----
      this.accountService
        .editAccount(this.accountToEdit.id, new Account(objToPost))
        .then(async () => {
          await this.transactionService.refreshTransactions();

          this.router.navigate(['account-details', this.accountToEdit.id], {
            replaceUrl: true,
          });
        });

      return;
    }

    // ----- CREATE -----

    this.accountService.addAccount(objToPost).then(() => {
      this.router.navigate(['/tabs/tab1'], { replaceUrl: true });
    });
  }
}
