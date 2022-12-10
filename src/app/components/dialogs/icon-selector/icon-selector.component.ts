import { Component, Input, OnInit, ViewChild } from '@angular/core';
import { ModalController } from '@ionic/angular';
import { ionIcons } from 'src/app/constants/ion-icons';
import { SwiperOptions } from 'swiper';
import { SwiperComponent } from 'swiper/angular';

@Component({
  selector: 'app-icon-selector',
  templateUrl: './icon-selector.component.html',
  styleUrls: ['./icon-selector.component.scss'],
})
export class IconSelectorComponent implements OnInit {
  icons = ionIcons;

  @Input() selectedIcon: string;
  @Input() color: string;
  @Input() background: string;

  @Input() canSelectColor: boolean;
  @Input() showInput: boolean;
  @Input() inputValue: string;

  /** An i18n key to be translated */
  @Input() popoverTitle: string;

  colorOptions = [
    '#B71C1C',
    '#D50000',
    '#E53935',
    '#EF5350',

    '#880E4F',
    '#C51162',
    '#D81B60',
    '#EC407A',

    '#4A148C',
    '#AA00FF',
    '#8E24AA',
    '#AB47BC',

    '#1A237E',
    '#2962FF',
    '#2979FF',
    '#42A5F5',

    '#006064',
    '#00897B',
    '#00BFA5',
    '#4DB6AC',

    '#1B5E20',
    '#388E3C',
    '#8BC34A',
    '#D4E157',

    '#BF360C',
    '#F4511E',
    '#FB8C00',
    '#FFA726',

    '#E65100',
    '#FFA000',
    '#FFAB00',
    '#FFCA28',

    '#546E7A',
    '#90A4AE',
    '#795548',
    '#757575',
  ];

  segmentValue: 'icon' | 'color' = 'icon';

  @ViewChild('swiper') swiper: SwiperComponent;
  swiperConfig: SwiperOptions = {
    allowTouchMove: false,
  };

  constructor(private modalCtrl: ModalController) {}

  ngOnInit() {}

  // Go to the next and the prev slide
  slideNext() {
    this.swiper.swiperRef.slideNext();
  }

  slidePrev() {
    this.swiper.swiperRef.slidePrev();
  }

  selectIcon(icon: string) {
    this.selectedIcon = icon;
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }

  submit() {
    this.modalCtrl.dismiss({
      icon: this.selectedIcon,
      color: this.color,
      inputValue: this.inputValue,
    });
  }
}
