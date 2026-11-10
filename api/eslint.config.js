import js from '@eslint/js';
import globals from 'globals';
import tseslint from 'typescript-eslint';

export default tseslint.config(
  { ignores: ['dist/**', 'node_modules/**', 'src/generated/**', 'coverage/**'] },
  js.configs.recommended,
  ...tseslint.configs.recommended,
  {
    languageOptions: {
      globals: { ...globals.node },
    },
    rules: {
      '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_', varsIgnorePattern: '^_' }],
      '@typescript-eslint/consistent-type-imports': 'error',
      'no-console': 'error',
      eqeqeq: ['error', 'always'],
      // Business logic must never use eval-like constructs (see CLAUDE.md payroll evaluator rule).
      'no-eval': 'error',
      'no-new-func': 'error',
    },
  },
  {
    files: ['scripts/**', 'prisma/**'],
    rules: { 'no-console': 'off' },
  },
);
