/** Some variables necessary for the functionality of the app. the user cannot modify this variables (unlike what happens with the Setting interface object) */
export interface Cookies {
  modelVersion: string;
  introSeen: boolean;
  lastExportDate: Date;
}

export const defaultCookies: Cookies = {
  modelVersion: undefined,
  introSeen: false,
  lastExportDate: undefined,
};
