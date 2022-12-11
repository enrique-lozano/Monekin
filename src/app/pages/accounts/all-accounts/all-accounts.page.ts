import { Component, OnInit } from '@angular/core';
import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';
import { AccountUtilsService } from 'src/app/services/account-utils/account-utils.service';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';
import { Account } from 'src/app/services/db/account/account.model';
import { AccountService } from 'src/app/services/db/account/account.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-all-accounts',
  templateUrl: './all-accounts.page.html',
  styleUrls: ['./all-accounts.page.scss'],
})
export class AllAccountsPage implements OnInit {
  accounts: (Account & { money: number })[];
  totalMoney: number;
  color: string;

  userCurrency: ISOCorrencyCodes;

  currencies: { money: number; currency: Currency }[] = [];

  constructor(
    public lang: LangService,
    private currencyService: CurrencyService,
    private accountService: AccountService,
    private accountUtils: AccountUtilsService
  ) {}

  ngOnInit() {}

  async ionViewDidEnter() {
    this.accounts = await Promise.all(
      (
        await this.accountService.getAccounts()
      ).map(async (acc) => ({
        ...acc,
        ...{
          money: await this.accountUtils.getAccountsMoney(
            [acc],
            (
              await this.currencyService.getUserCurrency()
            ).code
          ),
        },
      }))
    );

    this.totalMoney = this.accounts.reduce((a, b) => a + b.money, 0);

    this.accounts.forEach(async (account) => {
      const currencyToPush = this.currencies.find(
        (x) => x.currency.code == account.currency
      );

      if (currencyToPush) {
        currencyToPush.money += account.money;
      } else {
        this.currencies.push({
          money: account.money,
          currency: this.currencyService.getCurrencyByCode(account.currency),
        });
      }
    });

    this.color = getComputedStyle(document.documentElement)
      .getPropertyValue('--ion-color-primary')
      .split('#')[1];
  }
}
