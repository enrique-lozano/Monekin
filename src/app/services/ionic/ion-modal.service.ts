import { Injectable } from '@angular/core';
import { ModalController } from '@ionic/angular';
import {
  enterAnimation,
  leaveAnimation,
} from 'src/app/animations/centered-small-modal';
import { AccountSelectorComponent } from 'src/app/components/dialogs/account-selector/account-selector.component';
import { CategoryStatsComponent } from 'src/app/components/dialogs/category-stats/category-stats.component';
import { CurrencySelectorComponent } from 'src/app/components/dialogs/currency-selector/currency-selector.page';
import { DatePickerComponent } from 'src/app/components/dialogs/date-picker/date-picker.component';
import { CustomDateRangeComponent } from 'src/app/components/dialogs/date-range-selector/custom-date-range/custom-date-range.component';
import {
  DateRange,
  DateRangeSelectorComponent,
} from 'src/app/components/dialogs/date-range-selector/date-range-selector.component';
import { IconSelectorComponent } from 'src/app/components/dialogs/icon-selector/icon-selector.component';
import { TransactionFilterComponent } from 'src/app/components/dialogs/transaction-filter/transaction-filter.component';
import { TransactionOrderSelectorComponent } from 'src/app/components/dialogs/transaction-order-selector/transaction-order-selector.component';
import { TransactionListOrder } from 'src/app/constants/transaction-list-order';
import { UserProfileEditionComponent } from 'src/app/pages/settings/user-profile-edition/user-profile-edition.component';
import { Currency } from '../currency/currency.model';
import { Account } from '../db/account/account.model';
import { Category } from '../db/category/category.model';
import { Transaction } from '../db/transaction/transaction.model';

@Injectable({
  providedIn: 'root',
})
export class IonModalService {
  constructor(private modalCtrl: ModalController) {}

  async openDateRangeModal() {
    const result = await this.modalCtrl.create({
      component: DateRangeSelectorComponent,
      cssClass: '',
      enterAnimation,
      leaveAnimation,
    });

    result.present();

    return result.onDidDismiss<DateRange>();
  }

  /** The modal return true in the onClose statement if the user select the dates and press 'OK' */
  async openCustomDateRangeModal() {
    const result = await this.modalCtrl.create({
      component: CustomDateRangeComponent,
      cssClass: '',
      enterAnimation,
      leaveAnimation,
    });

    return result;
  }

  async openDatePickerModal(initDate: Date) {
    const result = await this.modalCtrl.create({
      component: DatePickerComponent,
      cssClass: '',
      enterAnimation,
      leaveAnimation,
      componentProps: {
        iniValue: initDate,
      },
    });

    return result;
  }

  async openIconSelectorModal(
    popoverTitle: string,
    selectedIcon: string,
    canSelectColor: boolean,
    color: string,
    background: string,
    showInput: boolean = false,
    inputValue?: string
  ) {
    const result = await this.modalCtrl.create({
      component: IconSelectorComponent,
      cssClass: '',
      enterAnimation,
      leaveAnimation,
      componentProps: {
        popoverTitle,
        selectedIcon,
        canSelectColor,
        color,
        background,
        showInput,
        inputValue,
      },
    });

    result.present();

    return result.onDidDismiss<{
      icon: string;
      color: string;
      inputValue: string;
    }>();
  }

  /*   async openRecurrentModal(
    repetition: 'no' | 'week' | 'month' | 'year',
    dateStart: Date,
    dateEnd: Date
  ) {
    const result = await this.modalCtrl.create({
      component: RecurrentSelectorComponent,
      breakpoints: [0, 1],
      initialBreakpoint: 1,
      componentProps: {
        repetition,
        dateStart,
        dateEnd,
      },
    });

    result.present();

    return result.onDidDismiss<{
      repetition: 'no' | RecurrentOption;
      dateStart: Date;
      dateEnd: Date;
    }>();
  }

  async openCurrencyExchangeSelector(
    valueInSource: number,
    exchangeRate: number,
    valueInDestiny: number
  ) {
    const result = await this.modalCtrl.create({
      component: CurrencyExchangeSelectorComponent,
      breakpoints: [0, 1],
      initialBreakpoint: 1,
      componentProps: {
        valueInSource,
        exchangeRate,
        valueInDestiny,
      },
    });

    result.present();

    return result.onDidDismiss<number>();
  }
 */
  async openAccountSelectorModal(
    selectedAccounts: 'all' | Account[],
    allowMultiSelection: boolean,
    filterSavingAccounts: boolean = false
  ) {
    const result = await this.modalCtrl.create({
      component: AccountSelectorComponent,
      breakpoints: [0, 1],
      initialBreakpoint: 1,
      componentProps: {
        selectedAccounts,
        allowMultiSelection,
        filterSavingAccounts,
      },
    });

    result.present();

    return result.onDidDismiss<Account[] | 'all'>();
  }

