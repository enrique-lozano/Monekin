import { Component, Input, OnInit } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { Account } from 'src/app/services/db/account/account.model';
import { AccountService } from 'src/app/services/db/account/account.service';

@Component({
  selector: 'app-account-selector',
  templateUrl: './account-selector.component.html',
  styleUrls: ['./account-selector.component.scss'],
})
export class AccountSelectorComponent implements OnInit {
  /** All the accounts of the user, selected or not */
  allAccounts: Account[];

  /** Array with the accounts selected by the user. Should have always only one item if allowMultiSelection is set to false */
  @Input() selectedAccounts: 'all' | Account[];

  /** Allows the user to select more than one account */
  @Input() allowMultiSelection: boolean;

  /** Hide/Disable the saving accounts in the selector */
  @Input() filterSavingAccounts: boolean;

  constructor(
    private readonly accountService: AccountService,
    private modalCtrl: ModalController
  ) {}

  async ngOnInit() {
    this.allAccounts = await this.accountService.getAccounts();
    if (this.filterSavingAccounts) {
      this.allAccounts = this.allAccounts.filter((x) => x.type != 'saving');
    }

    if (!this.selectedAccounts) this.selectedAccounts = [this.allAccounts[0]];
  }

  select(account: Account) {
    this.selectedAccounts = [account];
    this.submit();
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }

  isChecked(account: Account) {
    return (
      this.selectedAccounts == 'all' ||
      this.selectedAccounts.find((x) => x.name == account.name)
    );
  }

  onCheckboxChange(event: any, account: Account) {
    if (event.detail.checked === true && this.selectedAccounts != 'all') {
      this.selectedAccounts.push(account);
      if (this.selectedAccounts.length == this.allAccounts.length) {
        this.selectedAccounts = 'all';
      }
    } else if (event.detail.checked === false) {
      if (this.selectedAccounts != 'all') {
        this.selectedAccounts = this.selectedAccounts.filter(
          (x) => x != account
        );
      } else {
        this.selectedAccounts = this.allAccounts.filter(
          (x) => x.id != account.id
        );
      }
    } else {
      throw new Error('Checked property of IonCheckbox can not be found');
    }
  }

  submit() {
    this.modalCtrl.dismiss(this.selectedAccounts);
  }
}
