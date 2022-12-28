/// <reference types="cypress" />
// ***********************************************
// This example commands.ts shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************

declare namespace Cypress {
  interface Chainable {
    getCyElement: typeof getCyElement;
  }
}

const getCyElement = (
  selector: string,
  options?: Partial<
    Cypress.Loggable & Cypress.Timeoutable & Cypress.Withinable & Cypress.Shadow
  >
) => {
  return cy.get(`[data-cy=${selector}]`, options);
};

Cypress.Commands.add('getCyElement', getCyElement);
