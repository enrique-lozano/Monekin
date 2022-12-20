import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { CurrencyExchangeSelectorComponent } from './currency-exchange-selector.component';

describe('CurrencyExchangeSelectorComponent', () => {
  let component: CurrencyExchangeSelectorComponent;
  let fixture: ComponentFixture<CurrencyExchangeSelectorComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CurrencyExchangeSelectorComponent],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(CurrencyExchangeSelectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
