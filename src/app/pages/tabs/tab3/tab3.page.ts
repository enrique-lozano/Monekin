import { ChangeDetectorRef, Component, ViewChild } from '@angular/core';
import { OverlayEventDetail } from '@ionic/core';
import { DateRange } from 'src/app/components/dialogs/date-range-selector/date-range-selector.component';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { DateRangeService } from 'src/app/services/filters/date-range/date-range.service';
import { FilterService } from 'src/app/services/filters/filter.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { StatusBarService } from 'src/app/services/ionic/status-bar.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { SwiperComponent } from 'swiper/angular';
import { SwiperOptions } from 'swiper/types';

@Component({
  selector: 'app-tab3',
  templateUrl: 'tab3.page.html',
  styleUrls: ['tab3.page.scss'],
})
export class Tab3Page {
  slide0Dates: { start: Date; end: Date };
  slide1Dates: { start: Date; end: Date };
  slide2Dates: { start: Date; end: Date };

  /** Current index for the swiperTransactions component */
  slideIndex: 0 | 1 | 2 = 1; // Initialize as initialSlide

  isFilterActive = false;

  constructor(
    public lang: LangService,
    public dateRangeService: DateRangeService,
    public filterService: FilterService,
    private changeDet: ChangeDetectorRef,
    private statusBar: StatusBarService,
    private transactionService: TransactionService,
    private modalService: IonModalService
  ) {}

  swiperGraphsConfig: SwiperOptions = {
    autoHeight: true,
    loop: true,
    initialSlide: 1,
  };

  @ViewChild('swiperGraphs') swiperGraphs: SwiperComponent;

  ionViewWillEnter() {
    this.statusBar.setPrimaryStatusBar();
    this.isFilterActive = this.filterService.isFilterActive();
    document.getElementsByTagName('ion-fab')[0].classList.remove('hide');
  }

  ionViewDidEnter() {
    this.refreshData();

    if (this.swiperGraphs) {
      this.swiperGraphs.updateSwiper({});
    }
  }

  slideNext() {
    this.swiperGraphs.swiperRef.slideNext();
  }

  slidePrev() {
    this.swiperGraphs.swiperRef.slidePrev();
  }

  slideChanged(transitionedTo: 'Left' | 'Right') {
    if (!this.swiperGraphs.swiperRef) {
      setTimeout(() => {}, 1200);
      return;
    }

    //* Slides may not display data correctly if many slides are transitioned at the same time. When this happens this function is only called once, since it is triggered when the animation ends, however, the slides have changed more than once. This is highly unlikely with the current swiper configuration, but it could happen.

    if (transitionedTo == 'Left') {
      let startDate = this.dateRangeService.getPrevDateRange()[0];
      let endDate = this.dateRangeService.getPrevDateRange()[1];

      this.dateRangeService.endDate = endDate;
      this.dateRangeService.startDate = startDate;

      if (this.slideIndex === 2) this.slideIndex = 1;
      else if (this.slideIndex === 1) this.slideIndex = 0;
      else if (this.slideIndex === 0) this.slideIndex = 2;
      else console.warn('Slide index out of bounds');

      // Refresh the data if the index is incorrect. The index will be wrong if we transition multiple slides at once.
      if (this.slideIndex != this.swiperGraphs.swiperRef.realIndex) {
        for (
          let i = 0;
          i < Math.abs(this.slideIndex - this.swiperGraphs.swiperRef.realIndex);
          i++
        ) {
          startDate = this.dateRangeService.getPrevDateRange()[0];
          endDate = this.dateRangeService.getPrevDateRange()[1];

          this.dateRangeService.endDate = endDate;
          this.dateRangeService.startDate = startDate;
        }
        this.slideIndex = this.swiperGraphs.swiperRef.realIndex as 0 | 1 | 2;
        this.refreshData();
        this.changeDet.detectChanges();
        return;
      }

      const newPreviousDates = {
        start: this.dateRangeService.getPrevDateRange()[0],
        end: this.dateRangeService.getPrevDateRange()[1],
      };

      if (this.slideIndex === 0) {
        this.slide2Dates = newPreviousDates;
      } else if (this.slideIndex === 1) {
        this.slide0Dates = newPreviousDates;
      } else if (this.slideIndex === 2) {
        this.slide1Dates = newPreviousDates;
      }
    } else if (transitionedTo == 'Right') {
      let startDate = this.dateRangeService.getNextDateRange()[0];
      let endDate = this.dateRangeService.getNextDateRange()[1];

      this.dateRangeService.endDate = endDate;
      this.dateRangeService.startDate = startDate;

      if (this.slideIndex === 2) this.slideIndex = 0;
      else if (this.slideIndex === 1) this.slideIndex = 2;
      else if (this.slideIndex === 0) this.slideIndex = 1;
      else console.warn('Slide index out of bounds');

      if (this.slideIndex != this.swiperGraphs.swiperRef.realIndex) {
        for (
          let i = 0;
          i < Math.abs(this.slideIndex - this.swiperGraphs.swiperRef.realIndex);
          i++
        ) {
          startDate = this.dateRangeService.getNextDateRange()[0];
          endDate = this.dateRangeService.getNextDateRange()[1];

          this.dateRangeService.endDate = endDate;
          this.dateRangeService.startDate = startDate;
        }
        this.slideIndex = this.swiperGraphs.swiperRef.realIndex as 0 | 1 | 2;
        this.refreshData();
        this.changeDet.detectChanges();
        return;
      }

      const newNextDates = {
        start: this.dateRangeService.getNextDateRange()[0],
        end: this.dateRangeService.getNextDateRange()[1],
      };

      if (this.slideIndex === 0) {
        this.slide1Dates = newNextDates;
      } else if (this.slideIndex === 1) {
        this.slide2Dates = newNextDates;
      } else if (this.slideIndex === 2) {
        this.slide0Dates = newNextDates;
      }
    }

    // Functionality
    //this.sortTransactionArray();
    this.changeDet.detectChanges();
  }

