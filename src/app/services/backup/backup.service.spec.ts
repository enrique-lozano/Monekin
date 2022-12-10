import { TestBed } from '@angular/core/testing';
import { AppModule } from '../app.module';

import { BackupService } from './backup.service';

describe('BackupService', () => {
  let service: BackupService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [AppModule],
    });
    service = TestBed.inject(BackupService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
