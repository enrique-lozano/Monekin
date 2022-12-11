import { Component, Input } from '@angular/core';
import { ModalController } from '@ionic/angular';
import {
  Category,
  ChildCategory,
  MainCategory,
} from 'src/app/services/db/category/category.model';
import { CategoryService } from 'src/app/services/db/category/category.service';

@Component({
  selector: 'app-subcategory-selector',
  templateUrl: './subcategory-selector.component.html',
  styleUrls: ['./subcategory-selector.component.scss'],
})
export class SubcategorySelectorComponent {
  @Input() category: MainCategory;

  subcategories: ChildCategory[];

  selectedCategory: Category;

  constructor(
    private categoryService: CategoryService,
    private modalCtrl: ModalController
  ) {}

  ionViewWillEnter() {
    this.getSubcategories();
  }

  async getSubcategories() {
    this.selectedCategory = this.category;

    this.subcategories = await this.categoryService.getSubcategories(
      this.category
    );
  }

  selectCategory(category: Category) {
    this.selectedCategory = category;
  }

  submit() {
    this.modalCtrl.dismiss(this.selectedCategory);
  }
}
