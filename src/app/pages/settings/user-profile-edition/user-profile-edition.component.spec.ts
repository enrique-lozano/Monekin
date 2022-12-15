import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { TranslocoModule } from '@ngneat/transloco';
import { AppModule } from 'src/app/app.module';

import { UserProfileEditionComponent } from './user-profile-edition.component';

describe('UserProfileEditionComponent', () => {
  let component: UserProfileEditionComponent;
  let fixture: ComponentFixture<UserProfileEditionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [UserProfileEditionComponent],
      imports: [IonicModule.forRoot(), AppModule, TranslocoModule],
    }).compileComponents();

    fixture = TestBed.createComponent(UserProfileEditionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
