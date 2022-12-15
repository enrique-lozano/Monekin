import { TestBed } from '@angular/core/testing';
import { AccountService } from './account.service';

import { ServiceTestModule } from 'src/app/modules/testing/service-test.module';

describe('AccountService', () => {
  let service: AccountService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [ServiceTestModule],
    });
    service = TestBed.inject(AccountService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
