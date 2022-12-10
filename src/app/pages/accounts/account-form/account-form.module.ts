import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { AccountFormPageRoutingModule } from './account-form-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { AccountFormPage } from './account-form.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    TranslocoModule,
    ReactiveFormsModule,
    AccountFormPageRoutingModule,
  ],
  declarations: [AccountFormPage],
})
export class AccountFormPageModule {}
