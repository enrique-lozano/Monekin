import { Component, OnInit } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { RecurrentOption } from 'src/app/services/db/transaction/transaction.model';
import { UtilsService } from 'src/app/services/utils/utils.service';

@Component({
  selector: 'app-recurrent-selector',
  templateUrl: './recurrent-selector.component.html',
  styleUrls: ['./recurrent-selector.component.scss'],
})
export class RecurrentSelectorComponent implements OnInit {
  repetition: 'no' | RecurrentOption = 'no';

  until: 'forever' | 'endDate' = 'forever';
  dateStart: Date;
  dateEnd: Date;

  constructor(
    private utils: UtilsService,
    private modalCtrl: ModalController
  ) {}

  ngOnInit() {}

  onUntilChange() {
    if (this.until == 'forever') this.dateEnd = undefined;
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }

  submit() {
    if (this.repetition != 'no' && !this.dateStart) {
      document
        .getElementById('open-start-date-input')
        .classList.remove('ion-valid');
      document
        .getElementById('open-start-date-input')
        .classList.add('ion-invalid');
      document
        .getElementById('open-start-date-input')
        .classList.add('ion-dirty');
      document
        .getElementById('open-start-date-input')
        .classList.add('ion-touched');

      return;
    }
    this.modalCtrl.dismiss({
      repetition: this.repetition,
      dateStart: this.dateStart,
      dateEnd: this.dateEnd,
    });
  }

  formatDate(date: Date) {
    if (!date || this.repetition == 'no') return '';

    return this.utils.setDateInDOM(date, 'longDate', 'translated');
  }

  setStartDate(date: Date) {
    document.getElementById('open-start-date-input').classList.add('ion-valid');
    document
      .getElementById('open-start-date-input')
      .classList.remove('ion-invalid');
    this.dateStart = date;
  }

  setEndDate(date: Date) {
    document
      .getElementById('open-end-date-input')
      .classList.remove('ion-invalid');
    document.getElementById('open-end-date-input').classList.add('ion-valid');
    this.dateEnd = date;
  }
}
