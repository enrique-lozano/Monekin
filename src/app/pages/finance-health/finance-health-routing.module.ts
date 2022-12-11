import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { FinanceHealthPage } from './finance-health.page';

const routes: Routes = [
  {
    path: '',
    component: FinanceHealthPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class FinanceHealthPageRoutingModule {}
