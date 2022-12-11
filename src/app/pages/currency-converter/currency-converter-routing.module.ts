import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { CurrencyConverterPage } from './currency-converter.page';

const routes: Routes = [
  {
    path: '',
    component: CurrencyConverterPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class CurrencyConverterPageRoutingModule {}
