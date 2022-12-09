import { Injectable } from '@angular/core';
import { IonicStorageKey } from 'src/app/constants/capacitor-storage';
import { UserData } from 'src/app/models/user-data.model';
import { StorageService } from './storage.service';

@Injectable({
  providedIn: 'root',
})
export class UserDataService {
  private userData: UserData;

  constructor(private storageService: StorageService) {}

  async getUserData() {
    if (this.userData) return this.userData;

    this.userData = await this.storageService.get(IonicStorageKey.userData);

    if (!this.userData) {
      await this.storageService.init();
      this.userData = await this.storageService.get(IonicStorageKey.userData);
    }

    return this.userData;
  }

  async setUserData(newData: Partial<UserData>) {
    if (!this.userData) await this.getUserData();

    this.userData = { ...this.userData, ...newData };

    await this.storageService.set(IonicStorageKey.userData, this.userData);
  }
}
