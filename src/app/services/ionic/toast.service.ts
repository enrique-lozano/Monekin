import { Injectable } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { ToastController } from '@ionic/angular';
import { LangService } from '../translate/translate.service';

@Injectable({
  providedIn: 'root',
})
export class ToastService {
  constructor(
    private toastController: ToastController,
    private lang: LangService,
    private router: Router
  ) {}

  /** Present a toast at the bottom of the page
   *
   * @param toastMessage The i18n key to translate and show in the toast
   * @param color The color of the toast. Defaults to "danger"
   * @param toastDuration Duration of the toast in ms. Defaults to 4000
   */
  async present(
    toastMessage: string,
    color: 'danger' | 'default' = 'default',
    toastDuration: number = 4000
  ) {
    const toast = await this.toastController.create({
      message: this.lang.getTranslation(toastMessage),
      duration: toastDuration,
      color: color == 'default' ? undefined : color,
    });

    /** The main fab button near the tabs (only in mobile) */
    const fabButton = document.getElementById(
      'add-transaction-mobile-fab'
    ) as HTMLElement;

    if (fabButton) {
      fabButton.style.transform = 'scale(0)';
    }

    /** The toast should be displayed above the bottomEl (if any) */
    let bottomEl = document.querySelector('app-tabs.show-on-mobile > *');

    if (
      bottomEl &&
      window.innerWidth <
        Number(
          getComputedStyle(document.documentElement)
            .getPropertyValue('--breakpoint-sm')
            .replace('px', '')
            .trim()
        )
    ) {
      toast.style.transform = `translateY(-${bottomEl.clientHeight}px)`;
    } else {
      bottomEl = document.querySelector('ion-footer');
      if (bottomEl) {
        toast.style.transform = `translateY(-${bottomEl.clientHeight}px)`;
      }
    }

    toast.present();

    setTimeout(() => {
      // With this timeout we are sure that the transition to another page is finished (if any). For example, when you navigate to another page and immediately open the toast
      const subscr = this.router.events.subscribe((val) => {
        if (val instanceof NavigationEnd) {
          toast.dismiss();
        }
      });

      toast.onDidDismiss().then(() => {
        subscr.unsubscribe();
      });
    }, 1500);

    toast.onDidDismiss().then(() => {
      fabButton.style.transform = '';
    });
  }
}
