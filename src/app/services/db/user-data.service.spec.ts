import { TestBed } from '@angular/core/testing';
import { ServiceTestModule } from 'src/app/modules/testing/service-test.module';

import { UserDataService } from './user-data.service';

describe('UserDataService', () => {
  let service: UserDataService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [ServiceTestModule],
    });
    service = TestBed.inject(UserDataService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
