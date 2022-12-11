import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { TransactionFormPage } from './transaction-form.page';

const routes: Routes = [
  {
    path: '',
    component: TransactionFormPage,
  },
  {
    path: ':id',
    component: TransactionFormPage,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class TransactionFormPageRoutingModule {}
