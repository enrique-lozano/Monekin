import { v4 as generateUUID } from 'uuid';

/** Common attributes that will be saved in the permanent storage and in memory */
abstract class CategoryBase {
  readonly id: string;

  /** Name of the category. Should be unique in the user categories (the user can not have another category/subcategory with the same name) */
  name: string;

  icon: string;

  constructor(obj: any) {
    Object.assign(this, obj);

    if (!this.id) this.id = generateUUID();
  }
}

export class MainCategory extends CategoryBase {
  /** Color in an HEX format, without the first character '#'. Only applicable if this category is a parent category (does not have parentCategory attribute defined). Child categories will have the same color as its parents  */
  color: string;

  /** Type of the category. "E" for expense, "I" for income and "B" for both. Only applicable if this category is a parent category (does not have parentCategory attribute defined). Child caterories will have the same type as its parents */
  type: 'E' | 'I' | 'B';

  parentCategory?: never;
  parentCategoryID?: never;

  constructor(obj: MainCategory | Omit<MainCategory, 'id'>) {
    super(obj);
  }
}

export class ChildCategory extends CategoryBase {
  parentCategory: MainCategory;

  color?: never;
  type?: never;

  constructor(obj: ChildCategory | Omit<ChildCategory, 'id'>) {
    super(obj);

    if (obj.parentCategory)
      this.parentCategory = new MainCategory(obj.parentCategory);
  }
}

/** Credits to the solution for: https://stackoverflow.com/a/61281828 */
export type Category = MainCategory | ChildCategory;

export type CategoryInStorage =
  | MainCategory
  | (Omit<ChildCategory, 'parentCategory'> & { parentCategoryID: string });

export const unknownCategory: Omit<MainCategory, 'name'> = {
  id: generateUUID(),
  color:
    window.matchMedia &&
    window.matchMedia('(prefers-color-scheme: dark)').matches
      ? '#ffffff'
      : '#000000',
  type: 'B',
  icon: 'help',
};
