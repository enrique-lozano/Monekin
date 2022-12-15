import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { FinanceHealthPage } from './finance-health.page';

describe('FinanceHealthPage', () => {
  let component: FinanceHealthPage;
  let fixture: ComponentFixture<FinanceHealthPage>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [FinanceHealthPage],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(FinanceHealthPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
