import { NgModule } from '@angular/core';

// Ionic Storage:
import { Drivers } from '@ionic/storage';
import { IonicStorageModule } from '@ionic/storage-angular';
import * as cordovaSQLiteDriver from 'localforage-cordovasqlitedriver';

@NgModule({
  declarations: [],
  imports: [
    IonicStorageModule.forRoot({
      name: 'myStorage',
      driverOrder: [
        cordovaSQLiteDriver._driver,
        Drivers.IndexedDB,
        Drivers.LocalStorage,
      ],
    }),
  ],
})
export class StorageModule {}
