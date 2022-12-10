export enum TransactionListOrderKey {
  date = 'Date',
  category = 'Category',
  quantity = 'Quantity',
}

export interface TransactionListOrder {
  orderBy: TransactionListOrderKey;
  dir: 'asc' | 'desc';
}
