import { Injectable } from '@angular/core';
import { UserDataService } from '../user-data.service';
import { defaultSettings, UserSettings } from './settings.model';

@Injectable({
  providedIn: 'root',
})
export class SettingsService {
  private userSettings: UserSettings;

  constructor(private userDataService: UserDataService) {}

  async getSettings() {
    if (!this.userSettings) {
      await this.refreshSettings();
    }

    return this.userSettings;
  }

  async refreshSettings() {
    this.userSettings =
      (await this.userDataService.getUserData()).settings || defaultSettings;
  }

  async setSettings(settings: Partial<UserSettings>) {
    this.userSettings = { ...this.userSettings, ...settings };
    await this.userDataService.setUserData({ settings: this.userSettings });
  }
}
