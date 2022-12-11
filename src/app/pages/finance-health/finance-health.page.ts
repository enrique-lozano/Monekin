import { Component, OnInit } from '@angular/core';
import { OverlayEventDetail } from '@ionic/core';
import { DateRange } from 'src/app/components/dialogs/date-range-selector/date-range-selector.component';
import { DateRangeService } from 'src/app/services/filters/date-range/date-range.service';
import { FinanceHealthService } from 'src/app/services/finance-health/finance-health.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { UtilsService } from 'src/app/services/utils/utils.service';

@Component({
  selector: 'app-finance-health',
  templateUrl: './finance-health.page.html',
  styleUrls: ['./finance-health.page.scss'],
})
export class FinanceHealthPage implements OnInit {
  healthyValue: number;
  monthsWithoutIncome: number;
  savingsPercentage: number;

  healthyColor: string;

  healthyReview: 'very_bad' | 'bad' | 'normal' | 'good' | 'very_good';
  monthsReview: 'very_bad' | 'bad' | 'normal' | 'good' | 'insufficient_data';
  savingsPercentageReview: 'very_bad' | 'bad' | 'normal' | 'good';

  constructor(
    public lang: LangService,
    private financeHealthService: FinanceHealthService,
    private utils: UtilsService,
    private dateRangeService: DateRangeService,
    private modalService: IonModalService
  ) {}

  ngOnInit() {
    this.getData();
  }

  async getData() {
    this.healthyValue = await this.financeHealthService.getHealthyValue();
    this.monthsWithoutIncome =
      await this.financeHealthService.getMonthsWithoutIncome();
    this.savingsPercentage =
      await this.financeHealthService.getSavingPercentage();

    this.healthyColor = this.utils.hslToHex(
      this.financeHealthService.getHealthyColor(this.healthyValue),
      100,
      35
    );

    // Review labels:

    this.healthyReview = this.financeHealthService.getHealthyValueReview(
      this.healthyValue
    );

    this.savingsPercentageReview =
      this.financeHealthService.getSavingsPercentageReview(
        this.savingsPercentage
      );

    this.monthsReview = this.financeHealthService.getMonthsWithoutIncomeReview(
      this.monthsWithoutIncome
    );
  }

  async openDateModal() {
    const dateModalRes = await this.modalService.openDateRangeModal();

    if (dateModalRes.data) {
      if (dateModalRes.data != DateRange.Custom) {
        this.dateRangeService.dateRangeSelected = dateModalRes.data;

        const startDate = (
          await this.dateRangeService.getCurrentDateRange()
        )[0];
        const endDate = (await this.dateRangeService.getCurrentDateRange())[1];

        this.dateRangeService.startDate = startDate;
        this.dateRangeService.endDate = endDate;

        this.getData();
      } else {
        const customDateModal =
          await this.modalService.openCustomDateRangeModal();

        customDateModal
          .onDidDismiss()
          .then((hasSubmitted: OverlayEventDetail<boolean>) => {
            if (hasSubmitted.data) this.getData();
          });

        return customDateModal.present();
      }
    }
  }
}
