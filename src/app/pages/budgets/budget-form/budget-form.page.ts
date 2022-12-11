import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Account } from 'src/app/services/db/account/account.model';
import { AccountService } from 'src/app/services/db/account/account.service';
import { Budget } from 'src/app/services/db/budget/budget.model';
import { BudgetService } from 'src/app/services/db/budget/budget.service';
import { MainCategory } from 'src/app/services/db/category/category.model';
import { CategoryService } from 'src/app/services/db/category/category.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { UtilsService } from 'src/app/services/utils/utils.service';

@Component({
  selector: 'app-budget-form',
  templateUrl: './budget-form.page.html',
  styleUrls: ['./budget-form.page.scss'],
})
export class BudgetFormPage implements OnInit {
  repeat: 'week' | 'month' | 'year' | 'no' = 'month';
  dateStart: Date; // Only in case repeat is "no"
  dateEnd: Date; // Only in case repeat is "no"

  /** Selected user accounts */ accounts: Account[] | 'all' = 'all';
  /** Selected user categories names */ categories: MainCategory[] | 'all' =
    'all';

  /** Only defined if we are on edit mode */ budgetToEdit: Budget;

  form: FormGroup<{
    name: FormControl<string>;
    balance: FormControl<number>;
  }>;

  constructor(
    public lang: LangService,
    private accountService: AccountService,
    private categoryService: CategoryService,
    private budgetService: BudgetService,
    private router: Router,
    private utils: UtilsService,
    private activeRoute: ActivatedRoute,
    private modalService: IonModalService
  ) {
    this.form = new FormGroup({
      name: new FormControl('', [Validators.required]),
      balance: new FormControl(undefined, [
        Validators.max(100000000),
        Validators.min(1),
        Validators.required,
      ]),
    });
  }

  async ngOnInit() {
    this.budgetToEdit = undefined;

    if (this.activeRoute.snapshot.paramMap.get('id')) {
      this.budgetToEdit = (await this.budgetService.getBudgets()).find(
        (x) => x.name == this.activeRoute.snapshot.paramMap.get('id')
      );

      if (!this.budgetToEdit) return;

      if (Array.isArray(this.budgetToEdit.accounts)) {
        this.accounts = [];
        for (const acc of this.budgetToEdit.accounts) {
          this.accounts.push(await this.accountService.getAccountByUUID(acc));
        }
      }
      if (Array.isArray(this.budgetToEdit.categories)) {
        this.categories = [];
        for (const cat of this.budgetToEdit.categories) {
          this.categories.push(
            (await this.categoryService.getCategoryByUUID(cat)) as MainCategory
          );
        }
      }

      this.repeat = this.budgetToEdit.repeat;
      this.form.controls.name.setValue(this.budgetToEdit.name);
      this.form.controls.balance.setValue(this.budgetToEdit.limit);

      if (this.budgetToEdit.startDate)
        this.dateStart = this.budgetToEdit.startDate;
      if (this.budgetToEdit.endDate) this.dateEnd = this.budgetToEdit.endDate;
    }
  }

  async selectAccounts() {
    const modalResult = await this.modalService.openAccountSelectorModal(
      this.accounts,
      true
    );

    if (modalResult.data) this.accounts = modalResult.data;
  }

  async selectCategories() {
    const modalRes = await this.modalService.openCategorySelectorModal(
      'multiselection',
      this.categories
    );

    if (modalRes.data) {
      this.categories = modalRes.data as MainCategory[];
    }
  }

  async postBudget() {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    const newBudget: Budget = new Budget({
      accounts: this.accounts == 'all' ? 'all' : this.accounts.map((x) => x.id),
      categories:
        this.categories == 'all' ? 'all' : this.categories.map((x) => x.id),
      limit: this.form.value.balance,
      name: this.form.value.name,
      repeat: this.repeat,
    });

    if (this.repeat == 'no') {
      if (
        !this.dateStart ||
        !this.dateEnd ||
        this.dateEnd.getTime() < this.dateStart.getTime()
      ) {
        // TODO: Show error
        return;
      }
      newBudget.startDate = this.dateStart;
      newBudget.endDate = this.dateEnd;
    }

    if (this.budgetToEdit) {
      this.budgetService.editBudget(newBudget, this.budgetToEdit.name);
    } else {
      this.budgetService.addBudget(newBudget);
    }
    this.router.navigateByUrl('/budgets');
  }

  formatDate(date: Date) {
    if (!date) return '';

    return this.utils.setDateInDOM(date, 'longDate');
  }

  setStartDate(date: Date) {
    this.dateStart = date;
  }

  setEndDate(date: Date) {
    this.dateEnd = date;
  }
}
