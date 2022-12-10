import { IonicModule } from '@ionic/angular';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Tab2Page } from './tab2.page';

import { Tab2PageRoutingModule } from './tab2-routing.module';
import { SwiperModule } from 'swiper/angular';
import { ComponentsModule } from 'src/app/modules/components.module';

import { TranslocoModule } from '@ngneat/transloco';
@NgModule({
  imports: [
    IonicModule,
    CommonModule,
    FormsModule,
    Tab2PageRoutingModule,
TranslocoModule,    SwiperModule,
    ComponentsModule,
  ],
  declarations: [Tab2Page],
})
export class Tab2PageModule {}
