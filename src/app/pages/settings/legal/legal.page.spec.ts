import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { LegalPage } from './legal.page';

describe('LegalPage', () => {
  let component: LegalPage;
  let fixture: ComponentFixture<LegalPage>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [LegalPage],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(LegalPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
