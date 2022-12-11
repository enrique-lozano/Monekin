import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { BudgetFormPageRoutingModule } from './budget-form-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { ComponentsModule } from 'src/app/modules/components.module';
import { BudgetFormPage } from './budget-form.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    IonicModule,
    TranslocoModule,
    ComponentsModule,
    BudgetFormPageRoutingModule,
  ],
  declarations: [BudgetFormPage],
})
export class BudgetFormPageModule {}
