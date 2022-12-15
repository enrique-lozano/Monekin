import { TestBed } from '@angular/core/testing';
import { ServiceTestModule } from 'src/app/modules/testing/service-test.module';

import { FinanceHealthService } from './finance-health.service';

describe('FinanceHealthService', () => {
  let service: FinanceHealthService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [ServiceTestModule],
    });
    service = TestBed.inject(FinanceHealthService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
