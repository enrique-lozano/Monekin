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
    'enhanced-scope-enum': [2, 'always', VALID_SCOPES],
  },

  /*
   *  To allow the use of slashes, we have to implement our own parser for the scopes.
   *  This is because commitlint treats the slash as a separator. We do not plan to
   *  allow multiple scopes in one commit, and we have the scope "ux/ui", treated as
   *  one single scope. So we left only the commas as a separator.
   *
   *  Solution credits to: https://stackoverflow.com/a/69362848
   *  */

  plugins: [
    {
      rules: {
        'enhanced-scope-enum': (parsed, when = 'always', value) => {
          if (!parsed.scope) {
            return [true, ''];
          }

          // only use comma sign as seperator
          const scopeSegments = parsed.scope.split(',');

          const check = (value, enums) => {
            if (value === undefined) {
              return false;
            }
            if (!Array.isArray(enums)) {
              return false;
            }
            return enums.indexOf(value) > -1;
          };

          const negated = when === 'never';
          const result =
            (value as any).length === 0 ||
            scopeSegments.every((scope) => check(scope, value));

          return [
            negated ? !result : result,
            `scope must ${negated ? `not` : null} be one of [${(
              value as any
            ).join(', ')}]`,
          ];
        },
      },
    },
  ],
};

module.exports = Configuration;
