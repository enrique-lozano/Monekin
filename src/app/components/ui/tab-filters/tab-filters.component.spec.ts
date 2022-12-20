import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { TabFiltersComponent } from './tab-filters.component';

describe('TabFiltersComponent', () => {
  let component: TabFiltersComponent;
  let fixture: ComponentFixture<TabFiltersComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [TabFiltersComponent],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(TabFiltersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