  /** The modal return true in the onClose statement if the user press the "accept" bottom */
  async openTransactionFiltersModal() {
    const result = await this.modalCtrl.create({
      component: TransactionFilterComponent,
      breakpoints: [0, 0.5, 1],
      initialBreakpoint: 1,
      componentProps: {},
    });

    return result;
  }
  /* 
  async openCategorySelectorModal(
    mode: 'modal-with-subcats' | 'modal-without-subcats' | 'multiselection',
    selectedCategories?: 'all' | Category[]
  ) {
    const modal = await this.modalCtrl.create({
      component: CategoriesListPage,
      cssClass: 'full-height',
      breakpoints: [0, 0.5, 1],
      initialBreakpoint: 1,
      componentProps: {
        mode,
        selectedCategories,
      },
    });

    await modal.present();

    return modal.onDidDismiss<Category[] | 'all'>();
  }
 */
  async openCategoryStatsModal(item: {
    category: Category;
    transactions: Transaction[];
    value: number;
  }) {
    const result = await this.modalCtrl.create({
      component: CategoryStatsComponent,
      breakpoints: [0, 0.5, 1],
      initialBreakpoint: 1,
      componentProps: {
        item,
      },
    });

    return result;
  }

  /** Returns the selected subcategory, or the parent category if the user prefers not to select any subcategory. Will return undefined if the modal is dismissed */
  /*   async openSubcategorySelectorModal(category: Category) {
    const result = await this.modalCtrl.create({
      component: SubcategorySelectorComponent,
      breakpoints: [0, 1],
      initialBreakpoint: 1,
      componentProps: {
        category,
      },
    });

    result.present();

    return result.onDidDismiss<Category>();
  } */

  async openCurrencySelectorModal() {
    const result = await this.modalCtrl.create({
      component: CurrencySelectorComponent,
      cssClass: 'full-height',
      breakpoints: [0, 0.5, 1],
      initialBreakpoint: 1,
    });

    result.present();

    return result.onDidDismiss<Currency>();
  }

  async openTransactionOrderSelector(order: TransactionListOrder) {
    const result = await this.modalCtrl.create({
      component: TransactionOrderSelectorComponent,
      breakpoints: [0, 1],
      initialBreakpoint: 1,
      componentProps: {
        order,
      },
    });

    result.present();

    return result.onDidDismiss<TransactionListOrder>();
  }

  async openUserProfileEdition() {
    const result = await this.modalCtrl.create({
      component: UserProfileEditionComponent,
      breakpoints: [0, 1],
      initialBreakpoint: 1,
    });

    result.present();

    return result.onDidDismiss<void>();
  }

  /** Function used to solve an ionic issue that fails on calculate the ion-content height, setting it equal to the height of the modal. At the moment, its use is valid for modals with a specific height, with an ion-header and an ion-content */
  recalculateContentHeight() {
    const modal = document.querySelector(
      'ion-modal app-categories-list.ion-page'
    );
    const contentInModal = document.querySelector(
      'ion-modal app-categories-list.ion-page ion-content'
    ) as HTMLElement;

    if (!modal || !contentInModal) return;

    const headerInModal = document.querySelector(
      'ion-modal app-categories-list.ion-page ion-header'
    ) as HTMLElement;

    const headerHeight = headerInModal?.clientHeight ?? 0;

    const footerInModal = document.querySelector(
      'ion-modal app-categories-list.ion-page ion-footer'
    ) as HTMLElement;

    const footerHeight = footerInModal?.clientHeight ?? 0;

    contentInModal.style.height =
      modal.clientHeight - headerHeight - footerHeight + 'px';
  }
}
