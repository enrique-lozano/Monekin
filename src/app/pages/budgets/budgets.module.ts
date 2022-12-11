import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { BudgetsPageRoutingModule } from './budgets-routing.module';

import { BudgetsPage } from './budgets.page';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { SwiperModule } from 'swiper/angular';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    BudgetsPageRoutingModule,
    SwiperModule,
    ComponentsModule,
    TranslocoModule,
  ],
  declarations: [BudgetsPage],
})
export class BudgetsPageModule {}
