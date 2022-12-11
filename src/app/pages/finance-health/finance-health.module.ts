import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { FinanceHealthPageRoutingModule } from './finance-health-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { FinanceHealthPage } from './finance-health.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    TranslocoModule,
    ComponentsModule,
    IonicModule,
    FinanceHealthPageRoutingModule,
  ],
  declarations: [FinanceHealthPage],
})
export class FinanceHealthPageModule {}
