import { formatDate } from '@angular/common';
import { Inject, Injectable, LOCALE_ID } from '@angular/core';
import { currentMonth, currentYear } from 'src/app/constants/constants';
import { LangService } from '../../translate/translate.service';
import { UtilsService } from '../../utils/utils.service';
import { DateRange } from './date-range.enum';

@Injectable({
  providedIn: 'root',
})
export class DateRangeService {
  dateRangeSelected: DateRange = DateRange.Monthly;

  startDate: Date;
  endDate: Date;

  constructor(
    private utils: UtilsService,
    private lang: LangService,
    @Inject(LOCALE_ID) private userLocale: string
  ) {}

  /** Get the start and the end of the current selected period */
  async getCurrentDateRange() {
    let startDate: Date;
    let endDate: Date;

    if (this.dateRangeSelected == DateRange.Custom) {
      return [this.startDate, this.endDate];
    } else if (this.dateRangeSelected == DateRange.Annualy) {
      startDate = new Date(currentYear, 0, 1);
      endDate = new Date(currentYear + 1, 0, 1);
    } else if (this.dateRangeSelected == DateRange.Monthly) {
      startDate = new Date(currentYear, currentMonth, 1);
      endDate = new Date(currentYear, currentMonth + 1, 1);
    } else if (this.dateRangeSelected == DateRange.Weekly) {
      startDate = await this.utils.getDateOfFirstDayOfWeek();
      endDate = await this.utils.getDateOfFirstDayOfWeek();
      endDate.setDate(endDate.getDate() + 7);
    } else if (this.dateRangeSelected == DateRange.Quaterly) {
      startDate = this.utils.getQuaterlyDate('startDate');
      endDate = this.utils.getQuaterlyDate('endDate');
    } else if (this.dateRangeSelected == DateRange.Infinite) {
      startDate = undefined;
      endDate = undefined;
    }

    return [startDate, endDate];
  }

  getPrevDateRange() {
    let startDate: Date;
    let endDate = this.startDate;

    if (this.dateRangeSelected == DateRange.Custom) {
      startDate = new Date(
        endDate.getFullYear(),
        endDate.getMonth(),
        endDate.getDate() - this.utils.getDateDiff(this.endDate, this.startDate)
      );
    } else if (this.dateRangeSelected == DateRange.Annualy) {
      startDate = new Date(
        endDate.getFullYear() - 1,
        endDate.getMonth(),
        endDate.getDate()
      );
    } else if (this.dateRangeSelected == DateRange.Monthly) {
      startDate = new Date(
        endDate.getFullYear(),
        endDate.getMonth() - 1,
        endDate.getDate()
      );
    } else if (this.dateRangeSelected == DateRange.Weekly) {
      startDate = new Date(
        endDate.getFullYear(),
        endDate.getMonth(),
        endDate.getDate() - 7
      );
    } else if (this.dateRangeSelected == DateRange.Quaterly) {
      startDate = new Date(
        endDate.getFullYear(),
        endDate.getMonth() - 3,
        endDate.getDate()
      );
    } else if (this.dateRangeSelected == DateRange.Infinite) {
      startDate = undefined;
      endDate = undefined;
    }

    return [startDate, endDate];
  }

  getNextDateRange() {
    let startDate = this.endDate;
    let endDate: Date;

    if (this.dateRangeSelected == DateRange.Custom) {
      endDate = new Date(
        startDate.getFullYear(),
        startDate.getMonth(),
        startDate.getDate() +
          this.utils.getDateDiff(this.endDate, this.startDate)
      );
    } else if (this.dateRangeSelected == DateRange.Annualy) {
      endDate = new Date(
        startDate.getFullYear() + 1,
        startDate.getMonth(),
        startDate.getDate()
      );
    } else if (this.dateRangeSelected == DateRange.Monthly) {
      endDate = new Date(
        startDate.getFullYear(),
        startDate.getMonth() + 1,
        startDate.getDate()
      );
    } else if (this.dateRangeSelected == DateRange.Weekly) {
      endDate = new Date(
        startDate.getFullYear(),
        startDate.getMonth(),
        startDate.getDate() + 7
      );
    } else if (this.dateRangeSelected == DateRange.Quaterly) {
      endDate = new Date(
        startDate.getFullYear(),
        startDate.getMonth() + 3,
        startDate.getDate()
      );
    } else if (this.dateRangeSelected == DateRange.Infinite) {
      startDate = undefined;
      endDate = undefined;
    }

    return [startDate, endDate];
  }

  /** Get the text to display in a period of the sliders */
  getDateRangeText(startDateRange: Date, endDateRange: Date) {
    if (!startDateRange && this.dateRangeSelected != DateRange.Infinite) {
      // startDate can not be null/undefined if the date range is not infinite
      return;
    }

    if (this.dateRangeSelected == DateRange.Monthly) {
      if (currentYear == startDateRange.getFullYear()) {
        return formatDate(startDateRange, 'MMMM', this.userLocale);
      } else {
        return formatDate(startDateRange, 'MMMM - yyyy', this.userLocale);
      }
    } else if (this.dateRangeSelected == DateRange.Annualy) {
      return String(startDateRange.getFullYear());
    } else if (this.dateRangeSelected == DateRange.Quaterly) {
      return (
        'Q' +
        (Math.ceil(startDateRange.getMonth() / 3) + 1) +
        ' - ' +
        startDateRange.getFullYear()
      );
    } else if (
      this.dateRangeSelected == DateRange.Custom ||
      this.dateRangeSelected == DateRange.Weekly
    ) {
      return (
        this.utils.setDateInDOM(startDateRange, undefined, 'no') +
        ' - ' +
        this.utils.setDateInDOM(endDateRange, undefined, 'no')
      );
    } else if (this.dateRangeSelected == DateRange.Infinite) {
      return this.lang.getTranslation('GENERAL.TIME.infinite');
    }
  }
}
