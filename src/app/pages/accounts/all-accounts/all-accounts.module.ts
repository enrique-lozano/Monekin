import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { AllAccountsPageRoutingModule } from './all-accounts-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { AllAccountsPage } from './all-accounts.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    ComponentsModule,
    TranslocoModule,
    AllAccountsPageRoutingModule,
  ],
  declarations: [AllAccountsPage],
})
export class AllAccountsPageModule {}
