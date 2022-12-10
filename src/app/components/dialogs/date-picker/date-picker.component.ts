import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { SettingsService } from 'src/app/services/db/settings/settings.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-date-picker',
  templateUrl: './date-picker.component.html',
  styleUrls: ['./date-picker.component.scss'],
})
export class DatePickerComponent implements OnInit {
  date: any;
  firstDateOfWeek: number;

  @Input() iniValue = new Date();
  @Input() max: Date;
  @Input() min: Date;

  @Output() dateChange = new EventEmitter<Date>();

  constructor(
    private modalCtrl: ModalController,
    public lang: LangService,
    private settings: SettingsService
  ) {}

  async ngOnInit() {
    this.firstDateOfWeek = (await this.settings.getSettings()).firstDayOfWeek;
    if (this.iniValue) {
      this.date = (this.iniValue as Date).toISOString();
    }
  }

  getMin() {
    if (!this.min) return undefined;
    return this.min.toISOString();
  }

  getMax() {
    if (!this.max) return undefined;
    return this.max.toISOString();
  }

  confirm() {
    const datetime = document.querySelector('#picker') as any;
    datetime.confirm().then(() => {
      this.dateChange.emit(new Date(this.date));
      this.modalCtrl.dismiss(new Date(this.date));
    });
  }
}
