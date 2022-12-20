import { TestBed } from '@angular/core/testing';
import { ServiceTestModule } from 'src/app/modules/testing/service-test.module';
import { IncomeOrExpense } from 'src/app/services/db/transaction/transaction.model';
import { userDataMock } from 'src/app/services/db/user-data.model';
import { UserDataService } from '../user-data.service';
import { TransactionService } from './transaction.service';

describe('TransactionService', () => {
  let service: TransactionService;
  let storage: UserDataService;

  beforeEach(async () => {
    TestBed.configureTestingModule({
      imports: [ServiceTestModule],
    });
    service = TestBed.inject(TransactionService);
    storage = TestBed.inject(UserDataService);

    await storage.setUserData(userDataMock);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should get all transactions', async () => {
    expect((await service.getTransactions()).length).toBe(4);
  });

  it('should get all transfers', async () => {
    expect(
      (await service.getTransactions({ typeOfTransaction: 'Transfer' })).length
    ).toBe(1);
  });

  it('should get transactions filtered by date', async () => {
    expect(
      (
        await service.getTransactions({
          startDate: new Date(2020, 5, 1),
          endDate: new Date(2020, 6, 0),
        })
      ).length
    ).toBe(2);
  });

  it('should get the transactions of a specific account', async () => {
    expect(
      (await service.getTransactions({ accountIds: ['acc_id2'] })).length
    ).toBe(2);
  });

  it('should get the transactions of a specific category', async () => {
    expect(
      (await service.getTransactions({ categoriesIds: ['cat_id1'] })).length
    ).toBe(2);
  });

  it('should search transactions and return coincidence in category and text', async () => {
    expect((await service.getTransactions({ queryText: 'ta' })).length).toBe(1);
  });

  it('should create a transaction with find option', async () => {
    const initialLength = (await service.getTransactions()).length;
    const initialLengthAcc = (
      await service.getTransactions({
        accountIds: [userDataMock.accounts[0].id],
      })
    ).length;

    await service.addTransaction(
      new IncomeOrExpense({
        category: {
          id: 'jkjskjss',
          icon: 'hjxshjx',
          name: 'kjsjs',
          color: 'kjsjks',
          type: 'B',
        },
        date: new Date(),
        value: 32,
        account: userDataMock.accounts[0],
      })
    );

    const endLength = (await service.getTransactions()).length;
    const endLengthAcc = (
      await service.getTransactions({
        accountIds: [userDataMock.accounts[0].id],
      })
    ).length;

    expect(initialLength).toBe(endLength - 1);
    expect(initialLengthAcc).toBe(endLengthAcc - 1);
  });

  it('should remove a transaction', async () => {
    const initialLength = (await service.getTransactions()).length;
    await service.removeTransaction((await service.getTransactions())[0].id);
    const endLength = (await service.getTransactions()).length;

    expect(initialLength).toBe(endLength + 1);
  });
});
