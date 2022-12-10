import { Injectable } from '@angular/core';
import { ToastController } from '@ionic/angular';
import { LangService } from '../translate/translate.service';

@Injectable({
  providedIn: 'root',
})
export class ToastService {
  constructor(
    private toastController: ToastController,
    private lang: LangService
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

    toast.present();
  }
}
