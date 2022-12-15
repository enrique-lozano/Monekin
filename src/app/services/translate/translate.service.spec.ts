import { TestBed } from '@angular/core/testing';
import { TranslocoModule } from '@ngneat/transloco';
import { AppModule } from 'src/app/app.module';

import { LangService } from './translate.service';

describe('TranslateService', () => {
  let service: LangService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [TranslocoModule, AppModule],
    });
    service = TestBed.inject(LangService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
