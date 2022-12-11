import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { TransactionDetailsPageRoutingModule } from './transaction-details-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { TransactionDetailsPage } from './transaction-details.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    TranslocoModule,
    ComponentsModule,
    TransactionDetailsPageRoutingModule,
  ],
  declarations: [TransactionDetailsPage],
})
export class TransactionDetailsPageModule {}
