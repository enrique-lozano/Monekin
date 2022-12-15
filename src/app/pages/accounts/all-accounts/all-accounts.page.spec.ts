import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { AllAccountsPage } from './all-accounts.page';

describe('AllAccountsPage', () => {
  let component: AllAccountsPage;
  let fixture: ComponentFixture<AllAccountsPage>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [AllAccountsPage],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(AllAccountsPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
