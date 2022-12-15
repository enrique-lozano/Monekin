import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { UserProfileEditionComponent } from './user-profile-edition.component';

describe('UserProfileEditionComponent', () => {
  let component: UserProfileEditionComponent;
  let fixture: ComponentFixture<UserProfileEditionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [UserProfileEditionComponent],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(UserProfileEditionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
