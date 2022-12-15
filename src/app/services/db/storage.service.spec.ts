import { TestBed } from '@angular/core/testing';
import { IonicStorageKey } from 'src/app/constants/capacitor-storage';
import { ServiceTestModule } from 'src/app/modules/testing/service-test.module';

import { StorageService } from './storage.service';

describe('BackupService', () => {
  let service: StorageService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [ServiceTestModule],
    });
    service = TestBed.inject(StorageService);
  });

  afterEach(async () => {
    await service.removeAll();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should not get non existing key', (done) => {
    service.get('non-existing-key' as any).then((item) => {
      expect(item).toBeFalsy();
      done();
    });
  });

  it('should get existing key', (done) => {
    service.get(IonicStorageKey.userData).then((item) => {
      expect(item).toBeTruthy();
      done();
    });
  });
});
