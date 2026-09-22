# Storybook for React with Webpack

Storybook for React & Webpack is a [framework](https://storybook.js.org/docs/contribute/framework.md) that makes it easy to develop and test UI components in isolation for [React](https://react.dev/) applications built with [Webpack](https://webpack.js.org/).

**We recommend using [`@storybook/react-vite`](https://storybook.js.org/docs/get-started/frameworks/react-vite.md)** for most React projects. The Vite-based framework is faster, more modern, and offers better support for testing features.

Use this Webpack-based framework (`@storybook/react-webpack5`) only if you need specific Webpack features not available in Vite.

## Install

To install Storybook in an existing React project, run this command in your project's root directory:

```shell
npm create storybook@latest
```

```shell
pnpm create storybook@latest
```

```shell
yarn create storybook
```

You can then get started [writing stories](https://storybook.js.org/docs/get-started/whats-a-story.md), [running tests](https://storybook.js.org/docs/writing-tests.md) and [documenting your components](https://storybook.js.org/docs/writing-docs.md). For more control over the installation process, refer to the [installation guide](https://storybook.js.org/docs/get-started/install.md).

### Requirements

## Run Storybook

To run Storybook for a particular project, run the following:

```shell
npm run storybook
```

```shell
pnpm run storybook
```

```shell
yarn storybook
```

To build Storybook, run:

```shell
npm run build-storybook
```

```shell
pnpm run build-storybook
```

```shell
yarn build-storybook
```

You will find the output in the configured `outputDir` (default is `storybook-static`).

## Configure

### Create React App (CRA)

Support for [Create React App](https://create-react-app.dev/) is handled by [`@storybook/preset-create-react-app`](https://github.com/storybookjs/presets/tree/master/packages/preset-create-react-app).

This preset enables support for all CRA features, including Sass/SCSS and TypeScript.

### Manually initialized apps

If you're working on an app that was initialized manually (i.e., without the use of CRA), ensure that your app has [react-dom](https://www.npmjs.com/package/react-dom) included as a dependency. Failing to do so can lead to unforeseen issues with Storybook and your project.

## FAQ

### How do I manually install the React Webpack framework?

First, install the framework:

```shell
npm install --save-dev @storybook/react-webpack5
```

```shell
pnpm add --save-dev @storybook/react-webpack5
```

```shell
yarn add --dev @storybook/react-webpack5
```

Next, install and register your appropriate compiler addon, depending on whether you're using SWC (recommended) or Babel:

If your project is using [Create React App](#create-react-app-cra), you can skip this step.

```sh
npx storybook@latest add @storybook/addon-webpack5-compiler-swc
```

```sh
pnpm dlx storybook@latest add @storybook/addon-webpack5-compiler-swc
```

```sh
yarn dlx storybook@latest add @storybook/addon-webpack5-compiler-swc
```

or

```sh
npx storybook@latest add @storybook/addon-webpack5-compiler-babel
```

```sh
pnpm dlx storybook@latest add @storybook/addon-webpack5-compiler-babel
```

```sh
yarn dlx storybook@latest add @storybook/addon-webpack5-compiler-babel
```

More details can be found in the [Webpack builder docs](https://storybook.js.org/docs/builders/webpack.md#compiler-support).

Finally, update your `.storybook/main.js|ts` to change the framework property:

```ts
// .storybook/main.ts — CSF 3

const config: StorybookConfig = {
  // ...
  framework: '@storybook/react-webpack5', // 👈 Add this
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  // ...
  framework: '@storybook/react-webpack5', // 👈 Add this
});
```

### How do I migrate to the React Vite framework?

Please refer to the [migration instructions for `@storybook/react-vite`](https://storybook.js.org/docs/get-started/frameworks/react-vite.md#how-do-i-migrate-from-the-react-webpack-framework).

## API

### Options

You can pass an options object for additional configuration if needed:

```ts
// .storybook/main.ts — CSF 3

const config: StorybookConfig = {
  framework: {
    name: '@storybook/react-webpack5',
    options: {
      // ...
    },
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: {
    name: '@storybook/react-webpack5',
    options: {
      // ...
    },
  },
});
```

#### `builder`

Type: `Record<string, any>`

Configure options for the [framework's builder](https://storybook.js.org/docs/api/main-config/main-config-framework.md#optionsbuilder). For this framework, available options can be found in the [Webpack builder docs](https://storybook.js.org/docs/builders/webpack.md).
