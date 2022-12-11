import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { BudgetDetailsPage } from './budget-details.page';

const routes: Routes = [
  {
    path: '',
    component: BudgetDetailsPage,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class BudgetDetailsPageRoutingModule {}