  getDateSliderText() {
    return this.dateRangeService.getDateRangeText(
      this.dateRangeService.startDate,
      this.dateRangeService.endDate
    );
  }

  async openFilterModal() {
    const filterModal = await this.modalService.openTransactionFiltersModal();

    filterModal.onDidDismiss().then((hasChanged) => {
      if (hasChanged.data) {
        this.refreshData();
        this.isFilterActive = this.filterService.isFilterActive();
      }
    });

    return filterModal.present();
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

        this.refreshData();
      } else {
        const customDateModal =
          await this.modalService.openCustomDateRangeModal();

        customDateModal
          .onDidDismiss()
          .then((hasSubmitted: OverlayEventDetail<boolean>) => {
            if (hasSubmitted.data) this.refreshData();
          });

        return customDateModal.present();
      }
    }
  }

  /** Reset the data to fix to the current date range selected. Called when the user enter in this page or when some filter is applied */
  async refreshData() {
    const prevDates = {
      start: this.dateRangeService.getPrevDateRange()[0],
      end: this.dateRangeService.getPrevDateRange()[1],
    };

    const currentDates = {
      start: new Date(
        this.dateRangeService.startDate?.valueOf() ??
          (
            await this.transactionService.getTransactions({
              accountIds:
                this.filterService.selectedAccounts == 'all'
                  ? 'all'
                  : this.filterService.selectedAccounts.map((x) => x.id),
              categoriesIds:
                this.filterService.selectedCategories == 'all'
                  ? 'all'
                  : this.filterService.selectedCategories.map((x) => x.id),
            })
          )
            .sort((x, y) => x.date.getTime() - y.date.getTime())[0]
            .date.valueOf()
      ),
      end: new Date(
        this.dateRangeService.endDate?.valueOf() ??
          (
            await this.transactionService.getTransactions({
              accountIds:
                this.filterService.selectedAccounts == 'all'
                  ? 'all'
                  : this.filterService.selectedAccounts.map((x) => x.id),
              categoriesIds:
                this.filterService.selectedAccounts == 'all'
                  ? 'all'
                  : this.filterService.selectedAccounts.map((x) => x.id),
            })
          )
            .sort((x, y) => y.date.getTime() - x.date.getTime())[0]
            .date.valueOf()
      ),
    };

    const nextDates = {
      start: this.dateRangeService.getNextDateRange()[0],
      end: this.dateRangeService.getNextDateRange()[1],
    };

    if (this.slideIndex === 0) {
      this.slide0Dates = currentDates;
      this.slide2Dates = prevDates;
      this.slide1Dates = nextDates;
    } else if (this.slideIndex === 1) {
      this.slide1Dates = currentDates;
      this.slide0Dates = prevDates;
      this.slide2Dates = nextDates;
    } else if (this.slideIndex === 2) {
      this.slide2Dates = currentDates;
      this.slide1Dates = prevDates;
      this.slide0Dates = nextDates;
    } else {
      console.warn('Undefined index in the swiper component');
    }

    setTimeout(() => {
      // TODO: Investigate more about this.
      // According to https://stackoverflow.com/a/68609360/15417506, all update methods of swiper should be called with a settimeout function. If we remove the timeout, the update method here has no effect here
      this.swiperGraphs.swiperRef.updateAutoHeight();
    }, 0);

    //this.sortTransactionArray();
  }

  previousScroll = 0;
  toggleFab(event: any) {
    if (event.detail.scrollTop > this.previousScroll) {
      document
        .getElementById('add-transaction-mobile-fab')
        .classList.add('hide');
    } else if (event.detail.scrollTop < this.previousScroll) {
      document
        .getElementById('add-transaction-mobile-fab')
        .classList.remove('hide');
    }
    this.previousScroll = event.detail.scrollTop;
  }
}
