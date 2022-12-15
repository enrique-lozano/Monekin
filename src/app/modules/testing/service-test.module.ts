import { NgModule } from '@angular/core';

import { IonicModule } from '@ionic/angular';

import { HttpClientTestingModule } from '@angular/common/http/testing';

import { TranslocoModule } from '@ngneat/transloco';
import { StorageModule } from '../storage.module';

@NgModule({
  declarations: [],
  imports: [
    IonicModule.forRoot(),
    HttpClientTestingModule,
    TranslocoModule,
    StorageModule,
  ],
})
export class ServiceTestModule {}
