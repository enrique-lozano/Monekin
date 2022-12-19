import { Component, OnInit } from '@angular/core';
import { PopoverController } from '@ionic/angular';

@Component({
  selector: 'app-select-type-of-category',
  templateUrl: './select-type-of-category.component.html',
  styleUrls: ['./select-type-of-category.component.scss'],
})
export class SelectTypeOfCategoryComponent implements OnInit {
  currentSelection: 'expense' | 'income';

  constructor(private popover: PopoverController) {}

  ngOnInit() {}

  selectItem(selected: 'expense' | 'income') {
    this.popover.dismiss(selected);
  }
}
