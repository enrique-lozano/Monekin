import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { CategoriesListPageRoutingModule } from './categories-list-routing.module';

import { TranslocoModule } from '@ngneat/transloco';
import { SwiperModule } from 'swiper/angular';
import { CategoriesListPage } from './categories-list.page';
import { SubcategorySelectorComponent } from './components/subcategory-selector/subcategory-selector.component';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    TranslocoModule,
    SwiperModule,
    CategoriesListPageRoutingModule,
  ],
  declarations: [CategoriesListPage, SubcategorySelectorComponent],
})
export class CategoriesListPageModule {}
