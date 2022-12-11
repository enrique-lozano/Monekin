import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { CategoryFormPage } from './category-form.page';

const routes: Routes = [
  {
    path: '',
    component: CategoryFormPage,
  },
  {
    path: ':id',
    component: CategoryFormPage,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class CategoryFormPageRoutingModule {}
