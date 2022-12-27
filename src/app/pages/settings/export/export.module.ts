import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { ExportPageRoutingModule } from './export-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { ExportPage } from './export.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    ExportPageRoutingModule,
    TranslocoModule,
  ],
  declarations: [ExportPage],
})
export class ExportPageModule {}
