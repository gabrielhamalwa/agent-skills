# Webpack

Storybook Webpack builder is the historical builder for Storybook. This builder enables you to create a seamless development and testing experience for your components and provides an efficient way to develop UI components in isolation allowing you to leverage your existing Webpack configuration with Storybook.

## Configure

By default, Storybook provides zero-config support for Webpack and automatically sets up a baseline configuration created to work with the most common use cases. However, you can extend your Storybook configuration file (i.e., `.storybook/main.js|ts`) and provide additional options to improve your Storybook's performance or customize it to your needs. Listed below are the available options and examples of how to use them.

| Option            | Description                                                                                                                                                                                        |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `lazyCompilation` | Enables Webpack's experimental [`lazy compilation`](https://webpack.js.org/configuration/experiments/#experimentslazycompilation)<br />`core: { builder: { options: { lazyCompilation: true } } }` |
| `fsCache`         | Configures Webpack's filesystem [caching](https://webpack.js.org/configuration/cache/#cachetype) feature<br /> `core: { builder: { options: { fsCache: true } } }`                                 |

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, angular, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    builder: {
      name: '@storybook/builder-webpack5',
      options: {
        fsCache: true,
        lazyCompilation: true,
      },
    },
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    builder: {
      name: '@storybook/builder-webpack5',
      options: {
        fsCache: true,
        lazyCompilation: true,
      },
    },
  },
});
```

### Override the default configuration

Storybook's Webpack configuration is based on [Webpack 5](https://webpack.js.org/), allowing it to be extended to fit your project's needs. If you need to add a loader or a plugin, you can provide the `webpackFinal` configuration element in your [`.storybook/main.js|ts`](https://storybook.js.org/docs/configure/index.md#configure-your-storybook-project) file. The configuration element should export a function that receives the baseline configuration as the first argument and Storybook's options object as the second argument. For example:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, angular, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config, { configType }) => {
    if (configType === 'DEVELOPMENT') {
      // Modify config for development
    }
    if (configType === 'PRODUCTION') {
      // Modify config for production
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
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config, { configType }) => {
    if (configType === 'DEVELOPMENT') {
      // Modify config for development
    }
    if (configType === 'PRODUCTION') {
      // Modify config for production
    }
    return config;
  },
});
```

When Storybook starts, it automatically merges the configuration into its own. However, when providing the `webpackFinal` configuration element, you're responsible for merging the configuration yourself. We recommend that you handle the changes to the `config` object responsibly, preserving both the `entry` and `output` properties.

#### Working with Webpack plugins

Another way to customize your Storybook configuration is to add a custom plugin or loader to help with code optimization, asset management, or other tasks. Nevertheless, since Storybook relies on the `HtmlWebpackPlugin` to generate the preview page, we recommend that you append the changes to the `config.plugins` array rather than overwriting it. For example:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, angular, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config) => {
    config.plugins.push(/* ... */);
    return config;
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, etc.

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config) => {
    config.plugins.push(/* ... */);
    return config;
  },
});
```

Additionally, when working with Webpack loaders that don't explicitly include specific file extensions (i.e., via the `test` property), you should `exclude` the `.ejs` file extension for that loader.

### Import a custom Webpack configuration

If you already have an existing Webpack configuration file that you need to reuse with Storybook, you can import it and merge it into the default configuration. For example:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, angular, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config) => {
    return {
      ...config,
      module: { ...config.module, rules: [...config.module.rules, ...custom.module.rules] },
    };
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config) => {
    return {
      ...config,
      module: { ...config.module, rules: [...config.module.rules, ...custom.module.rules] },
    };
  },
});
```

Projects scaffolded based on generators may require that you import their specific Webpack configuration files. We suggest reading your generator's documentation for more information.

### Debug Webpack configuration

If you intend to debug the Webpack configuration used by Storybook, you can use the Storybook CLI to help you. If you're running in [development mode](https://storybook.js.org/docs/api/cli-options.md#dev), you can use the following command:

```shell
npm run storybook -- --debug-webpack
```

```shell
yarn storybook --debug-webpack
```

Additionally, if you're generating a [static build](https://storybook.js.org/docs/api/cli-options.md#build) of your Storybook, you can use the following command:

```shell
npm run build-storybook -- --debug-webpack
```

```shell
yarn build-storybook --debug-webpack
```

## Compiler support

