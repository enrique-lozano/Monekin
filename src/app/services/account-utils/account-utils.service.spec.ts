import { TestBed } from '@angular/core/testing';
import { ServiceTestModule } from 'src/app/modules/testing/service-test.module';
import { userDataMock } from '../db/user-data.model';
import { UserDataService } from '../db/user-data.service';

import { AccountUtilsService } from './account-utils.service';

describe('AccountUtilsService', () => {
  let service: AccountUtilsService;
  let storage: UserDataService;

  beforeEach(async () => {
    TestBed.configureTestingModule({
      imports: [ServiceTestModule],
    });
    service = TestBed.inject(AccountUtilsService);
    storage = TestBed.inject(UserDataService);

    await storage.setUserData(userDataMock);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should calculate all accounts balance', async () => {
    expect(await service.getAccountsMoney(userDataMock.accounts)).toBe(3580);
  });

  it('should calculate one account balance substracting one transfer', async () => {
    expect(await service.getAccountsMoney([userDataMock.accounts[0]])).toBe(
      1080
    );
  });

  it('should calculate one account balance and add one transfer', async () => {
    expect(await service.getAccountsMoney([userDataMock.accounts[1]])).toBe(
      2500
    );
  });
});
