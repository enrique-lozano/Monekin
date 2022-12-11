import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: '',
    redirectTo: '/tabs/tab1',
    pathMatch: 'full',
  },
  {
    path: 'tabs',
    redirectTo: '/tabs/tab1',
    pathMatch: 'full',
  },
  {
    path: 'tabs/tab1',
    loadChildren: () =>
      import('./pages/tabs/tab1/tab1.module').then((m) => m.Tab1PageModule),
  },
  {
    path: 'tabs/tab2',
    loadChildren: () =>
      import('./pages/tabs/tab2/tab2.module').then((m) => m.Tab2PageModule),
  },
  {
    path: 'tabs/tab3',
    loadChildren: () =>
      import('./pages/tabs/tab3/tab3.module').then((m) => m.Tab3PageModule),
  },
  {
    path: 'account-details',
    loadChildren: () =>
      import('./pages/accounts/account-details/account-details.module').then(
        (m) => m.AccountDetailsPageModule
      ),
  },
  {
    path: 'account-form',
    loadChildren: () =>
      import('./pages/accounts/account-form/account-form.module').then(
        (m) => m.AccountFormPageModule
      ),
  },
  {
    path: 'settings',
    loadChildren: () =>
      import('./pages/settings/settings.module').then(
        (m) => m.SettingsPageModule
      ),
  },
];
@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules }),
  ],
  exports: [RouterModule],
})
export class AppRoutingModule {}
