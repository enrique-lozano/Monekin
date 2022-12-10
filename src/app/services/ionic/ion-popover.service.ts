import { Injectable } from '@angular/core';
import { PopoverController } from '@ionic/angular';
import {
  PopoverMenuComponent,
  PopoverMenuItem,
} from 'src/app/components/dialogs/popover-menu/popover-menu.component';

@Injectable({
  providedIn: 'root',
})
export class IonPopoverService {
  constructor(private popoverController: PopoverController) {}

  async openPopoverMenu(event: any, menuItems: PopoverMenuItem[]) {
    const popover = await this.popoverController.create({
      event,
      component: PopoverMenuComponent,
      componentProps: {
        menuItems,
      },
    });

    await popover.present();

    return popover.onDidDismiss<string>();
  }
}
