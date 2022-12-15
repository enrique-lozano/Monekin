import { Component, OnInit } from '@angular/core';
import { StatusBarService } from 'src/app/services/ionic/status-bar.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit {
  constructor(private statusBar: StatusBarService) {}

  ngOnInit() {}

  ionViewWillEnter() {
    this.statusBar.setLightStatusBar();
  }
}
