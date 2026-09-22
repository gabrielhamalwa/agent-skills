# babel

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type: `(config: Babel.Config, options: Options) => Babel.Config | Promise<Babel.Config>`

Customize Storybook's [Babel](https://babeljs.io/) setup.

[Addon authors](https://storybook.js.org/docs/addons/writing-presets.md#babel) should use [`babelDefault`](https://storybook.js.org/docs/api/main-config/main-config-babel-default.md) instead, which is applied to the preview config before any user presets have been applied.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../stories/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  async babel(config, { configType }) {
    if (configType === 'DEVELOPMENT') {
      // Your development configuration goes here
    }
    if (configType === 'PRODUCTION') {
      // Your production configuration goes here.
    }
    return config;
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../stories/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  async babel(config, { configType }) {
    if (configType === 'DEVELOPMENT') {
      // Your development configuration goes here
    }
    if (configType === 'PRODUCTION') {
      // Your production configuration goes here.
    }
    return config;
  },
});
```

## `Babel.Config`

The options provided by [Babel](https://babeljs.io/docs/options) are only applicable if you've enabled the [`@storybook/addon-webpack5-compiler-babel`](https://storybook.js.org/addons/@storybook/addon-webpack5-compiler-babel) addon.

If you have an existing Babel configuration file (e.g., `.babelrc`), it will be automatically detected and used by Storybook without any additional configuration required.

## `Options`

Type: `{ configType?: 'DEVELOPMENT' | 'PRODUCTION' }`

There are other options that are difficult to document here. Please introspect the type definition for more information.
