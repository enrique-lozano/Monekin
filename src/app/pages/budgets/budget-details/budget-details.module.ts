import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { BudgetDetailsPageRoutingModule } from './budget-detail-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { SwiperModule } from 'swiper/angular';
import { BudgetDetailsPage } from './budget-details.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    BudgetDetailsPageRoutingModule,
    ComponentsModule,
    SwiperModule,
    TranslocoModule,
  ],
  declarations: [BudgetDetailsPage],
})
export class BudgetDetailsPageModule {}
