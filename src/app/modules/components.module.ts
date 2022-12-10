import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';

import { SwiperModule } from 'swiper/angular';

import { RouterModule } from '@angular/router';
import { TranslocoModule } from '@ngneat/transloco';
import { CurrencyValueComponent } from '../components/ui/currency-value/currency-value.component';
import { TransactionListComponent } from '../components/ui/transaction-list/transaction-list.component';
import { TrendingComponent } from '../components/ui/trending/trending.component';

@NgModule({
  declarations: [
    CurrencyValueComponent,
    TrendingComponent,
    TransactionListComponent,
  ],
  imports: [
    CommonModule,
    TranslocoModule,
    IonicModule,
    RouterModule,
    FormsModule,
    SwiperModule,
  ],
  exports: [
    CurrencyValueComponent,
    TrendingComponent,
    TransactionListComponent,
  ],
})
export class ComponentsModule {}
