import { TestBed } from '@angular/core/testing';

// Ionic Storage:
import { ServiceTestModule } from 'src/app/modules/testing/service-test.module';

// Translate imports
import { CookieService } from './cookie.service';

describe('CookieService', () => {
  let service: CookieService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [ServiceTestModule],
    });
    service = TestBed.inject(CookieService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
