import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { TranslocoModule } from '@ngneat/transloco';
import { AppModule } from 'src/app/app.module';

import { AllAccountsPage } from './all-accounts.page';

describe('AllAccountsPage', () => {
  let component: AllAccountsPage;
  let fixture: ComponentFixture<AllAccountsPage>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [AllAccountsPage],
      imports: [IonicModule.forRoot(), TranslocoModule, AppModule],
    }).compileComponents();

    fixture = TestBed.createComponent(AllAccountsPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
