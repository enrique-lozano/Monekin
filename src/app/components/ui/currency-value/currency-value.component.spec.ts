import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { CurrencyValueComponent } from './currency-value.component';

describe('CurrencyValueComponent', () => {
  let component: CurrencyValueComponent;
  let fixture: ComponentFixture<CurrencyValueComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CurrencyValueComponent],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(CurrencyValueComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
