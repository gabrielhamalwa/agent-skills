# swc

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type: `(config: swc.Options, options: Options) => swc.Options | Promise<swc.Options>`

Customize Storybook's [SWC](https://swc.rs/) setup for Webpack-based projects enabled via the [`@storybook/addon-webpack5-compiler-swc`](https://storybook.js.org/addons/@storybook/addon-webpack5-compiler-swc) addon based on the supported [frameworks](https://storybook.js.org/docs/configure/integration/frameworks.md), except Angular, Create React App, Ember.js and Next.js.

```ts
// .storybook/main.ts — CSF 3

// Replace your-framework with the webpack-based framework you are using (e.g., react-webpack5)

const config: StorybookConfig = {
  framework: {
    name: '@storybook/your-framework',
    options: {},
  },
  swc: (config: Options, options): Options => {
    return {
      ...config,
      // Apply your custom SWC configuration
    };
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: {
    name: '@storybook/your-framework',
    options: {},
  },
  swc: (config: Options, options): Options => {
    return {
      ...config,
      // Apply your custom SWC configuration
    };
  },
});
```

## `SWC.Options`

The options provided by [SWC](https://swc.rs/) are only applicable if you've enabled the [`@storybook/addon-webpack5-compiler-swc`](https://storybook.js.org/addons/@storybook/addon-webpack5-compiler-swc) addon.

## Options

Type: `{ configType?: 'DEVELOPMENT' | 'PRODUCTION' }`

There are other options that are difficult to document here. Please introspect the type definition for more information.
