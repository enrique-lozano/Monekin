import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { LayoutPageRoutingModule } from './layout-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { TabsPageModule } from '../tabs/tabs.module';
import { LayoutPage } from './layout.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    LayoutPageRoutingModule,
    TranslocoModule,
    TabsPageModule,
  ],
  declarations: [LayoutPage],
})
export class LayoutPageModule {}
