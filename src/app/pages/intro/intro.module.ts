import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { IntroPageRoutingModule } from './intro-routing.module';
import { IntroPage } from './intro.page';

import { TranslocoModule } from '@ngneat/transloco';
import { SwiperModule } from 'swiper/angular';
import { ImportDataPage } from './import-data/import-data.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    IntroPageRoutingModule,
    SwiperModule,
    TranslocoModule,
  ],
  declarations: [IntroPage, ImportDataPage],
})
export class IntroPageModule {}
