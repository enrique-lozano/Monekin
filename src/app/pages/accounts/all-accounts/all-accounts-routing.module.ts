import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { AllAccountsPage } from './all-accounts.page';

const routes: Routes = [
  {
    path: '',
    component: AllAccountsPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AllAccountsPageRoutingModule {}
