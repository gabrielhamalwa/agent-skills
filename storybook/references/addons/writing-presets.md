# Write a preset addon

Storybook presets are pre-configured settings or configurations that enable developers quickly set up and customize their environment with a specific set of features, functionalities, or integrations.

## How presets work

Preset addons allow developers to compose various configuration options and plugins via APIs to integrate with Storybook and customize its behavior and functionality. Typically, presets are separated into two files, each with its specific role.

### Local presets

This type of preset allows you to encapsulate and organize configurations specific to the addon, including [builder](https://storybook.js.org/docs/builders.md) support, [Babel](https://babeljs.io/), or third-party integrations. For example:

```ts
// example-addon/src/preset.ts

export const webpackFinal = webpack as any;

export const viteFinal = vite as any;

export const babelDefault = babel as any;
```

### Root-level presets

This type of preset is user-facing and responsible for registering the addon without any additional configuration from the user by bundling Storybook-related features (e.g., [parameters](https://storybook.js.org/docs/writing-stories/parameters.md)) via the [`previewAnnotations`](https://storybook.js.org/docs/api/main-config/main-config-preview-annotations.md) and UI related features (e.g., addons) via the `managerEntries` API. For example:

```js
// example-addon/preset.js
export const previewAnnotations = [import.meta.resolve('./dist/preview')];

export const managerEntries = [import.meta.resolve('./dist/manager')];

export * from './dist/preset.js';
```

## Presets API

When writing a preset, you can access a select set of APIs to interact with the Storybook environment, including the supported builders (e.g., Webpack, Vite), the Storybook configuration, and UI. Below are the available APIs you can use when writing a preset addon.

### Babel

To customize Storybook's Babel configuration and add support for additional features, you can use the [`babelDefault`](https://storybook.js.org/docs/api/main-config/main-config-babel-default.md) API. It will apply the provided configuration ahead of any other user presets, which can be further customized by the end user via the [`babel`](https://storybook.js.org/docs/api/main-config/main-config-babel.md) configuration option. For example:

```ts
// example-addon/src/babel/babelDefault.ts

export function babelDefault(config: TransformOptions) {
  return {
    ...config,
    plugins: [
      ...config.plugins,
      [import.meta.resolve('@babel/plugin-transform-react-jsx'), {}, 'preset'],
    ],
  };
}
```

The Babel configuration is only applied to frameworks that use Babel internally. If you enable it for a framework that uses a different compiler, like [SWC](https://swc.rs/) or [esbuild](https://esbuild.github.io/), it will be ignored.

### Builders

By default, Storybook provides support for the leading industry builders, including [Webpack](https://storybook.js.org/docs/builders/webpack.md) and [Vite](https://storybook.js.org/docs/builders/vite.md). If you need additional features for any of these builders, you can use APIs to extend the builder configuration based on your specific needs.

#### Vite

If you are creating a preset and want to include Vite support, the `viteFinal` API can be used to modify the default configuration and enable additional features. For example:

```ts
// example-addon/src/vite/viteFinal.ts
export function ViteFinal(config: any, options: any = {}) {
  config.plugins.push(
    new MyCustomPlugin({
      someOption: true,
    }),
  );

  return config;
}
```

#### Webpack

To customize the Webpack configuration in Storybook to add support for additional file types, apply specific loaders, configure plugins, or make any other necessary modifications, you can use the `webpackFinal` API. Once invoked, it will extend the default Webpack configuration with the provided configuration. An example of this would be:

```ts
// example-addon/src/webpack/webpackFinal.ts

export function webpackFinal(config: WebpackConfig, options: any = {}) {
  const rules = [
    ...(config.module?.rules || []),
    {
      test: /\.custom-file$/,
      loader: fileURLToPath(import.meta.resolve(`custom-loader`)),
    },
  ];
  config.module.rules = rules;

  return config;
}
```

### ManagerEntries

If you're writing a preset that loads third-party addons, which you may not have control over, but require access to specific features or additional configuration, you can use the `managerEntries` API. For example:

```js
// example-addon/preset.js
export const managerEntries = (entry = []) => {
  return [...entry, import.meta.resolve('path-to-third-party-addon')];
};
```

### PreviewAnnotations

If you need additional settings to render stories for a preset, like [decorators](https://storybook.js.org/docs/writing-stories/decorators.md) or [parameters](https://storybook.js.org/docs/writing-stories/parameters.md), you can use the `previewAnnotations` API. For example, to apply a decorator to all stories, create a preview file that includes the decorator and make it available to the preset as follows:

```ts
// example-addon/src/preview.ts|tsx — CSF 3

const preview: ProjectAnnotations<Renderer> = {
  decorators: [CustomDecorator],
  globals: {
    [PARAM_KEY]: false,
  },
};

export default preview;
```

```ts
// example-addon/src/preview.tsx — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  decorators: [CustomDecorator],
  globals: {
    [PARAM_KEY]: false,
  },
});
```

## Advanced configuration

The presets API is designed to be flexible and allow you to customize Storybook to your specific needs, including using presets for more advanced use cases without publishing them. In such cases, you can rely on a private preset. These private presets contain configuration options meant for development purposes and not for end-users. The `.storybook/main.js|ts` file is an example of such a private preset that empowers you to modify the behavior and functionality of Storybook.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, angular, etc.

const config: StorybookConfig = {
  viteFinal: async (config, options) => {
    // Update config here
    return config;
  },
  webpackFinal: async (config, options) => {
    // Change webpack config
    return config;
  },
  babel: async (config, options) => {
    return config;
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  viteFinal: async (config, options) => {
    // Update config here
    return config;
  },
  webpackFinal: async (config, options) => {
    // Change webpack config
    return config;
  },
  babel: async (config, options) => {
    return config;
  },
});
```

### Addons

For addon consumers, the [`managerEntries`](#managerentries) API can be too technical, making it difficult to use. To make it easier to add addons to Storybook, the preset API provides the [`addons`](https://storybook.js.org/docs/api/main-config/main-config-addons.md) API, which accepts an array of addon names and will automatically load them for you. For example:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  addons: [
    // Other Storybook addons
    '@storybook/addon-a11y',
  ],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  addons: [
    // Other Storybook addons
    '@storybook/addon-a11y',
  ],
});
```

The array of values supports references to additional presets and addons that should be included in the manager. Storybook will automatically detect whether the provided value is a preset or an addon and load it accordingly.

### Entries

Entries are the place to register entry points for the preview. This feature can be utilized to create a configure-storybook preset that automatically loads all `*.stories.js` files into Storybook, eliminating the need for users to copy-paste the same configuration repeatedly.

### UI configuration

The Storybook preset API also provides access to the UI configuration, including the `head` and `body` HTML elements of the preview, configured by the [`previewHead`](https://storybook.js.org/docs/api/main-config/main-config-preview-head.md) and [`previewBody`](https://storybook.js.org/docs/api/main-config/main-config-preview-body.md) APIs. Both allow you to set up Storybook in a way that is similar to using the [`preview-head.html`](https://storybook.js.org/docs/configure/story-rendering.md#adding-to-head) and [`preview-body.html`](https://storybook.js.org/docs/configure/story-rendering.md#adding-to-body) files. These methods accept a string and return a modified version, injecting the provided content into the HTML element.

```ts
// .storybook/main.ts — Body (CSF 3)
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  previewBody: (body) => `
    ${body}
    ${
      process.env.ANALYTICS_ID ? '<script src="https://cdn.example.com/analytics.js"></script>' : ''
    }
  `,
};

export default config;
```

```ts
// .storybook/main.ts — Head (CSF 3)
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  previewHead: (head) => `
    ${head}
    <style>
      html, body {
        background: #827979;
      }
    </style>
 `,
};

export default config;
```

```ts
// .storybook/main.ts — Body (CSF Next 🧪)
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  previewBody: (body) => `
    ${body}
    ${
      process.env.ANALYTICS_ID ? '<script src="https://cdn.example.com/analytics.js"></script>' : ''
    }
  `,
});
```

```ts
// .storybook/main.ts — Head (CSF Next 🧪)
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  previewHead: (head) => `
    ${head}
    <style>
      html, body {
        background: #827979;
      }
    </style>
 `,
});
```

Additionally, if you need to customize the manager (i.e., where Storybook’s search, navigation, toolbars, and addons render), you can use the [`managerHead`](https://storybook.js.org/docs/api/main-config/main-config-manager-head.md) to modify the UI, similar to how you would do it with the `manager-head.html` file. For example:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  managerHead: (head) => `
    ${head}
    <link rel="icon" type="image/png" href="/logo192.png" sizes="192x192" />
  `,
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  managerHead: (head) => `
    ${head}
    <link rel="icon" type="image/png" href="/logo192.png" sizes="192x192" />
  `,
});
```

However, if you need, you can also customize the template used by Storybook to render the UI. To do so, you can use the `previewMainTemplate` API and provide a reference for a custom template created as a `ejs` file. For an example of how to do this, see the [template](https://github.com/storybookjs/storybook/blob/next/code/builders/builder-webpack5/templates/preview.ejs) used by the Webpack 5 builder.

## Troubleshooting

### Storybook doesn't load files in my preset

As Storybook relies on [esbuild](https://esbuild.github.io/) instead of Webpack to build the UI, presets that depend on the `managerWebpack` API to configure the manager or load additional files other than CSS or images will no longer work. We recommend removing it from your preset and adjusting your configuration to convert any additional files to JavaScript.

**Learn more about the Storybook addon ecosystem**

- [Types of addons](https://storybook.js.org/docs/addons/addon-types.md) for other types of addons
- [Writing addons](https://storybook.js.org/docs/addons/writing-addons.md) for the basics of addon development
- Presets for preset development
- [Integration catalog](https://storybook.js.org/docs/addons/integration-catalog.md) for requirements and available recipes
- [API reference](https://storybook.js.org/docs/addons/addons-api.md) to learn about the available APIs
