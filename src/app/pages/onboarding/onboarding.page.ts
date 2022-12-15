import {
  AfterContentChecked,
  ChangeDetectorRef,
  Component,
  OnInit,
  ViewChild,
} from '@angular/core';
import { Router } from '@angular/router';
import { BackupService } from 'src/app/services/backup/backup.service';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';
import { CookieService } from 'src/app/services/db/cookie/cookie.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { StatusBarService } from 'src/app/services/ionic/status-bar.service';
import { ToastService } from 'src/app/services/ionic/toast.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { SwiperComponent } from 'swiper/angular';
import { SwiperOptions } from 'swiper/types';

@Component({
  selector: 'app-onboarding',
  templateUrl: './onboarding.page.html',
  styleUrls: ['./onboarding.page.scss'],
})
export class OnboardingPage implements OnInit, AfterContentChecked {
  currentSlide = 0;
  userCurrency: Currency;

  constructor(
    private router: Router,
    private currencyService: CurrencyService,
    private changeDet: ChangeDetectorRef,
    private statusBar: StatusBarService,
    private modalService: IonModalService,
    public lang: LangService,
    private cookies: CookieService,
    private backupService: BackupService,
    private toast: ToastService
  ) {}

  ngOnInit() {}

  async ionViewWillEnter() {
    this.statusBar.setStatusBarColor(
      getComputedStyle(document.documentElement).getPropertyValue(
        '--ion-color-light'
      ),
      'Dark'
    );

    this.userCurrency = await this.currencyService.getUserCurrency();
  }

  @ViewChild('swiper') swiper: SwiperComponent;
  config: SwiperOptions = {};

  ngAfterContentChecked() {
    if (this.swiper) {
      this.swiper.updateSwiper({});
    }
  }

  slideNext() {
    if (this.swiper.swiperRef.isEnd) {
      this.introFinished();
      return;
    }

    this.swiper.swiperRef.slideNext();
  }

  onSwipe() {
    this.currentSlide = this.swiper.swiperRef.activeIndex;
    this.changeDet.detectChanges();
  }

  async goToSelectCoin() {
    const modalResult = await this.modalService.openCurrencySelectorModal();

    if (modalResult.data) {
      this.userCurrency = modalResult.data;
      this.currencyService.setUserCurrency(this.userCurrency);
    }
  }

  async introFinished() {
    await this.cookies.setCookies({ introSeen: true });

    this.router.navigate(['tabs'], { replaceUrl: true });
  }

  importFile() {
    document.getElementById('file-input').click();
  }

  onFileSelected() {
    const filesUpload: any = document.querySelector('#file-input');

    if (filesUpload.files && filesUpload.files.length > 0) {
      const fileReader: FileReader = new FileReader();
      fileReader.readAsText(filesUpload.files[0]);
      fileReader.onload = async () => {
        if (fileReader.result) {
          this.backupService
            .importDataFromFile(fileReader.result)
            .then(() => {})
            .catch((err) => {
              this.toast.present('BACKUP.IMPORT.error', 'danger');
              console.error(err);
            });
        }
      };
    }
  }
}
