import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';

describe('Auth and Guards', () => {
  beforeEach(() => {
    indexedDB.deleteDatabase('myStorage');
  });

  it('Visits the initial project page', () => {
    cy.visit('/');
    cy.wait(5000);
    cy.url().should('include', '/onboarding/login');
  });

  it('Denies the entry to other routes without visiting the onboarding first', () => {
    cy.visit('/tabs/tab1');
    cy.wait(5000);
    cy.url().should('include', '/onboarding/login');
  });

  it('Redirects to tabs on enter when onboarding has been passed', () => {
    cy.visit('/');

    cy.getCyElement('start-offline', { timeout: 25000 }).click({
      timeout: 26000,
    });
    cy.getCyElement('skip-slides', { timeout: 8000 }).click();

    cy.visit('/');
    cy.url().should('include', '/tabs/tab1');
  });
});

describe('Onboarding', () => {
  beforeEach(() => {
    indexedDB.deleteDatabase('myStorage');
  });

  it('Starts offline', () => {
    cy.visit('/');

    cy.getCyElement('start-offline', { timeout: 25000 }).click({
      timeout: 26000,
    });

    cy.url().should('include', '/onboarding');

    cy.get('swiper', { timeout: 8000 }).should('have.length', 1);

    cy.getCyElement('swiper-slide').each(() => {
      cy.getCyElement('next-slide').click();
    });

    cy.url().should('include', '/tabs/tab1');
  });

  it('Starts offline skipping intro', () => {
    cy.visit('/');

    cy.getCyElement('start-offline', { timeout: 25000 }).click({
      timeout: 26000,
    });
    cy.getCyElement('skip-slides', { timeout: 8000 }).click();

    cy.url().should('include', '/tabs/tab1');
  });

  it('Starts offline changing the currency', () => {
    cy.visit('/');

    cy.getCyElement('start-offline', { timeout: 25000 }).click({
      timeout: 26000,
    });

    cy.getCyElement('select-currency-button').click();

    cy.get('app-currency-selector').scrollIntoView().should('be.visible');
    cy.getCyElement('currency-item').should('have.length.above', 10);

    const currencyToSelect = ISOCorrencyCodes.AMD;

    cy.contains(currencyToSelect).click({
      waitForAnimations: true,
      animationDistanceThreshold: 1200,
    });

    cy.get('app-currency-selector').should('not.exist');

    cy.getCyElement('selected-currency-flag').should(
      'have.attr',
      'src',
      'assets/icons/currency_flags/' + currencyToSelect.toLowerCase() + '.svg'
    );

    cy.getCyElement('skip-slides').click();

    // Check that the view contains the new currency (symbol or ID)
    const runout = ['֏', currencyToSelect];
    const regex = new RegExp(`${runout.join('|')}`, 'g');
    cy.contains(regex);
  });

  /*   it('Starts offline importing data', () => {
    cy.visit('/');

    cy.getCyElement('start-offline', { timeout: 25000 }).click({
      timeout: 26000,
    });

    cy.getCyElement('next-slide').click();
    cy.getCyElement('next-slide').click();

    cy.get('input[type=file]').selectFile('tests/cypress/fixtures/v2.json', {
      force: true,
    });
  }); */
});
