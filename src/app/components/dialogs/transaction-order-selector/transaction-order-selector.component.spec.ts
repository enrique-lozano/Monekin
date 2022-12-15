import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { TranslocoModule } from '@ngneat/transloco';
import { AppModule } from 'src/app/app.module';

import { TransactionOrderSelectorComponent } from './transaction-order-selector.component';

describe('TransactionOrderSelectorComponent', () => {
  let component: TransactionOrderSelectorComponent;
  let fixture: ComponentFixture<TransactionOrderSelectorComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [TransactionOrderSelectorComponent],
      imports: [IonicModule.forRoot(), AppModule, TranslocoModule],
    }).compileComponents();

    fixture = TestBed.createComponent(TransactionOrderSelectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