Storybook takes a compiler-agnostic approach to bundling. This allows you to bring your own application bundler (e.g., [Babel](https://babeljs.io/), [SWC](https://swc.rs/)) and ensures compatibility within the vast ecosystem of Webpack 5-based projects.

### SWC

If your project is built using [SWC](https://swc.rs/), use the [`@storybook/addon-webpack5-compiler-swc`](https://storybook.js.org/addons/@storybook/addon-webpack5-compiler-swc) addon. This addon increases ecosystem compatibility with Webpack 5 projects while maintaining high performance. Run the following command to set up the addon automatically:

```sh
npx storybook@latest add @storybook/addon-webpack5-compiler-swc
```

```sh
pnpm dlx storybook@latest add @storybook/addon-webpack5-compiler-swc
```

```sh
yarn dlx storybook@latest add @storybook/addon-webpack5-compiler-swc
```

Additional options can be provided to customize the SWC configuration. See the [SWC API documentation](https://storybook.js.org/docs/api/main-config/main-config-swc.md) for more information.

When enabled, this addon adjusts the Webpack configuration to use the [`swc-loader`](https://swc.rs/docs/usage/swc-loader) for JavaScript and TypeScript files. Additionally, it will detect and use your project's SWC configuration.

### Babel

If you're working with a project that relies on Babel's tooling to provide support for specific features, including TypeScript or other modern JavaScript features, you can use the [`@storybook/addon-webpack5-compiler-babel`](https://storybook.js.org/addons/@storybook/addon-webpack5-compiler-babel) addon to allow you to include them in your Storybook to ensure compatibility with your project. Run the following command to set up the addon automatically:

```sh
npx storybook@latest add @storybook/addon-webpack5-compiler-babel
```

```sh
pnpm dlx storybook@latest add @storybook/addon-webpack5-compiler-babel
```

```sh
yarn dlx storybook@latest add @storybook/addon-webpack5-compiler-babel
```

Additional options can be provided to customize the Babel configuration. See the [`babel` API documentation](https://storybook.js.org/docs/api/main-config/main-config-babel.md) for more information, or if you're working on an addon, the [`babelDefault` documentation](https://storybook.js.org/docs/api/main-config/main-config-babel-default.md) for more information.

When enabled, the addon will adjust the Webpack configuration to use the [`babel-loader`](https://webpack.js.org/loaders/babel-loader/) as the default loader for JavaScript and TypeScript files. Additionally, it will detect and use your project's Babel configuration.

## Troubleshooting

### TypeScript modules are not resolved within Storybook

Storybook's default Webpack configuration provides support for most project setups without the need for any additional configuration. Nevertheless, depending on your project configuration, or the framework of choice, you may run into issues with TypeScript modules not being resolved within Storybook when aliased from your [`tsconfig` file](https://www.typescriptlang.org/tsconfig). If you encounter this issue, you can use [`tsconfig-paths-webpack-plugin`](https://github.com/dividab/tsconfig-paths-webpack-plugin#tsconfig-paths-webpack-plugin) while [extending Storybook's Webpack config](#override-the-default-configuration) as follows:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, angular, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config) => {
    if (config.resolve) {
      config.resolve.plugins = [
        ...(config.resolve.plugins || []),
        new TsconfigPathsPlugin({
          extensions: config.resolve.extensions,
        }),
      ];
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
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config) => {
    if (config.resolve) {
      config.resolve.plugins = [
        ...(config.resolve.plugins || []),
        new TsconfigPathsPlugin({
          extensions: config.resolve.extensions,
        }),
      ];
    }
    return config;
  },
});
```

However, if you're working with a framework that provides a default aliasing configuration (e.g., Next.js, Nuxt) and you want to configure Storybook to use the same aliases, you may not need to install any additional packages. Instead, you can extend the default configuration of Storybook to use the same aliases provided by the framework. For example, to set up an alias for the `@` import path, you can add the following to your `.storybook/main.js|ts` file:

```ts
// .storybook/main.ts — CSF 3

// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, angular, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|ts|tsx)'],
  webpackFinal: async (config) => {
    if (config.resolve) {
      config.resolve.alias = {
        ...config.resolve.alias,
        '@': path.resolve(process.cwd(), 'src'),
      };
    }
    return config;
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, etc.

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|ts|tsx)'],
  webpackFinal: async (config) => {
    if (config.resolve) {
      config.resolve.alias = {
        ...config.resolve.alias,
        '@': path.resolve(process.cwd(), 'src'),
      };
    }
    return config;
  },
});
```

### Pre-bundled assets do not show in the Storybook UI

As Storybook relies on [esbuild](https://esbuild.github.io/) to build its internal manager, support for bundling assets with the `managerWebpack` will no longer have an impact on the Storybook UI. We recommend removing existing `managerWebpack` configuration elements from your Storybook configuration file and bundling assets other than images or CSS into JavaScript beforehand.

### @babel/preset-env: The 'bugfixes' option has been removed

If you use Babel 8, you may receive the following error when running Storybook:

```
@babel/preset-env: The
│  'bugfixes' option has been removed, and now bugfix plugins are always
│  enabled. Please remove it from your config.
```

Storybook attempts to detect when you use Babel 8 and to automatically remove the `bugfixes` option from your configuration. If version detection fails, you may set the `babelRemoveBugfixes` feature flag in your Storybook configuration file to forcefully disable the `bugfixes` option:

```ts
// .storybook/main.ts — CSF 3

// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, angular, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|ts|tsx)'],
  features: {
    babelRemoveBugfixes: true,
  },
};

export default config;
```

### Storybook doesn't run with Webpack 4

Support for Webpack 4 has been removed and is no longer being maintained. If you're upgrading your Storybook, it will automatically use Webpack 5 and attempt to migrate your configuration. However, if you're working with a custom Webpack configuration, you may need to update it to work with Webpack 5. The migration process is necessary to ensure that your project runs smoothly with the latest version of Storybook. You can follow the instructions provided on the Webpack [website](https://webpack.js.org/migrate/5/) to update your configuration.

**Learn more about builders**

- [Vite builder](https://storybook.js.org/docs/builders/vite.md) for bundling with Vite
- Webpack builder for bundling with Webpack
- [Builder API](https://storybook.js.org/docs/builders/builder-api.md) for building a Storybook builder
