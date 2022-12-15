import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { TranslocoModule } from '@ngneat/transloco';
import { AppModule } from 'src/app/app.module';
import { ComponentsModule } from 'src/app/modules/components.module';

import { FinanceHealthPage } from './finance-health.page';

describe('FinanceHealthPage', () => {
  let component: FinanceHealthPage;
  let fixture: ComponentFixture<FinanceHealthPage>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [FinanceHealthPage],
      imports: [
        IonicModule.forRoot(),
        ComponentsModule,
        AppModule,
        TranslocoModule,
      ],
    }).compileComponents();

    fixture = TestBed.createComponent(FinanceHealthPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
