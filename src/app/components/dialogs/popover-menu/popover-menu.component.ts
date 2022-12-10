import { Component, Input } from '@angular/core';
import { PopoverController } from '@ionic/angular';

export interface PopoverMenuItem {
  /** Id of the item. When the item is selected, the popover will return this id on the onDismiss event */
  id: string;

  /** An i18n key to be translated in the item */
  labelKey: string;

  icon?: string;
  hidden?: boolean;
  disabled?: boolean;
}

@Component({
  selector: 'app-popover-menu',
  templateUrl: './popover-menu.component.html',
  styleUrls: ['./popover-menu.component.scss'],
})
/** Display a list menu that should appear in a popover */
export class PopoverMenuComponent {
  @Input() menuItems: PopoverMenuItem[];

  constructor(private popoverController: PopoverController) {}

  clickElement(item: PopoverMenuItem) {
    this.popoverController.dismiss(item.id);
  }
}
