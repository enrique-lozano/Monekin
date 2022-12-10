import { Component, OnInit } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { DateRangeService } from 'src/app/services/filters/date-range/date-range.service';

/* eslint-disable @typescript-eslint/naming-convention */
export enum DateRange {
  Weekly = 'Weekly',
  Monthly = 'Monthly',
  Quaterly = 'Quaterly',
  Annualy = 'Annualy',
  Infinite = 'Infinite',
  Custom = 'Custom',
}

@Component({
  selector: 'app-date-range-selector',
  templateUrl: './date-range-selector.component.html',
  styleUrls: ['./date-range-selector.component.scss'],
})
export class DateRangeSelectorComponent implements OnInit {
  selectedValue: DateRange;
  dateRanges = DateRange;

  constructor(
    private modalCtrl: ModalController,
    private dateRangeService: DateRangeService
  ) {}

  ngOnInit() {
    this.selectedValue = this.dateRangeService.dateRangeSelected;
  }

  async onOptionSelected(option: DateRange) {
    if (
      this.dateRangeService.dateRangeSelected != option ||
      option == DateRange.Custom
    ) {
      this.modalCtrl.dismiss(option);
    }
  }
}
