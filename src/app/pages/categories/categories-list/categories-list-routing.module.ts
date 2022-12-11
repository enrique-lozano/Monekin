import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { CategoriesListPage } from './categories-list.page';

const routes: Routes = [
  {
    path: '',
    component: CategoriesListPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class CategoriesListPageRoutingModule {}
