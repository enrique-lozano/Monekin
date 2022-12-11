import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { TransactionDetailsPage } from './transaction-details.page';

const routes: Routes = [
  {
    path: ':id',
    component: TransactionDetailsPage,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class TransactionDetailsPageRoutingModule {}
