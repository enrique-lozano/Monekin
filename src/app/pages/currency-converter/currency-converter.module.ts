import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { CurrencyConverterPageRoutingModule } from './currency-converter-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { CurrencyConverterPage } from './currency-converter.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    TranslocoModule,
    CurrencyConverterPageRoutingModule,
  ],
  declarations: [CurrencyConverterPage],
})
export class CurrencyConverterPageModule {}
