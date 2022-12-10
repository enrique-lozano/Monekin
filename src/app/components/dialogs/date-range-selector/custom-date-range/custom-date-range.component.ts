import { Component, OnInit } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { DateRangeService } from 'src/app/services/filters/date-range/date-range.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { DateRange } from '../date-range-selector.component';

@Component({
  selector: 'app-custom-date-range',
  templateUrl: './custom-date-range.component.html',
  styleUrls: ['./../date-range-selector.component.scss'],
})
export class CustomDateRangeComponent implements OnInit {
  startDate: Date;
  endDate: Date;

  constructor(
    private modalCtrl: ModalController,
    private ionModal: IonModalService,
    public dateRangeService: DateRangeService,
    public lang: LangService
  ) {}

  ngOnInit() {
    this.startDate =
      this.dateRangeService.startDate ??
      new Date(new Date().getFullYear(), 0, 1);
    this.endDate = this.dateRangeService.endDate ?? new Date();
  }

  async selectDate(toSelect: 'Start' | 'End') {
    const dateModal = await this.ionModal.openDatePickerModal(
      toSelect == 'Start' ? this.startDate : this.endDate
    );

    dateModal.onDidDismiss().then((res) => {
      if (res.data) {
        if (toSelect == 'Start') this.startDate = res.data;
        else if (toSelect == 'End') this.endDate = res.data;
      }
    });

    return dateModal.present();
  }

  submit() {
    this.dateRangeService.dateRangeSelected = DateRange.Custom;
    this.dateRangeService.startDate = this.startDate;
    this.dateRangeService.endDate = this.endDate;

    this.modalCtrl.dismiss(true);
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }
}
