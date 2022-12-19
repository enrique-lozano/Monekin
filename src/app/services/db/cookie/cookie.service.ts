import { Injectable } from '@angular/core';
import { UserDataService } from '../user-data.service';
import { default as packageInfo } from './../../../../../package.json';
import { Cookies, defaultCookies } from './cookies.model';

@Injectable({
  providedIn: 'root',
})
export class CookieService {
  private cookies: Cookies;

  constructor(private userDataService: UserDataService) {}

  async getCookies() {
    if (!this.cookies) await this.refreshCookies();

    return this.cookies;
  }

  async refreshCookies() {
    this.cookies =
      (await this.userDataService.getUserData()).cookies || defaultCookies;
  }

  async setCookies(cookies: Partial<Cookies>) {
    this.cookies = { ...(await this.getCookies()), ...cookies };
    await this.userDataService.setUserData({ cookies: this.cookies });
  }

  async setCurrentAppVersion() {
    await this.setCookies({ modelVersion: packageInfo.version });
  }
}
