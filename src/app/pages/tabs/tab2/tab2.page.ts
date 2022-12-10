import { animate, style, transition, trigger } from '@angular/animations';
import { Component, ViewChild } from '@angular/core';
import { IonInfiniteScroll, IonInput } from '@ionic/angular';
import {
  TransactionListOrder,
  TransactionListOrderKey,
} from 'src/app/constants/transaction-list-order';
import { Transaction } from 'src/app/services/db/transaction/transaction.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { DateRangeService } from 'src/app/services/filters/date-range/date-range.service';
import { FilterService } from 'src/app/services/filters/filter.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { StatusBarService } from 'src/app/services/ionic/status-bar.service';

@Component({
  selector: 'app-tab2',
  templateUrl: 'tab2.page.html',
  styleUrls: ['tab2.page.scss'],
  animations: [
    trigger('inOut', [
      transition('void => *', [
        style({ opacity: 0 }), // initial styles
        animate(
          '0.4s',
          style({ opacity: 1 }) // final style after the transition has finished
        ),
      ]),

      transition('* => void', [
        style({ opacity: 1 }), // initial styles
        animate(
          '0.1s',
          style({ opacity: 0 }) // final style after the transition has finished
        ),
      ]),
    ]),
  ],
})
export class Tab2Page {
  order: TransactionListOrder = {
    dir: 'asc',
    orderBy: TransactionListOrderKey.date,
  };

  searchValue = '';

  allTransactions: Transaction[];

  @ViewChild('searcher') searcher: IonInput;
  searchHasFocus = false;

  isFilterActive = false;

  // Infinite scroll variables
  readonly initialItemsPerLoad = 20;
  itemsPerLoad = this.initialItemsPerLoad;
  itemsToDisplay = this.initialItemsPerLoad;
  lastLoadTime: number;
  @ViewChild('infiniteScroll') infiniteScroll: IonInfiniteScroll;

  constructor(
    public dateRangeService: DateRangeService,
    public filterService: FilterService,
    private transactionService: TransactionService,
    private modalService: IonModalService,
    private statusBar: StatusBarService
  ) {}

  ionViewWillEnter() {
    this.statusBar.setPrimaryStatusBar();
    this.isFilterActive = this.filterService.isFilterActive();
    document.getElementsByTagName('ion-fab')[0].classList.remove('hide');
  }

  async ionViewDidEnter() {
    await this.refreshData();
  }

  ionViewDidLeave() {
    this.allTransactions = undefined;
    this.resetInfiniteScroll();
  }

  activateSearch() {
    this.searchHasFocus = true;
    document.getElementsByTagName('ion-fab')[0].classList.add('hide');

    this.searcher.setFocus().then(() => {});
  }

  onSearchLossFocus() {
    this.searchHasFocus = false;
    document.getElementsByTagName('ion-fab')[0].classList.remove('hide');
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

  async openOrderTransactionsModal() {
    const modalResult = await this.modalService.openTransactionOrderSelector(
      this.order
    );

    if (modalResult.data) {
      this.order = modalResult.data;
      this.sortTransactionArray();
    }
  }

  protected resetInfiniteScroll() {
    this.infiniteScroll.disabled = false;
    this.itemsToDisplay = this.initialItemsPerLoad;
    this.itemsPerLoad = this.initialItemsPerLoad;
  }

  loadData(event) {
    const animationTotalTime = this.itemsPerLoad * 100; // In ms
    const timeWithoutLoading = performance.now() - this.lastLoadTime; // In ms

    setTimeout(
      () => {
        this.itemsToDisplay = this.itemsToDisplay + this.itemsPerLoad;

        if (this.itemsPerLoad === this.initialItemsPerLoad)
          this.itemsPerLoad = Math.floor(this.itemsPerLoad * 1.5);

        this.lastLoadTime = performance.now();

        event.target.complete();

        // App logic to determine if all data is loaded and disable the infinite scroll
        if (this.itemsToDisplay >= this.allTransactions.length) {
          event.target.disabled = true;
          return;
        }
      },
      timeWithoutLoading > animationTotalTime
        ? 600
        : animationTotalTime - timeWithoutLoading + 600
    );
  }

  showRangeVariation() {
    return (
      this.dateRangeService.startDate &&
      this.dateRangeService.endDate &&
      this.filterService.selectedCategories == 'all' &&
      !this.searchValue?.trim()
    );
  }

  /** Reset the data to fix to the current date range selected. Called when the user enter in this page or when some filter is applied */
  async refreshData() {
    this.lastLoadTime = performance.now();

    this.allTransactions = undefined;
    await new Promise((r) => setTimeout(r, 500));

    this.allTransactions = await this.transactionService.getTransactions({
      accountIds:
        this.filterService.selectedAccounts == 'all'
          ? 'all'
          : this.filterService.selectedAccounts.map((x) => x.id),
      categoriesIds:
        this.filterService.selectedCategories == 'all'
          ? 'all'
          : this.filterService.selectedCategories.map((x) => x.id),
      typeOfTransaction: 'all',
      queryText: this.searchValue,
    });

    this.sortTransactionArray();

    //this.changeDet.detectChanges();
  }

  sortTransactionArray() {
    if (this.order.dir == 'asc') {
      if (this.order.orderBy == 'Date') {
        this.allTransactions.sort((a, b) => (a.date < b.date ? 1 : -1));
      } else if (this.order.orderBy == 'Quantity') {
        this.allTransactions.sort((a, b) => (a.value > b.value ? 1 : -1));
      } else if (this.order.orderBy == 'Category') {
        this.allTransactions.sort((a, b) =>
          (a.category?.parentCategory?.name ?? a.category?.name) >
          (b.category?.parentCategory?.name ?? b.category?.name)
            ? 1
            : -1
        );
      }
    } else if (this.order.dir == 'desc') {
      if (this.order.orderBy == 'Date') {
        this.allTransactions.sort((a, b) => (a.date > b.date ? 1 : -1));
      } else if (this.order.orderBy == 'Quantity') {
        this.allTransactions.sort((a, b) => (a.value < b.value ? 1 : -1));
      } else if (this.order.orderBy == 'Category') {
        this.allTransactions.sort((a, b) =>
          (a.category?.parentCategory?.name ?? a.category?.name) <
          (b.category?.parentCategory?.name ?? b.category?.name)
            ? 1
            : -1
        );
      }
    }
  }

  previousScroll = 0;
  toggleFab(event: any) {
    if (event.detail.scrollTop > this.previousScroll) {
      document.getElementsByTagName('ion-fab')[0].classList.add('hide');
    } else if (event.detail.scrollTop < this.previousScroll) {
      document.getElementsByTagName('ion-fab')[0].classList.remove('hide');
    }
    this.previousScroll = event.detail.scrollTop;
  }
}
