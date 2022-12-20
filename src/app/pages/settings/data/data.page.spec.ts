import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { PageTestModule } from 'src/app/modules/testing/page-test.module';

import { DataPage } from './data.page';

describe('DataPage', () => {
  let component: DataPage;
  let fixture: ComponentFixture<DataPage>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [DataPage],
      imports: [PageTestModule],
    }).compileComponents();

    fixture = TestBed.createComponent(DataPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
