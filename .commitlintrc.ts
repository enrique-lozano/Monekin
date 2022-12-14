import type { UserConfig } from '@commitlint/types';
import { VALID_SCOPES } from './docs/VALID_COMMIT_SCOPES';

// See https://commitlint.js.org/#/reference-configuration for more info about the commitlint config

const Configuration: UserConfig = {
  // Resolve and load @commitlint/config-conventional from node_modules. Referenced packages must be installed
  extends: ['@commitlint/config-conventional'],

  // Any rules defined here will override rules from the extended config
  rules: {
    'subject-case': [2, 'always', ['sentencecase']],
    'type-enum': [
      2,
      'always',
      ['build', 'ci', 'docs', 'feat', 'fix', 'perf', 'refactor', 'test'],
    ],
    'scope-enum': [2, 'always', VALID_SCOPES],
  },
};

module.exports = Configuration;
