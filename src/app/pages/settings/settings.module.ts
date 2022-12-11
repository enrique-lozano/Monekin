import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';
import { TranslocoModule } from '@ngneat/transloco';
import { DataPage } from './data/data.page';
import { GeneralPage } from './general/general.page';
import { LegalPage } from './legal/legal.page';
import { LicensePage } from './license/license.page';

import { SettingsPageRoutingModule } from './settings-routing.module';

import { SettingsPage } from './settings.page';
import { UserProfileEditionComponent } from './user-profile-edition/user-profile-edition.component';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    TranslocoModule,
    SettingsPageRoutingModule,
  ],
  declarations: [
    SettingsPage,
    UserProfileEditionComponent,
    LicensePage,
    LegalPage,
    GeneralPage,
    DataPage,
  ],
})
export class SettingsPageModule {}
