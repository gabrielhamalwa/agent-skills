# Storybook for React Native Web

Storybook for React Native Web is a [framework](https://storybook.js.org/docs/contribute/framework.md) that makes it easy to develop and test UI components in isolation for [React Native](https://reactnative.dev/). It uses [Vite](https://vitejs.dev/) to build your components for web browsers.

In addition to React Native Web, Storybook supports on-device [React Native](https://github.com/storybookjs/react-native) development. If you're unsure what's right for you, read our [comparison](#react-native-vs-react-native-web).

## Install

To install Storybook in an existing React Native project, run this command in your project's root directory:

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

## React Native vs React Native Web

If you’re building React Native (RN) components, Storybook has two options: Native and Web.

Both options provide a catalog of your stories that hot refreshes as you edit the code in your favorite editor. However, their implementations are quite different:

- **Native** - Runs inside your React Native application. It’s high-fidelity but has a limited feature set.
- **Web** - Displays your React Native components in the browser. It’s based on Storybook for Web, which is feature-rich and mature.

### Comparison

So, which option is right for you?

**Native.** You should choose this option if you want:

- **Native features** - Your components rely on device-specific features like native modules. It runs in your actual application, in-simulator, or on-device and provides full fidelity. The web version uses `react-native-web`, which works for most components but has [limitations](https://necolas.github.io/react-native-web/docs/react-native-compatibility/).
- **Mobile publication** - You want to share your Storybook on-device as part of a test build or embedded inside your application.

**Web.** You should choose this option if you want:

- [**Sharing**](https://storybook.js.org/docs/sharing/publish-storybook.md) - Publish to the web and share with your team or publicly.
- [**Documentation**](https://storybook.js.org/docs/writing-docs.md) - Auto-generated component docs or rich markdown docs in MDX.
- [**Testing**](https://storybook.js.org/docs/writing-tests.md) - Component, visual, and a11y tests for your components.
- [**Addons**](https://storybook.js.org/addons) - 500+ addons that improve development, documentation, testing, and integration with other tools.

**Both.** It’s also possible to use both options together. This increases Storybook’s install footprint but is a good option if you want native fidelity in addition to all of the web features. Learn more below.

### Using both React Native and React Native Web

The easiest way to use React Native and React Native Web is to select the **"Both"** option when installing Storybook. This will install and create configurations for both environments, allowing you to run Storybook for both in the same project.

When you select "Both", the installation will:

1. Install and configure React Native Storybook (on-device)
2. Install and configure React Native Web Storybook (web-based)
3. Set up both configurations in your project

After installation, you'll see instructions for both environments:

- React Native Storybook will require additional manual configuration steps (replacing app entry, wrapping metro config)
- React Native Web Storybook can be started immediately using the `storybook` command

However, you can install them separately if one version is installed. You can add a React Native Web Storybook alongside an existing React Native Storybook by running the install command and selecting "React Native Web" in the setup wizard, and vice versa.

## FAQ

### How do I migrate from the React Native Web addon?

The [React Native Web addon](https://github.com/storybookjs/addon-react-native-web) was a Webpack-based precursor to the React Native Web Vite framework (i.e., `@storybook/react-native-web-vite`). If you're using the addon, you should migrate to the framework, which is faster, more stable, maintained, and better documented. To do so, follow the steps below.

Run the following command to upgrade Storybook to the latest version:

```shell
npx storybook@latest upgrade
```

```shell
pnpm dlx storybook@latest upgrade
```

```shell
yarn dlx storybook@latest upgrade
```

This framework is designed to work with Storybook 8.5 and above for the best experience. We won't be able to provide support if you're using an older Storybook version.

Install the framework and its peer dependencies:

```shell
npm install --save-dev @storybook/react-native-web-vite vite
```

```shell
pnpm add --save-dev @storybook/react-native-web-vite vite
```

```shell
yarn add --dev @storybook/react-native-web-vite vite
```

Update your `.storybook/main.js|ts` to change the framework property and remove the `@storybook/addon-react-native-web` addon:

```ts
// .storybook/main.ts

const config: StorybookConfig = {
  addons: [
    '@storybook/addon-react-native-web', // 👈 Remove the addon
  ],
  // Replace @storybook/react-webpack5 with the Vite framework
  framework: '@storybook/react-native-web-vite',
};

export default config;
```

Finally, remove the addon and similar packages (i.e., `@storybook/react-webpack5` and `@storybook/addon-react-native-web`) from your project.

## API

### Options

You can pass an options object for additional configuration if needed:

```ts title=".storybook/main.ts"

const config: StorybookConfig = {
  framework: {
    name: '@storybook/react-native-web-vite',
    options: {
      modulesToTranspile: ['my-library'], // add libraries that are not transpiled for web by default

      // You should apply babel plugins and presets here for your project that you want to apply to your code
      // for example put the reanimated preset here if you are using reanimated
      // or the nativewind jsxImportSource for example
      pluginReactOptions: {
        jsxRuntime: 'automatic' | 'classic', // default: 'automatic'
        jsxImportSource: string, // default: 'react'
        babel:{
          plugins: Array<string | [string, any]>,
          presets: Array<string | [string, any]>,
          // ... other compatible babel options
        }
        include: Array<string|RegExp>,
        exclude: Array<string|RegExp>,
        // ... other compatible @vitejs/plugin-react options
      }
    },
  },
};

export default config;
```

#### Example configuration for reanimated

```ts title=".storybook/main.ts"
const config: StorybookConfig = {
  // ... rest of config

  framework: {
    name: '@storybook/react-native-web-vite',
    options: {
      pluginReactOptions: {
        babel: {
          plugins: [
            '@babel/plugin-proposal-export-namespace-from',
            'react-native-reanimated/plugin',
          ],
        },
      },
    },
  },

  // ... rest of config
};
```

#### Example configuration for nativewind

```ts title=".storybook/main.ts"
const config: StorybookConfig = {
  // ... rest of config

  framework: {
    name: '@storybook/react-native-web-vite',
    options: {
      pluginReactOptions: {
        jsxImportSource: 'nativewind',
      },
    },
  },
};
```

#### Example configuration to transpile additional node_modules

Let's say you need to transpile a library called `my-library` that is not transpiled for web by default.
You can add it to the `modulesToTranspile` option.

```ts title=".storybook/main.ts"
const config: StorybookConfig = {
  // ... rest of config

  framework: {
    name: '@storybook/react-native-web-vite',
    options: {
      modulesToTranspile: ['my-library'],
    },
  },
};
```

#### `builder`

Type: `Record<string, any>`

Configure options for the [framework's builder](https://storybook.js.org/docs/api/main-config/main-config-framework.md#optionsbuilder). For this framework, available options can be found in the [Vite builder docs](https://storybook.js.org/docs/builders/vite.md).
