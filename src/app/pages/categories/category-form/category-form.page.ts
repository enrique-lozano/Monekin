import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AlertController } from '@ionic/angular';
import {
  Category,
  ChildCategory,
  MainCategory,
} from 'src/app/services/db/category/category.model';
import { CategoryService } from 'src/app/services/db/category/category.service';
import { TransactionService } from 'src/app/services/db/transaction/transaction.service';
import { IonModalService } from 'src/app/services/ionic/ion-modal.service';
import { IonPopoverService } from 'src/app/services/ionic/ion-popover.service';
import { ToastService } from 'src/app/services/ionic/toast.service';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-category-form',
  templateUrl: './category-form.page.html',
  styleUrls: ['./category-form.page.scss'],
})
export class CategoryFormPage implements OnInit {
  icon = 'home';
  typeOfCategory: 'E' | 'I' | 'B' = 'E';
  color = '#000000';

  categoryToEdit: MainCategory;

  currentSubcategories: ChildCategory[] = [];

  form: FormGroup<{
    name: FormControl<string>;
  }>;

  isSubmitted = false;

  constructor(
    private lang: LangService,
    private alertCtrl: AlertController,
    private router: Router,
    private activeRoute: ActivatedRoute,
    private categoryService: CategoryService,
    private toast: ToastService,
    private transactionService: TransactionService,
    private modalService: IonModalService,
    private changeDet: ChangeDetectorRef,
    private popoverService: IonPopoverService
  ) {
    this.form = new FormGroup({
      name: new FormControl('', [Validators.required]),
    });
  }

  async ngOnInit() {
    if (this.activeRoute.snapshot.paramMap.get('id')) {
      this.categoryToEdit = (await this.categoryService.getCategoryByUUID(
        this.activeRoute.snapshot.paramMap.get('id')
      )) as MainCategory;

      if (!this.categoryToEdit) {
        this.router.navigate(['categories-list'], {
          queryParams: { returnTo: 'category' },
        });
        throw new Error('No category found with the specificated id');
      }

      this.fillForm();
    }
  }

  ionViewDidLeave() {
    this.isSubmitted = false;
  }

  /** Fill the form if we are in edit mode */
  async fillForm() {
    this.form.controls.name.setValue(this.categoryToEdit.name);
    this.icon = this.categoryToEdit.icon;
    this.typeOfCategory = this.categoryToEdit.type;
    this.color = '#' + this.categoryToEdit.color;

    this.currentSubcategories = await this.categoryService.getSubcategories(
      this.categoryToEdit
    );
  }

  async openIconSelector() {
    const iconModalRes = await this.modalService.openIconSelectorModal(
      'ICON-SELECTOR.select-icon',
      this.icon,
      true,
      this.color,
      this.color + '19'
    );

    if (iconModalRes.data) {
      this.icon = iconModalRes.data.icon;
      this.color = iconModalRes.data.color;
    }
  }

  async openCategoryMenu(event: any) {
    const result = await this.popoverService.openPopoverMenu(event, [
      {
        id: 'make-child',
        labelKey: 'CATEGORIES.make-child',
        icon: 'enter-outline',
      },
      {
        id: 'merge',
        labelKey: 'CATEGORIES.merge',
        icon: 'git-pull-request-outline',
      },
      {
        id: 'delete',
        labelKey: 'GENERAL.delete',
        icon: 'trash-outline',
      },
    ]);

    if (result.data == 'delete') {
      await this.deleteCategory();
    } else if (result.data == 'merge') {
      await this.mergeCategory(this.categoryToEdit);
    } else if (result.data == 'make-child') {
      await this.makeSubcategory();
    }
  }

  async openSubcategoryMenu(event: any, subcategory: ChildCategory) {
    const result = await this.popoverService.openPopoverMenu(event, [
      {
        id: 'make-parent',
        labelKey: 'CATEGORIES.make-parent',
        icon: 'exit-outline',
      },
      {
        id: 'merge',
        labelKey: 'CATEGORIES.merge',
        icon: 'git-pull-request-outline',
      },
      {
        id: 'edit',
        labelKey: 'GENERAL.edit',
        icon: 'pencil-outline',
      },
      {
        id: 'delete',
        labelKey: 'GENERAL.delete',
        icon: 'trash-outline',
      },
    ]);

    if (result.data == 'delete') {
      await this.deleteCategory(subcategory);
    } else if (result.data == 'edit') {
      await this.postSubcategory(subcategory);
    } else if (result.data == 'merge') {
      await this.mergeCategory(subcategory);
    } else if (result.data == 'make-parent') {
      this.makeMainCategory(subcategory);
    }
  }

