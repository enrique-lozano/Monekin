import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { TranslateModule } from '@ngx-translate/core';
import { AppModule } from 'src/app/app.module';
import { StorageService } from 'src/app/services/db/storage.service';

import { GeneralPage } from './general.page';

describe('GeneralPage', () => {
  let component: GeneralPage;
  let fixture: ComponentFixture<GeneralPage>;
  let storage: StorageService;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [GeneralPage],
      imports: [IonicModule.forRoot(), FormsModule, AppModule, TranslateModule],
    }).compileComponents();

    fixture = TestBed.createComponent(GeneralPage);
    storage = TestBed.inject(StorageService);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', async () => {
    await storage.init();
    expect(component).toBeTruthy();
  });
});
