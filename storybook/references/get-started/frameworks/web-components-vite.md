# Storybook for Web components with Vite

Storybook for Web components & Vite is a [framework](https://storybook.js.org/docs/contribute/framework.md) that makes it easy to develop and test UI components in isolation for applications using [Web components](https://www.webcomponents.org/introduction) built with [Vite](https://vitejs.dev/).

## Install

To install Storybook in an existing project, run this command in your project's root directory:

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

## FAQ

### How do I manually install the Web Components framework?

First, install the framework:

Then, update your `.storybook/main.js|ts` to change the framework property:

## API

### Options

You can pass an options object for additional configuration if needed:

The available options are:

#### `builder`

Type: `Record<string, any>`

Configure options for the [framework's builder](https://storybook.js.org/docs/api/main-config/main-config-framework.md#optionsbuilder). For this framework, available options can be found in the [Vite builder docs](https://storybook.js.org/docs/builders/vite.md).
