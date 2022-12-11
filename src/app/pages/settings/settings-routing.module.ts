import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DataPage } from './data/data.page';
import { GeneralPage } from './general/general.page';
import { LegalPage } from './legal/legal.page';
import { LicensePage } from './license/license.page';

import { SettingsPage } from './settings.page';

const routes: Routes = [
  {
    path: '',
    component: SettingsPage,
  },
  {
    path: 'license',
    component: LicensePage,
  },
  {
    path: 'legal',
    component: LegalPage,
  },
  {
    path: 'data',
    component: DataPage,
  },
  {
    path: 'general',
    component: GeneralPage,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class SettingsPageRoutingModule {}
