import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { TranslocoModule } from '@ngneat/transloco';
import { AppModule } from 'src/app/app.module';

import { TabFiltersComponent } from './tab-filters.component';

describe('TabFiltersComponent', () => {
  let component: TabFiltersComponent;
  let fixture: ComponentFixture<TabFiltersComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [TabFiltersComponent],
      imports: [IonicModule.forRoot(), TranslocoModule, AppModule],
    }).compileComponents();

    fixture = TestBed.createComponent(TabFiltersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
