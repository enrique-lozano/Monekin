import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { BudgetFormPage } from './budget-form.page';

const routes: Routes = [
  {
    path: '',
    component: BudgetFormPage,
  },
  {
    path: ':id',
    component: BudgetFormPage,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class BudgetFormPageRoutingModule {}
