import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { AccountDetailsPageRoutingModule } from './account-details-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { AccountDetailsPage } from './account-details.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    AccountDetailsPageRoutingModule,
    ComponentsModule,
    TranslocoModule,
  ],
  declarations: [AccountDetailsPage],
})
export class AccountDetailsPageModule {}
