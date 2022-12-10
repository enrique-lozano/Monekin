import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Account } from 'src/app/services/db/account/account.model';
import { MainCategory } from 'src/app/services/db/category/category.model';
import { FilterService } from 'src/app/services/filters/filter.service';

@Component({
  selector: 'app-tab-filters',
  templateUrl: './tab-filters.component.html',
  styleUrls: ['./tab-filters.component.scss'],
})
export class TabFiltersComponent implements OnInit {
  @Input() componentVisible = true;

  @Output() filtersChanged = new EventEmitter<void>();

  constructor(public filterService: FilterService) {}

  ngOnInit() {}

  removeAccount(account: Account) {
    if (this.filterService.selectedAccounts != 'all') {
      this.filterService.selectedAccounts =
        this.filterService.selectedAccounts.filter((x) => x.id != account.id);

      if (this.filterService.selectedAccounts.length === 0) {
        this.filterService.selectedAccounts = 'all';
        this.componentVisible = this.filterService.isFilterActive();
      }

      this.filtersChanged.emit();
    }
  }

  removeCategory(category: MainCategory) {
    if (this.filterService.selectedCategories != 'all') {
      this.filterService.selectedCategories =
        this.filterService.selectedCategories.filter(
          (x) => x.id != category.id
        );

      if (this.filterService.selectedCategories.length === 0) {
        this.filterService.selectedCategories = 'all';
        this.componentVisible = this.filterService.isFilterActive();
      }

      this.filtersChanged.emit();
    }
  }
}
