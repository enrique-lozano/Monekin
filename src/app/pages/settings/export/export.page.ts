import { Component, OnInit } from '@angular/core';
import { BackupService } from 'src/app/services/backup/backup.service';
import { Account } from 'src/app/services/db/account/account.model';
import { MainCategory } from 'src/app/services/db/category/category.model';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';

@Component({
  selector: 'app-export',
  templateUrl: './export.page.html',
  styleUrls: ['./export.page.scss'],
})
export class ExportPage implements OnInit {
  selectedAccounts: 'all' | Account[] = 'all';

  readonly exportOptions = [
    {
      id: 1,
      title: 'BACKUP.EXPORT.all',
      descr: 'BACKUP.EXPORT.all.descr',
      img: 'assets/icons/backup/json.svg',
      selected: true,
    },
    {
      id: 2,
      title: 'BACKUP.EXPORT.transactions',
      descr: 'BACKUP.EXPORT.transactions.descr',
      img: 'assets/icons/backup/table_file.svg',
      selected: false,
    },
  ];

  exportFormats: ('csv' | 'json' | 'xlsx')[] = ['json'];
  selectedExportFormat: 'csv' | 'json' | 'xlsx' = 'json';

  selectedCategories: 'all' | MainCategory[] = 'all';

  constructor(
    private modalService: IonModalService,
    private backupService: BackupService,
    private transactionService: TransactionService
  ) {}

  ngOnInit() {}

  clickExportOption(exportOptionID: number) {
    this.exportOptions.forEach((option) => {
      option.selected = false;
    });

    this.exportOptions.find((x) => x.id == exportOptionID).selected = true;

    if (exportOptionID === 1) {
      this.exportFormats = ['json'];
      this.selectedExportFormat = 'json';
    } else if (exportOptionID === 2) {
      this.exportFormats = ['csv', 'xlsx'];
      this.selectedExportFormat = 'csv';
    }
  }

  async selectAccounts() {
    const modalResult = await this.modalService.openAccountSelectorModal(
      this.selectedAccounts,
      true
    );

    if (modalResult.data) this.selectedAccounts = modalResult.data;
  }

  async selectCategories() {
    const modalRes = await this.modalService.openCategorySelectorModal(
      'multiselection',
      this.selectedCategories
    );

    if (modalRes.data) {
      this.selectedCategories = modalRes.data as MainCategory[];
    }
  }

  async export() {
    if (this.selectedExportFormat == 'json') {
      await this.backupService.exportData();
    } else {
      const transactions = await this.transactionService.getTransactions({
        accountIds:
          this.selectedAccounts == 'all'
            ? undefined
            : this.selectedAccounts.map((x) => x.id),
        categoriesIds:
          this.selectedCategories == 'all'
            ? undefined
            : this.selectedCategories.map((x) => x.id),
      });

      await this.backupService.exportSpreadsheet(
        transactions,
        this.selectedExportFormat
      );
    }
  }
}
