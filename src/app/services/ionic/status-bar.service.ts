import { Injectable } from '@angular/core';
import {
  BackgroundColorOptions,
  StatusBar,
  Style,
} from '@capacitor/status-bar';
import { isPlatform } from '@ionic/angular';

@Injectable({
  providedIn: 'root',
})
export class StatusBarService {
  constructor() {}

  /** Set the status bar light in normal mode and darker in dark mode */
  setLightStatusBar() {
    const colorToSet = getComputedStyle(
      document.documentElement
    ).getPropertyValue('--ion-color-light');

    if (
      window.matchMedia &&
      window.matchMedia('(prefers-color-scheme: dark)').matches
    ) {
      this.setStatusBarColor(colorToSet, 'Light');
    } else {
      this.setStatusBarColor(colorToSet, 'Dark');
    }
  }

  /** Sets the status bar to the primary color of the app */
  setPrimaryStatusBar() {
    this.setStatusBarColor(
      getComputedStyle(document.documentElement).getPropertyValue(
        '--ion-color-primary'
      ),
      'Light'
    );
  }

  /** Set the status bar color. Only working for android.
   *
   * @param hexColor The color in an hex format. Ex.: "#ffffff"
   */
  setStatusBarColor(hexColor: string, textColor: 'Dark' | 'Light') {
    if (!isPlatform('capacitor')) return;

    StatusBar.getInfo().then((res) => {
      const statusbaropts: BackgroundColorOptions = {
        color: hexColor.trim(),
      };
      StatusBar.setBackgroundColor(statusbaropts);

      if (res.style != Style.Light && textColor == 'Dark') {
        StatusBar.setStyle({ style: Style.Light }); // Light bg - Dark text
      } else if (res.style != Style.Dark && textColor == 'Light') {
        StatusBar.setStyle({ style: Style.Dark }); // Dark bg - white text
      }
    });
  }
}
