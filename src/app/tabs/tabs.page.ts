import { Component } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { NavController } from '@ionic/angular';

@Component({
  selector: 'app-tabs',
  templateUrl: 'tabs.page.html',
  styleUrls: ['tabs.page.scss'],
})
export class TabsPage {
  currentURL: string = 'tab1';

  constructor(private router: Router, private navCtrl: NavController) {
    this.router.events.subscribe((res) => {
      if (res instanceof NavigationEnd) {
        this.currentURL = this.router.url;
        if (this.currentURL.indexOf('/tabs/') != -1) {
          document.querySelector('app-tabs')?.classList.add('show-on-mobile');
        } else {
          document
            .querySelector('app-tabs')
            ?.classList.remove('show-on-mobile');
        }
      }
    });
  }

  goTo(path: string) {
    this.navCtrl.navigateForward(path, { animated: false });
  }
}
