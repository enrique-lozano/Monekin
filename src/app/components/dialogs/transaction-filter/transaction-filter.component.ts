import { Component, OnInit } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { Account } from 'src/app/services/db/account/account.model';
import { MainCategory } from 'src/app/services/db/category/category.model';
import { FilterService } from 'src/app/services/filters/filter.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';

@Component({
  selector: 'app-transaction-filter',
  templateUrl: './transaction-filter.component.html',
  styleUrls: ['./transaction-filter.component.scss'],
})
export class TransactionFilterComponent implements OnInit {
  /** Accounts to display. At the init all the accounts of the user will be selected (initialization in tab1).
   *
   * @see "services/filters/filter.service" */
  selectedAccounts: 'all' | Account[];

  /** Categories to display. At the init all the categories of the user will be selected (initialization in the filter service).
   *
   * @see "services/filters/filter.service" */
  selectedCategories: 'all' | MainCategory[];

  constructor(
    private modalService: IonModalService,
    private filterService: FilterService,
    private modalCtrl: ModalController
  ) {}

  ngOnInit() {
    this.selectedAccounts = this.filterService.selectedAccounts;
    this.selectedCategories = this.filterService.selectedCategories;
  }

  async selectAccounts() {
    const modalResult = await this.modalService.openAccountSelectorModal(
      this.selectedAccounts,
      true
    );

    if (modalResult.data) this.selectedAccounts = modalResult.data;
  }

  async selectCategories() {
    /*     const modalRes = await this.modalService.openCategorySelectorModal(
      'multiselection',
      this.selectedCategories
    );

    if (modalRes.data) {
      this.selectedCategories = modalRes.data as MainCategory[];
    } */
  }

  dismiss() {
    this.modalCtrl.dismiss(false);
  }

  submit() {
    this.filterService.selectedAccounts = this.selectedAccounts;
    this.filterService.selectedCategories = this.selectedCategories;

    this.modalCtrl.dismiss(true);
  }
}
