import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { TransactionFormPageRoutingModule } from './transaction-form-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { CurrencyExchangeSelectorComponent } from './components/currency-exchange-selector/currency-exchange-selector.component';
import { RecurrentSelectorComponent } from './components/recurrent-selector/recurrent-selector.component';
import { TransactionFormPage } from './transaction-form.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    IonicModule,
    TranslocoModule,
    ComponentsModule,
    TransactionFormPageRoutingModule,
  ],
  declarations: [
    TransactionFormPage,
    RecurrentSelectorComponent,
    CurrencyExchangeSelectorComponent,
  ],
})
export class TransactionFormPageModule {}
