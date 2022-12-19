import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { LayoutPage } from './layout.page';

const routes: Routes = [
  {
    path: '',
    component: LayoutPage,
    children: [
      {
        path: '',
        redirectTo: '/tabs/tab1',
        pathMatch: 'full',
      },
      {
        path: 'tabs',
        redirectTo: '/tabs/tab1',
        pathMatch: 'full',
      },
      {
        path: 'tabs/tab1',
        loadChildren: () =>
          import('./../tabs/tab1/tab1.module').then((m) => m.Tab1PageModule),
      },
      {
        path: 'tabs/tab2',
        loadChildren: () =>
          import('./../tabs/tab2/tab2.module').then((m) => m.Tab2PageModule),
      },
      {
        path: 'tabs/tab3',
        loadChildren: () =>
          import('./../tabs/tab3/tab3.module').then((m) => m.Tab3PageModule),
      },
      {
        path: 'transaction-form',
        loadChildren: () =>
          import(
            './../transactions/transaction-form/transaction-form.module'
          ).then((m) => m.TransactionFormPageModule),
      },
      {
        path: 'transaction-details',
        loadChildren: () =>
          import(
            './../transactions/transaction-details/transaction-details.module'
          ).then((m) => m.TransactionDetailsPageModule),
      },
      {
        path: 'recurring-transaction-list',
        loadChildren: () =>
          import(
            './../transactions/recurring-transaction-list/recurring-transaction-list.module'
          ).then((m) => m.RecurringTransactionListPageModule),
      },
      {
        path: 'accounts/list',
        loadChildren: () =>
          import('./../accounts/all-accounts/all-accounts.module').then(
            (m) => m.AllAccountsPageModule
          ),
      },
      {
        path: 'account-details',
        loadChildren: () =>
          import('./../accounts/account-details/account-details.module').then(
            (m) => m.AccountDetailsPageModule
          ),
      },
      {
        path: 'account-form',
        loadChildren: () =>
          import('./../accounts/account-form/account-form.module').then(
            (m) => m.AccountFormPageModule
          ),
      },
      {
        path: 'finance-health',
        loadChildren: () =>
          import('./../finance-health/finance-health.module').then(
            (m) => m.FinanceHealthPageModule
          ),
      },
      {
        path: 'budgets',
        loadChildren: () =>
          import('./../budgets/budgets.module').then(
            (m) => m.BudgetsPageModule
          ),
      },
      {
        path: 'categories-list',
        loadChildren: () =>
          import('./../categories/categories-list/categories-list.module').then(
            (m) => m.CategoriesListPageModule
          ),
      },
      {
        path: 'category-form',
        loadChildren: () =>
          import('./../categories/category-form/category-form.module').then(
            (m) => m.CategoryFormPageModule
          ),
      },
      {
        path: 'currency-converter',
        loadChildren: () =>
          import('./../currency-converter/currency-converter.module').then(
            (m) => m.CurrencyConverterPageModule
          ),
      },
      {
        path: 'settings',
        loadChildren: () =>
          import('./../settings/settings.module').then(
            (m) => m.SettingsPageModule
          ),
      },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class LayoutPageRoutingModule {}