  async postSubcategory(subcategory?: ChildCategory) {
    const iconModalRes = await this.modalService.openIconSelectorModal(
      subcategory
        ? 'ICON-SELECTOR.edit-subcategory'
        : 'ICON-SELECTOR.add-subcategory',
      subcategory ? subcategory.icon : this.icon,
      false,
      this.color,
      this.color + '19',
      true,
      subcategory?.name
    );

    if (iconModalRes.data) {
      this.isSubmitted = true;

      const objToPost = new ChildCategory({
        ...(subcategory && { id: subcategory.id }),
        icon: iconModalRes.data.icon,
        name: iconModalRes.data.inputValue,
        parentCategory: this.categoryToEdit,
      });

      if (subcategory) {
        await this.categoryService.editCategory(subcategory.id, objToPost);
        await this.transactionService.refreshTransactions();
      } else {
        await this.categoryService.addCategory(objToPost);
      }

      this.currentSubcategories = await this.categoryService.getSubcategories(
        this.categoryToEdit
      );

      this.isSubmitted = false;
    }
  }

  async submit() {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    if (
      (await this.categoryService.getCategories()).find(
        (x) => x.name == this.form.value.name
      ) &&
      this.form.value.name != this.categoryToEdit.name
    ) {
      this.toast.present('CATEGORIES.already-exists', 'danger');
      return;
    }

    this.isSubmitted = true;
    this.changeDet.detectChanges();
    const startSubmisionTime = performance.now();

    const objToPost = new MainCategory({
      ...(this.categoryToEdit && {
        id: this.categoryToEdit.id,
      }),
      name: this.form.value.name,
      icon: this.icon,
      type: this.typeOfCategory,
      color:
        this.color.substring(0, 1) == '#'
          ? this.color.substring(1)
          : this.color,
    });

    if (!this.categoryToEdit) {
      await this.categoryService.addCategory(objToPost);
    } else if (this.categoryToEdit) {
      await this.categoryService.editCategory(
        this.categoryToEdit.id,
        objToPost
      );

      await this.transactionService.refreshTransactions();
    }

    const y = performance.now();

    setTimeout(() => {
      this.router.navigate(['categories-list'], {
        queryParams: { returnTo: 'category' },
      });

      this.toast.present(
        this.categoryToEdit
          ? 'CATEGORIES.edit.success'
          : 'CATEGORIES.create.success'
      );
    }, 2000 - (y - startSubmisionTime));
  }

  async mergeCategory(category: Category) {
    const modalRes = await this.modalService.openCategorySelectorModal(
      'modal-with-subcats'
    );

    if (modalRes.data) {
      const transactions = await this.transactionService.getTransactions({
        categoriesIds: [category.id],
      });

      const alert = await this.alertCtrl.create({
        cssClass: 'basicAlert',
        header: this.lang.getTranslation('CATEGORIES.merge'),
        message:
          '<div>' +
          '<p>' +
          this.lang.getTranslation('CATEGORIES.merge.warning1', {
            x: transactions.length,
            from: category.name,
            destiny: (modalRes.data[0] as Category).name,
          }) +
          '</p>' +
          '<p>' +
          this.lang.getTranslation('CATEGORIES.merge.warning2', {
            from: category.name,
          }) +
          '</p>' +
          '</div>',

        buttons: [
          {
            text: this.lang.getTranslation('GENERAL.cancel'),
            role: 'cancel',
            handler: () => {},
          },
          {
            text: this.lang.getTranslation('GENERAL.confirm'),
            handler: async () => {
              for (const trans of transactions) {
                if (modalRes.data == 'all')
                  throw new Error(
                    'Multiple categories should not be selected here'
                  );

                trans.category = modalRes.data[0] as Category;

                await this.transactionService.editTransaction(trans.id, trans);
              }

              await this.categoryService.deleteCategory(category.id);

              this.router.navigate(['categories-list'], {
                queryParams: { returnTo: 'category' },
              });
              this.toast.present('CATEGORIES.merge.success');
            },
          },
        ],
      });

      await alert.present();
    }
  }

