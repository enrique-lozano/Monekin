import { defineConfig } from 'cypress';

export default defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },

    fixturesFolder: 'tests/cypress/fixtures',
    screenshotsFolder: 'tests/cypress/screenshots',
    videosFolder: 'tests/cypress/videos',
    downloadsFolder: 'tests/cypress/downloads',
    supportFile: 'tests/cypress/support/e2e.ts',
    specPattern: 'tests/cypress/e2e/**/*.cy.{js,jsx,ts,tsx}',
  },
});
