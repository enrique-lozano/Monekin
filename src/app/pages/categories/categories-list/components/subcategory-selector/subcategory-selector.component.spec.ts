import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { TranslateModule } from '@ngx-translate/core';
import { AppModule } from 'src/app/app.module';

import { SubcategorySelectorComponent } from './subcategory-selector.component';

describe('SubcategorySelectorComponent', () => {
  let component: SubcategorySelectorComponent;
  let fixture: ComponentFixture<SubcategorySelectorComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [SubcategorySelectorComponent],
      imports: [IonicModule.forRoot(), AppModule, TranslateModule],
    }).compileComponents();

    fixture = TestBed.createComponent(SubcategorySelectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
