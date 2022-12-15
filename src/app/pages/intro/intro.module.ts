import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { IntroPageRoutingModule } from './intro-routing.module';
import { IntroPage } from './intro.page';

import { TranslocoModule } from '@ngneat/transloco';
import { SwiperModule } from 'swiper/angular';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    IntroPageRoutingModule,
    SwiperModule,
    TranslocoModule,
  ],
  declarations: [IntroPage],
})
export class IntroPageModule {}
