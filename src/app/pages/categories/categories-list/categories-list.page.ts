import {
  AfterContentChecked,
  ChangeDetectorRef,
  Component,
  Input,
  ViewChild,
} from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ModalController } from '@ionic/angular';
import {
  Category,
  MainCategory,
} from 'src/app/services/db/category/category.model';
import { CategoryService } from 'src/app/services/db/category/category.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { SwiperComponent } from 'swiper/angular';
import { SwiperOptions } from 'swiper/types';

@Component({
  selector: 'app-categories-list',
  templateUrl: './categories-list.page.html',
  styleUrls: ['./categories-list.page.scss'],
})
export class CategoriesListPage implements AfterContentChecked {
  allMainCategories: MainCategory[];
  categoriesExpense: MainCategory[];
  categoriesIncome: MainCategory[];

  @Input() mode:
    | 'category'
    | 'modal-with-subcats'
    | 'modal-without-subcats'
    | 'multiselection';

  segmentValue: 'Income' | 'Expense' = 'Expense';

  @Input() selectedCategories: 'all' | Category[] = [];

  constructor(
    private readonly categoryService: CategoryService,
    private changeDet: ChangeDetectorRef,
    private router: Router,
    private activeRoute: ActivatedRoute,
    private modalService: IonModalService,
    private modalCtrl: ModalController
  ) {}

  @ViewChild('swiper') swiper: SwiperComponent;
  config: SwiperOptions = {
    initialSlide: 1,
  };

  ngAfterContentChecked() {
    if (this.swiper) {
      this.swiper.updateSwiper({});
    }
  }

  async ionViewDidEnter() {
    this.allMainCategories = (
      await this.categoryService.getCategories()
    ).filter((x) => x instanceof MainCategory) as MainCategory[];

    this.categoriesExpense = this.allMainCategories.filter(
      (mainCat) => mainCat.type != 'I'
    );

    this.categoriesIncome = this.allMainCategories.filter(
      (mainCat) => mainCat.type != 'E'
    );

    if (this.activeRoute.snapshot.queryParamMap.get('returnTo') == 'category') {
      this.mode = 'category';
    }

    const _this = this;
    _this.modalService.recalculateContentHeight();
  }

  isCheckboxSelected(category: MainCategory) {
    return (
      this.selectedCategories == 'all' ||
      this.selectedCategories.some((x) => x.id == category.id)
    );
  }

  slideChanged() {
    if (this.swiper.swiperRef) {
      //console.log('Swiper changed', this.swiper.swiperRef.activeIndex);
      if (this.swiper.swiperRef.activeIndex == 0) {
        this.segmentValue = 'Income';
      } else if (this.swiper.swiperRef.activeIndex == 1) {
        this.segmentValue = 'Expense';
      }
      this.changeDet.detectChanges();
    }
  }

  async selectCategory(category: MainCategory) {
    if (this.mode == 'modal-without-subcats') {
      category = this.changeCategoryType(category);
      this.modalCtrl.dismiss([category]);
    } else if (this.mode == 'modal-with-subcats') {
      const subcats = await this.categoryService.getSubcategories(category);

      if (subcats.length > 0) {
        const modalResult =
          await this.modalService.openSubcategorySelectorModal(category);

        if (modalResult.data) {
          if (modalResult.data instanceof MainCategory) {
            modalResult.data = this.changeCategoryType(modalResult.data);
          }
          this.modalCtrl.dismiss([modalResult.data]);
        }
      } else if (subcats.length == 0) {
        category = this.changeCategoryType(category);

        this.modalCtrl.dismiss([category]);
      }
    } else if (this.mode == 'category') {
      this.router.navigate(['category-form', category.id]);
    } else if (this.mode == 'multiselection') {
      if (
        this.isCheckboxSelected(category) &&
        this.selectedCategories == 'all'
      ) {
        this.selectedCategories = this.allMainCategories.filter(
          (x) => x.id != category.id
        );
      } else if (
        this.isCheckboxSelected(category) &&
        this.selectedCategories != 'all'
      ) {
        this.selectedCategories = this.selectedCategories.filter(
          (x) => x.id != category.id
        );
      } else if (
        !this.isCheckboxSelected(category) &&
        this.selectedCategories != 'all'
      ) {
        this.selectedCategories.push(category);
        if (this.selectedCategories.length == this.allMainCategories.length)
          this.selectedCategories = 'all';
      }

      this.changeDet.detectChanges();
    }
  }

  dismiss() {
    this.modalCtrl.dismiss();
  }

  submit() {
    this.modalCtrl.dismiss(this.selectedCategories);
  }

  goToCreateCategory() {
    this.router.navigate(['category-form']);
  }

  /** Change category selected type based on the swiper index */
  changeCategoryType(category: MainCategory) {
    if (category.type == 'B') {
      if (this.swiper.swiperRef.activeIndex == 0) {
        category.type = 'I';
      } else if (this.swiper.swiperRef.activeIndex == 1) {
        category.type = 'E';
      }
    }

    return category;
  }

  // Go to the next and the prev slide
  next() {
    this.swiper.swiperRef.slideNext();
  }

  prev() {
    this.swiper.swiperRef.slidePrev();
  }
}
