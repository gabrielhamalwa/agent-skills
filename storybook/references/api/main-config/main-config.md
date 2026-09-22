# Main configuration

The main configuration defines a Storybook project's behavior, including the location of stories, addons to use, feature flags, and other project-specific settings.

## The main configuration file: `main.js` or `main.ts`

This file must be valid ESM. In other words, it must use `import` instead of `require`, and neither `__dirname` nor `__filename` are available.

This configuration is defined in `.storybook/main.js|ts`, which is located relative to the root of your project.

A typical Storybook configuration file looks like this:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  // Required
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  // Optional
  addons: ['@storybook/addon-docs'],
  staticDirs: ['../public'],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  // Required
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  // Optional
  addons: ['@storybook/addon-docs'],
  staticDirs: ['../public'],
});
```

## config

An object to configure Storybook containing the following properties:

- [`framework`](https://storybook.js.org/docs/api/main-config/main-config-framework.md) (Required)
- [`stories`](https://storybook.js.org/docs/api/main-config/main-config-stories.md) (Required)
- [`addons`](https://storybook.js.org/docs/api/main-config/main-config-addons.md)
- [`babel`](https://storybook.js.org/docs/api/main-config/main-config-babel.md)
- [`babelDefault`](https://storybook.js.org/docs/api/main-config/main-config-babel-default.md)
- [`build`](https://storybook.js.org/docs/api/main-config/main-config-build.md)
- [`core`](https://storybook.js.org/docs/api/main-config/main-config-core.md)
- [`docs`](https://storybook.js.org/docs/api/main-config/main-config-docs.md)
- [`env`](https://storybook.js.org/docs/api/main-config/main-config-env.md)
- [`features`](https://storybook.js.org/docs/api/main-config/main-config-features.md)
- [`indexers`](https://storybook.js.org/docs/api/main-config/main-config-indexers.md) (⚠️ Experimental)
- [`logLevel`](https://storybook.js.org/docs/api/main-config/main-config-log-level.md)
- [`managerHead`](https://storybook.js.org/docs/api/main-config/main-config-manager-head.md)
- [`previewAnnotations`](https://storybook.js.org/docs/api/main-config/main-config-preview-annotations.md)
- [`previewBody`](https://storybook.js.org/docs/api/main-config/main-config-preview-body.md)
- [`previewHead`](https://storybook.js.org/docs/api/main-config/main-config-preview-head.md)
- [`refs`](https://storybook.js.org/docs/api/main-config/main-config-refs.md)
- [`staticDirs`](https://storybook.js.org/docs/api/main-config/main-config-static-dirs.md)
- [`swc`](https://storybook.js.org/docs/api/main-config/main-config-swc.md)
- [`tags`](https://storybook.js.org/docs/api/main-config/main-config-tags.md)
- [`typescript`](https://storybook.js.org/docs/api/main-config/main-config-typescript.md)
- [`viteFinal`](https://storybook.js.org/docs/api/main-config/main-config-vite-final.md)
- [`webpackFinal`](https://storybook.js.org/docs/api/main-config/main-config-webpack-final.md)
