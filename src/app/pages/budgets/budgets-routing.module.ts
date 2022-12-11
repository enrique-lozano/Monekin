import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { BudgetsPage } from './budgets.page';

const routes: Routes = [
  {
    path: '',
    component: BudgetsPage,
  },
  {
    path: 'budget-form',
    loadChildren: () =>
      import('./budget-form/budget-form.module').then(
        (m) => m.BudgetFormPageModule
      ),
  },
  {
    path: 'budget-detail/:id',
    loadChildren: () =>
      import('./budget-details/budget-details.module').then(
        (m) => m.BudgetDetailsPageModule
      ),
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class BudgetsPageRoutingModule {}
