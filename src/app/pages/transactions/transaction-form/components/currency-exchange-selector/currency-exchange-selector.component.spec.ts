import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { TranslocoModule } from '@ngneat/transloco';
import { AppModule } from 'src/app/app.module';

import { CurrencyExchangeSelectorComponent } from './currency-exchange-selector.component';

describe('CurrencyExchangeSelectorComponent', () => {
  let component: CurrencyExchangeSelectorComponent;
  let fixture: ComponentFixture<CurrencyExchangeSelectorComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CurrencyExchangeSelectorComponent],
      imports: [IonicModule.forRoot(), AppModule, TranslocoModule, FormsModule],
    }).compileComponents();

    fixture = TestBed.createComponent(CurrencyExchangeSelectorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
