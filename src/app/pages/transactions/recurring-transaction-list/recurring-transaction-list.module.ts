import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { RecurringTransactionListPageRoutingModule } from './recurring-transaction-list-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { RecurringTransactionListPage } from './recurring-transaction-list.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ComponentsModule,
    IonicModule,
    TranslocoModule,
    RecurringTransactionListPageRoutingModule,
  ],
  declarations: [RecurringTransactionListPage],
})
export class RecurringTransactionListPageModule {}
