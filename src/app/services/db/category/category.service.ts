import { Injectable } from '@angular/core';
import { defaultCategories } from 'src/app/constants/default-categories';
import { defaultLang } from 'src/app/modules/i18n/availableLangs';
import { v4 as generateUUID } from 'uuid';
import { LangService } from '../../translate/translate.service';
import { UserDataService } from '../user-data.service';
import {
  Category,
  CategoryInStorage,
  ChildCategory,
  MainCategory,
} from './category.model';

@Injectable({
  providedIn: 'root',
})
export class CategoryService {
  private categories: Category[];

  selectedCategory: Category;

  constructor(
    private lang: LangService,
    private userDataService: UserDataService
  ) {}

  async getCategories() {
    if (!this.categories) {
      await this.refreshCategories();
    }

    return this.categories;
  }

  async refreshCategories() {
    this.categories = this.categoriesToMemory(
      (await this.userDataService.getUserData()).categories ||
        (await this.getInitialCategories())
    );
  }

  async getCategoryByUUID(uuid: string) {
    return (await this.getCategories()).find((x) => x.id == uuid);
  }

  addCategory(category: Category) {
    if (
      !(category instanceof MainCategory || category instanceof ChildCategory)
    )
      throw new Error('You should pass an instance of a class to this method');

    this.categories.push(category);

    return this.userDataService.setUserData({
      categories: this.categoriesToStorage(this.categories),
    });
  }

  /** Edits a transaction
   *
   * @param uuid The id of the transaction to edit
   * @param editedCategory The new transaction instance to replace the found transaction
   */
  editCategory(uuid: string, editedCategory: Category) {
    if (
      !(
        editedCategory instanceof MainCategory ||
        editedCategory instanceof ChildCategory
      )
    )
      throw new Error('You should pass an instance of a class to this method');

    this.categories = this.categories.map((cat) => {
      if (cat.id === uuid) return editedCategory;
      else return cat;
    });

    return this.userDataService.setUserData({
      categories: this.categoriesToStorage(this.categories),
    });
  }

  protected categoriesToMemory(categories: CategoryInStorage[]) {
    if (!categories) return undefined;

    const result: Category[] = [];

    categories.forEach((category) => {
      if (category.parentCategoryID) {
        const parentCategoryInStorage = categories.find(
          (x) => x.id === category.parentCategoryID
        );

        const parentCategory: Omit<MainCategory, 'getColor'> = {
          id: parentCategoryInStorage.id,
          name: parentCategoryInStorage.name,
          color: parentCategoryInStorage.color,
          icon: parentCategoryInStorage.icon,
          type: parentCategoryInStorage.type,
        };

        result.push(
          new ChildCategory({
            id: category.id,
            icon: category.icon,
            name: category.name,
            parentCategory,
          })
        );
      } else {
        result.push(
          new MainCategory({
            id: category.id,
            name: category.name,
            color: category.color,
            icon: category.icon,
            type: category.type,
          })
        );
      }
    });

    return result;
  }

  protected categoriesToStorage(categories: Category[]) {
    return categories.map((x) => {
      let mappedValue: CategoryInStorage;
      if (x.parentCategory) {
        mappedValue = {
          id: x.id,
          name: x.name,
          icon: x.icon,
          parentCategoryID: x.parentCategory.id,
        };
      } else {
        mappedValue = {
          id: x.id,
          name: x.name,
          color: x.color,
          icon: x.icon,
          type: x.type,
        };
      }

      return mappedValue;
    });
  }

  /** Delete a category (or a subcategory). If a parent category is passed by parameter all its subcategories will also be removed in this function.
   *
   * @param uuid The uuid of the category (or the subcategory)
   */
  async deleteCategory(uuid: string) {
    this.categories = this.categories.filter(
      (category) => category.id != uuid && category.parentCategory?.id != uuid
    );

    return this.userDataService.setUserData({
      categories: this.categoriesToStorage(this.categories),
    });
  }

  /** Gets all the subcategories of a main category */
  async getSubcategories(category: MainCategory) {
    const allCategories = await this.getCategories();

    return allCategories.filter(
      (x) => x.parentCategory?.id == category.id
    ) as ChildCategory[];
  }

  /** Return the color of a category/subcategory in HEX format (#000000) */
  getCategoryColor(category: Category) {
    if (category) {
      return '#' + (category.color ?? category.parentCategory.color);
    }

    if (
      window.matchMedia &&
      window.matchMedia('(prefers-color-scheme: dark)').matches
    )
      return '#ffffff';

    return '#000000';
  }

  async getInitialCategories() {
    if (this.categories) return;

    const categoriesToStorage: CategoryInStorage[] = [];

    defaultCategories.forEach((category) => {
      const newCategory: CategoryInStorage = {
        id: generateUUID(),
        name:
          category.names[this.lang.getSelectedLang()] ??
          category.names[defaultLang],
        icon: category.icon,
        color: category.color,
        type: category.type,
      };

      categoriesToStorage.push(newCategory);

      if (category.subcategories) {
        category.subcategories.forEach((subcategory) => {
          categoriesToStorage.push({
            id: generateUUID(),
            name:
              subcategory.names[this.lang.getSelectedLang()] ??
              subcategory.names[defaultLang],
            icon: subcategory.icon,
            parentCategoryID: newCategory.id,
          });
        });
      }
    });

    await this.userDataService.setUserData({ categories: categoriesToStorage });
    return categoriesToStorage;
  }
}
