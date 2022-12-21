/** Some variables necessary for the functionality of the app. the user cannot modify this variables (unlike what happens with the Setting interface object) */
export interface Cookies {
  /** The current DB model version. Since Monekin `v3.0.0` this version is equivalent to the version of the app.
   *
   * In this way, even if there are no changes in the data model, this parameter will be updated with each Monekin update. */
  modelVersion: string;

  /** Indicates if the user has seen the intro/onboarding */
  introSeen: boolean;

  /** Date of the last exportation of the user */
  lastExportDate: Date;
}

export const defaultCookies: Cookies = {
  modelVersion: undefined,
  introSeen: false,
  lastExportDate: undefined,
};
