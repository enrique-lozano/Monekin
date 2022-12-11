import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { RecurringTransactionListPage } from './recurring-transaction-list.page';

const routes: Routes = [
  {
    path: '',
    component: RecurringTransactionListPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class RecurringTransactionListPageRoutingModule {}
