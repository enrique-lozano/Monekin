import { TestBed } from '@angular/core/testing';
import { AppModule } from 'src/app/app.module';

import { FinanceHealthService } from './finance-health.service';

describe('FinanceHealthService', () => {
  let service: FinanceHealthService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [AppModule],
    });
    service = TestBed.inject(FinanceHealthService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
