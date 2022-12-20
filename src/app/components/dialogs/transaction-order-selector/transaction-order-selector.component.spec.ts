import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { TransactionOrderSelectorComponent } from './transaction-order-selector.component';

describe('TransactionOrderSelectorComponent', () => {
  let component: TransactionOrderSelectorComponent;
  let fixture: ComponentFixture<TransactionOrderSelectorComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [TransactionOrderSelectorComponent],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(TransactionOrderSelectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
