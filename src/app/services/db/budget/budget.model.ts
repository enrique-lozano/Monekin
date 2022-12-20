export interface Budget {
  /** Title of the budget and its identificator. For instance, this name is unique (the user can not have another budget with the same name)  */ name: string;

  /** Categories that will be taken into account when calculating how the budget is going
   *
   * As of v2, this is an array of ids, previously it was an array of names */
  categories: string[] | 'all';

  /** Accounts that will be taken into account when calculating how the budget is going
   *
   * As of v2, this is an array of ids, previously it was an array of names */
  accounts: string[] | 'all';

  /** Maximum value that the budget takes. It will always be in the user's preferred currency */
  limit: number;

  repeat: 'week' | 'month' | 'year' | 'no';

  // Only in case repeat is "no":
  startDate?: Date;
  endDate?: Date;
}

export class Budget implements Budget {
  constructor(obj: Budget) {
    Object.assign(this, obj);

    if (this.endDate) this.endDate = new Date(this.endDate);
    if (this.startDate) this.startDate = new Date(this.startDate);
  }
}
