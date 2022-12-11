import { Component } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { AlertController, NavController } from '@ionic/angular';
import { AccountService } from 'src/app/services/db/account/account.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-tabs',
  templateUrl: 'tabs.page.html',
  styleUrls: ['tabs.page.scss'],
})
export class TabsPage {
  currentURL: string = 'tab1';

  constructor(
    private router: Router,
    private navCtrl: NavController,
    private lang: LangService,
    private accountService: AccountService,
    private alertController: AlertController
  ) {
    this.router.events.subscribe((res) => {
      if (res instanceof NavigationEnd) {
        this.currentURL = this.router.url;

        if (this.currentURL.indexOf('/tabs/') != -1) {
          // If we are on one of the tabs:
          document.querySelector('app-tabs')?.classList.add('show-on-mobile');
        } else {
          document
            .querySelector('app-tabs')
            ?.classList.remove('show-on-mobile');

          document
            .getElementById('add-transaction-mobile-fab')
            .classList.add('hide');
        }
      }
    });
  }

  goTo(path: string) {
    this.navCtrl.navigateForward(path, { animated: false });
  }

  async goToAddTransaction() {
    const accounts = await this.accountService.getAccounts();

    if (!accounts.length) {
      const alert = await this.alertController.create({
        cssClass: 'basicAlert',
        header: this.lang.getTranslation('TABS.should-create-account.header'),
        message: this.lang.getTranslation('TABS.should-create-account.message'),
        buttons: [
          {
            text: this.lang.getTranslation('GENERAL.confirm'),
            handler: () => {},
          },
        ],
      });

      await alert.present();

      return;
    }

    this.router.navigate(['transaction-form'], {
      queryParams: { mode: 'transaction' },
    });
  }
}
