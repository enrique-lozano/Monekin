import { Component, OnInit } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { UserAvatars } from 'src/app/services/db/settings/settings.model';
import { SettingsService } from 'src/app/services/db/settings/settings.service';

@Component({
  selector: 'app-user-profile-edition',
  templateUrl: './user-profile-edition.component.html',
  styleUrls: ['./user-profile-edition.component.scss'],
})
export class UserProfileEditionComponent implements OnInit {
  allAvatarsEnum = UserAvatars;
  allAvatars = Object.keys(UserAvatars);

  selectedAvatar: UserAvatars;
  userName: string;

  constructor(
    private settingsService: SettingsService,
    private modalCtrl: ModalController
  ) {}

  ngOnInit() {
    this.getUserData();
  }

  async getUserData() {
    const userSettings = await this.settingsService.getSettings();

    this.userName = userSettings.userName;
    this.selectedAvatar = userSettings.avatar;
  }

  async submit() {
    await this.settingsService.setSettings({
      avatar: this.selectedAvatar,
      userName: this.userName,
    });

    this.dismiss();
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }
}
