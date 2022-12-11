import { Injectable } from '@angular/core';
import { CanActivate, Router } from '@angular/router';
import { CookieService } from '../services/db/cookie/cookie.service';

@Injectable({
  providedIn: 'root',
})

/** Guard that redirects to the intro page if the user has not seen the intro yet */
export class IntroGuard implements CanActivate {
  constructor(private router: Router, private cookies: CookieService) {}

  async canActivate(): Promise<boolean> {
    const hasSeenIntro = (await this.cookies.getCookies())?.introSeen;
    //const hasSeenIntro = true;

    if (hasSeenIntro === true) {
      // If the user have seen the intro we can stay
      return true;
    } else {
      // If the user have not seen the intro we should go to intro
      this.router.navigateByUrl('/intro', { replaceUrl: true });
      return true;
    }
  }
}
