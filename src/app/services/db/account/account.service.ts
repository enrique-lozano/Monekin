import { Injectable } from '@angular/core';
import { Account } from 'src/app/services/db/account/account.model';
import { UserDataService } from '../user-data.service';

@Injectable({
  providedIn: 'root',
})
export class AccountService {
  private accounts: Account[];

  constructor(private userDataService: UserDataService) {}

  async getAccountByName(name: string) {
    return (await this.getAccounts()).find(
      (x) => x.name.toLowerCase() == name.toLowerCase()
    );
  }

  async getAccountByUUID(uuid: string) {
    return (await this.getAccounts()).find((x) => x.id == uuid);
  }

  async getAccounts() {
    if (!this.accounts) {
      await this.refreshAccounts();
    }

    return this.accounts;
  }

  async refreshAccounts() {
    this.accounts = (await this.userDataService.getUserData()).accounts || [];
    this.accounts = this.accounts.map((x) => new Account(x));
  }

  addAccount(account: Account) {
    if (!(account instanceof Account))
      throw new Error('You should pass an instance of a class to this method');

    this.accounts.push(account);

    return this.userDataService.setUserData({ accounts: this.accounts });
  }

  /** Edits a account
   *
   * @param uuid The id of the account to edit
   * @param editedAccount The new account instance to replace the found account
   */
  editAccount(uuid: string, editedAccount: Account) {
    if (!(editedAccount instanceof Account))
      throw new Error('You should pass an instance of a class to this method');

    this.accounts = this.accounts.map((acc) => {
      if (acc.id === uuid) return editedAccount;
      else return acc;
    });

    return this.userDataService.setUserData({
      accounts: this.accounts,
    });
  }

  deleteAccount(accountName: string) {
    //TODO: Delete transactions of this account

    this.accounts = this.accounts.filter(
      (account) => account.name != accountName
    );

    return this.userDataService.setUserData({ accounts: this.accounts });
  }
}
