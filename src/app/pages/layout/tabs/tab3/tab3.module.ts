import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { IonicModule } from '@ionic/angular';
import { Tab3Page } from './tab3.page';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { SwiperModule } from 'swiper/angular';
import { SelectTypeOfCategoryComponent } from './components/select-type-of-category/select-type-of-category.component';
import { StatisticsComponent } from './components/statistics/statistics.component';
import { Tab3PageRoutingModule } from './tab3-routing.module';

@NgModule({
  imports: [
    IonicModule,
    CommonModule,
    FormsModule,
    RouterModule.forChild([{ path: '', component: Tab3Page }]),
    Tab3PageRoutingModule,
    TranslocoModule,
    SwiperModule,
    ComponentsModule,
  ],
  declarations: [Tab3Page, StatisticsComponent, SelectTypeOfCategoryComponent],
})
export class Tab3PageModule {}
