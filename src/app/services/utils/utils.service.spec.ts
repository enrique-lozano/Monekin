import { TestBed } from '@angular/core/testing';
import { ServiceTestModule } from 'src/app/modules/testing/service-test.module';

import { UtilsService } from './utils.service';

describe('UtilsService', () => {
  let service: UtilsService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [ServiceTestModule],
    });
    service = TestBed.inject(UtilsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
