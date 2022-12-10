import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { AccountDetailsPage } from './account-details.page';

const routes: Routes = [
  {
    path: ':id',
    component: AccountDetailsPage,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AccountDetailsPageRoutingModule {}
