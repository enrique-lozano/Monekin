import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { AccountFormPage } from './account-form.page';

const routes: Routes = [
  {
    path: '',
    component: AccountFormPage,
  },
  {
    path: ':id',
    component: AccountFormPage,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AccountFormPageRoutingModule {}
