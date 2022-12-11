import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
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
      import('./pages/tabs/tab1/tab1.module').then((m) => m.Tab1PageModule),
  },
  {
    path: 'tabs/tab2',
    loadChildren: () =>
      import('./pages/tabs/tab2/tab2.module').then((m) => m.Tab2PageModule),
  },
  {
    path: 'tabs/tab3',
    loadChildren: () =>
      import('./pages/tabs/tab3/tab3.module').then((m) => m.Tab3PageModule),
  },
  {
    path: 'transaction-form',
    loadChildren: () =>
      import(
        './pages/transactions/transaction-form/transaction-form.module'
      ).then((m) => m.TransactionFormPageModule),
  },
  {
    path: 'transaction-details',
    loadChildren: () =>
      import(
        './pages/transactions/transaction-details/transaction-details.module'
      ).then((m) => m.TransactionDetailsPageModule),
  },
  {
    path: 'recurring-transaction-list',
    loadChildren: () =>
      import(
        './pages/transactions/recurring-transaction-list/recurring-transaction-list.module'
      ).then((m) => m.RecurringTransactionListPageModule),
  },
  {
    path: 'accounts/list',
    loadChildren: () =>
      import('./pages/accounts/all-accounts/all-accounts.module').then(
        (m) => m.AllAccountsPageModule
      ),
  },
  {
    path: 'account-details',
    loadChildren: () =>
      import('./pages/accounts/account-details/account-details.module').then(
        (m) => m.AccountDetailsPageModule
      ),
  },
  {
    path: 'account-form',
    loadChildren: () =>
      import('./pages/accounts/account-form/account-form.module').then(
        (m) => m.AccountFormPageModule
      ),
  },
  {
    path: 'finance-health',
    loadChildren: () =>
      import('./pages/finance-health/finance-health.module').then(
        (m) => m.FinanceHealthPageModule
      ),
  },
  {
    path: 'budgets',
    loadChildren: () =>
      import('./pages/budgets/budgets.module').then((m) => m.BudgetsPageModule),
  },
  {
    path: 'categories-list',
    loadChildren: () =>
      import('./pages/categories/categories-list/categories-list.module').then(
        (m) => m.CategoriesListPageModule
      ),
  },
  {
    path: 'category-form',
    loadChildren: () =>
      import('./pages/categories/category-form/category-form.module').then(
        (m) => m.CategoryFormPageModule
      ),
  },
  {
    path: 'currency-converter',
    loadChildren: () =>
      import('./pages/currency-converter/currency-converter.module').then(
        (m) => m.CurrencyConverterPageModule
      ),
  },
  {
    path: 'settings',
    loadChildren: () =>
      import('./pages/settings/settings.module').then(
        (m) => m.SettingsPageModule
      ),
  },
];
@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules }),
  ],
  exports: [RouterModule],
})
export class AppRoutingModule {}
