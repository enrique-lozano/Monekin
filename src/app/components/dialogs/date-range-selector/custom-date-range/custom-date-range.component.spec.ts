import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { CustomDateRangeComponent } from './custom-date-range.component';

describe('CustomDateRangeComponent', () => {
  let component: CustomDateRangeComponent;
  let fixture: ComponentFixture<CustomDateRangeComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CustomDateRangeComponent],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(CustomDateRangeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
