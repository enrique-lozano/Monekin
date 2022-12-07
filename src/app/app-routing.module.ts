import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'tabs/tab1',
    loadChildren: () =>
      import('./tab1/tab1.module').then((m) => m.Tab1PageModule),
  },
  {
    path: 'tabs/tab2',
    loadChildren: () =>
      import('./tab2/tab2.module').then((m) => m.Tab2PageModule),
  },
  {
    path: 'tabs/tab3',
    loadChildren: () =>
      import('./tab3/tab3.module').then((m) => m.Tab3PageModule),
  },
  {
    path: '',
    redirectTo: '/tabs/tab1',
    pathMatch: 'full',
  },
  {
    path: 'home',
    loadChildren: () => import('./home/home.module').then( m => m.HomePageModule)
  },
];
@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules }),
  ],
  exports: [RouterModule],
})
export class AppRoutingModule {}
