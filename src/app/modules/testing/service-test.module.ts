import { NgModule } from '@angular/core';

import { IonicModule } from '@ionic/angular';

import { HttpClientTestingModule } from '@angular/common/http/testing';

import { TranslocoModule } from '@ngneat/transloco';
import { StorageModule } from '../storage.module';

import { registerLocaleData } from '@angular/common';
import localeEn from '@angular/common/locales/en';
import { LOCALE_ID } from '@angular/core';

registerLocaleData(localeEn, 'en');

@NgModule({
  declarations: [],
  imports: [
    IonicModule.forRoot(),
    HttpClientTestingModule,
    TranslocoModule,
    StorageModule,
  ],
  providers: [{ provide: LOCALE_ID, useValue: 'en' }],
})

/** A module with all the usual modules that a service.spec.ts needs */
export class ServiceTestModule {}
