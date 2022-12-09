import { Component } from '@angular/core';
import { StorageService } from './services/db/storage.service';
import { TranslateService } from './services/translate/translate.service';

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent {
  constructor(
    private storage: StorageService,
    private translateService: TranslateService
  ) {
    this.storage.init().then(() => {
      this.getStartedConfig();
    });
  }

  private async getStartedConfig() {
    await this.translateService.setInitialAppLang();
    //SplashScreen.hide();
  }
}
