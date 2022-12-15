import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { TranslocoModule } from '@ngneat/transloco';
import { AppModule } from 'src/app/app.module';

import { CustomDateRangeComponent } from './custom-date-range.component';

describe('CustomDateRangeComponent', () => {
  let component: CustomDateRangeComponent;
  let fixture: ComponentFixture<CustomDateRangeComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [CustomDateRangeComponent],
      imports: [IonicModule.forRoot(), AppModule, TranslocoModule],
    }).compileComponents();

    fixture = TestBed.createComponent(CustomDateRangeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
