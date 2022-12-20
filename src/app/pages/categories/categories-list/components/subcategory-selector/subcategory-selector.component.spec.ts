import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { SubcategorySelectorComponent } from './subcategory-selector.component';

describe('SubcategorySelectorComponent', () => {
  let component: SubcategorySelectorComponent;
  let fixture: ComponentFixture<SubcategorySelectorComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [SubcategorySelectorComponent],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(SubcategorySelectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
