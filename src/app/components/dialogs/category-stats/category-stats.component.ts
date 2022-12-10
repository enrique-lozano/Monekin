import { Component, OnInit } from '@angular/core';
import { MainCategory } from 'src/app/services/db/category/category.model';
import { Transaction } from 'src/app/services/db/transaction/transaction.model';
import { DateRangeService } from 'src/app/services/filters/date-range/date-range.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-category-stats',
  templateUrl: './category-stats.component.html',
  styleUrls: ['./category-stats.component.scss'],
})
export class CategoryStatsComponent implements OnInit {
  item: {
    category: MainCategory;
    transactions: Transaction[];
    value: number;
  };

  dataRangeText: string;

  subcategories: {
    name: string;
    icon: string;
    value: number;
  }[] = [];

  constructor(
    public lang: LangService,
    private dateRangeService: DateRangeService
  ) {}

  ngOnInit() {
    if (this.item) {
      this.getSubcategoriesData();

      this.dataRangeText = this.dateRangeService.getDateRangeText(
        this.dateRangeService.startDate,
        this.dateRangeService.endDate
      );
    }
  }

  getSubcategoriesData() {
    this.item.transactions.forEach((transaction) => {
      /** Name that will assume the set of transactions that do not belong to any subcategory */
      const notBelongToAnySubcatName =
        this.lang.getTranslation('TABS.TAB3.without-subcat') +
        transaction.category.name;

      const categoryToEdit = this.subcategories.find(
        (x) =>
          x.name == transaction.category.name ||
          x.name == notBelongToAnySubcatName
      );
      if (categoryToEdit) {
        categoryToEdit.value += Math.abs(transaction.value);
      } else {
        this.subcategories.push({
          name:
            transaction.category.name == this.item.category.name
              ? notBelongToAnySubcatName
              : transaction.category.name,
          value: Math.abs(transaction.value),
          icon: transaction.category.icon,
        });
      }
    });

    this.subcategories.sort((a, b) => b.value - a.value);
  }
}