  async makeSubcategory() {
    const modalRes = await this.modalService.openCategorySelectorModal(
      'modal-without-subcats'
    );

    if (modalRes.data) {
      const transactions = await this.transactionService.getTransactions({
        categoriesIds: [this.categoryToEdit.id],
      });

      const alert = await this.alertCtrl.create({
        cssClass: 'basicAlert',
        header: this.lang.getTranslation('CATEGORIES.make-child'),
        message:
          '<div>' +
          '<p>' +
          this.lang.getTranslation('CATEGORIES.make-child.warning1', {
            destiny: (modalRes.data[0] as MainCategory).name,
          }) +
          '</p>' +
          '<p>' +
          this.lang.getTranslation('CATEGORIES.make-child.warning2', {
            x: transactions.length,
            destiny: (modalRes.data[0] as MainCategory).name,
          }) +
          '</p>' +
          '</div>',

        buttons: [
          {
            text: this.lang.getTranslation('GENERAL.cancel'),
            role: 'cancel',
            handler: () => {},
          },
          {
            text: this.lang.getTranslation('GENERAL.confirm'),
            handler: async () => {
              const newSubcategory = new ChildCategory({
                parentCategory: modalRes.data[0] as MainCategory,
                icon: this.categoryToEdit.icon,
                name: this.categoryToEdit.name,
                id: this.categoryToEdit.id,
              });

              await this.categoryService.editCategory(
                this.categoryToEdit.id,
                newSubcategory
              );

              for (const subcat of this.currentSubcategories) {
                subcat.parentCategory = modalRes.data[0] as MainCategory;

                await this.categoryService.editCategory(subcat.id, subcat);
              }

              await this.transactionService.refreshTransactions();

              this.router.navigate(['categories-list'], {
                queryParams: { returnTo: 'category' },
              });
              this.toast.present('CATEGORIES.make-child.success');
            },
          },
        ],
      });

      await alert.present();
    }
  }

  async makeMainCategory(subcategory: ChildCategory) {
    const newMainCategory = new MainCategory({
      color: this.categoryToEdit.color,
      type: this.categoryToEdit.type,
      icon: subcategory.icon,
      name: subcategory.name,
    });

    const transactions = await this.transactionService.getTransactions({
      categoriesIds: [subcategory.id],
    });

    for (const trans of transactions) {
      trans.category = newMainCategory;

      await this.transactionService.editTransaction(trans.id, trans);
    }

    await this.categoryService.editCategory(subcategory.id, newMainCategory);

    this.currentSubcategories = await this.categoryService.getSubcategories(
      this.categoryToEdit
    );

    this.toast.present('CATEGORIES.create.success');
  }

  async deleteCategory(category: Category = this.categoryToEdit) {
    const transactionsToDelete = await this.transactionService.getTransactions({
      categoriesIds: [category.id],
    });

    const alert = await this.alertCtrl.create({
      cssClass: 'basicAlert',
      header: this.lang.getTranslation('CATEGORIES.delete-warning-header'),
      message: this.lang.getTranslation('CATEGORIES.delete-warning-message', {
        x: transactionsToDelete.length,
      }),
      buttons: [
        {
          text: this.lang.getTranslation('GENERAL.confirm'),
          handler: async () => {
            await this.categoryService.deleteCategory(category.id);

            for (const trans of transactionsToDelete) {
              await this.transactionService.removeTransaction(trans.id);
            }

            if (category.id == this.categoryToEdit.id) {
              this.router.navigate(['categories-list'], {
                queryParams: { returnTo: 'category' },
              });
              this.toast.present('CATEGORIES.delete.success');
            } else {
              this.currentSubcategories =
                await this.categoryService.getSubcategories(
                  this.categoryToEdit
                );
            }
          },
        },
      ],
    });

    await alert.present();
  }
}
