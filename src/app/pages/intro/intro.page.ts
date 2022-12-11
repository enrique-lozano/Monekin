import {
  AfterContentChecked,
  ChangeDetectorRef,
  Component,
  OnInit,
  ViewChild,
} from '@angular/core';
import { Router } from '@angular/router';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';
import { CookieService } from 'src/app/services/db/cookie/cookie.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { StatusBarService } from 'src/app/services/ionic/status-bar.service';
import { LangService } from 'src/app/services/translate/translate.service';
import { SwiperComponent } from 'swiper/angular';
import { SwiperOptions } from 'swiper/types';

@Component({
  selector: 'app-intro',
  templateUrl: './intro.page.html',
  styleUrls: ['./intro.page.scss'],
})
export class IntroPage implements OnInit, AfterContentChecked {
  currentSlide = 0;
  userCurrency: Currency;

  constructor(
    private router: Router,
    private currencyService: CurrencyService,
    private changeDet: ChangeDetectorRef,
    private statusBar: StatusBarService,
    private modalService: IonModalService,
    public lang: LangService,
    private cookies: CookieService
  ) {}

  ngOnInit() {}

  async ionViewWillEnter() {
    this.statusBar.setLightStatusBar();

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
    if (this.currentSlide == 2) {
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

    this.router.navigate(['intro/import-data'], { replaceUrl: true });
  }

  getCoinTranslationKey(code: string): string {
    return 'COINS.' + code;
  }
}
