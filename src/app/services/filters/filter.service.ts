import { Injectable } from '@angular/core';
import { MainCategory } from 'src/app/services/db/category/category.model';
import { Account } from '../db/account/account.model';

@Injectable({
  providedIn: 'root',
})
export class FilterService {
  selectedAccounts: 'all' | Account[] = 'all';
  selectedCategories: 'all' | MainCategory[] = 'all';

  constructor() {}

  isFilterActive() {
    return this.selectedAccounts != 'all' || this.selectedCategories != 'all';
  }
}
