# Builder API

Storybook is architected to support multiple builders, including [Webpack](https://webpack.js.org/), [Vite](https://vitejs.dev/), and [ESBuild](https://esbuild.github.io/). The builder API is the set of interfaces you can use to add a new builder to Storybook.

![Storybook builders](../_assets/builders/storybook-builders.png)

## How do builders work?

In Storybook, a builder is responsible for compiling your components and stories into JS bundles that run in the browser. A builder also provides a development server for interactive development and a production mode for optimized bundles.

To opt into a builder, the user must add it as a dependency and then edit their configuration file (`.storybook/main.js`) to enable it. For example, with the Vite builder:

```shell
npm install @storybook/builder-vite --save-dev
```

```shell
pnpm add --save-dev @storybook/builder-vite
```

```shell
yarn add --dev @storybook/builder-vite
```

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs-vite, vue3-vite, etc.)

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../stories/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    builder: '@storybook/builder-vite', // 👈 The builder enabled here.
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../stories/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    builder: '@storybook/builder-vite', // 👈 The builder enabled here.
  },
});
```

## Builder API

In Storybook, every builder must implement the following [API](https://github.com/storybookjs/storybook/blob/next/code/core/src/types/modules/core-common.ts#L255-L275), exposing the following configuration options and entry points:

```ts
// core-common.ts
export interface Builder<Config, BuilderStats extends Stats = Stats> {
  getConfig: (options: Options) => Promise<Config>;
  start: (args: {
    options: Options;
    startTime: ReturnType<typeof process.hrtime>;
    router: ServerApp;
    server: HttpServer;
    channel: ServerChannel;
  }) => Promise<void | {
    stats?: BuilderStats;
    totalTime: ReturnType<typeof process.hrtime>;
    bail: (e?: Error) => Promise<void>;
  }>;
  build: (arg: {
    options: Options;
    startTime: ReturnType<typeof process.hrtime>;
  }) => Promise<void | BuilderStats>;
  bail: (e?: Error) => Promise<void>;
  corePresets?: string[];
  overridePresets?: string[];
}
```

In development mode, the `start` API call is responsible for initializing the development server to monitor the file system for changes (for example, components and stories) then execute a hot module reload in the browser.
It also provides a **bail** function to allow the running process to end gracefully, either via user input or error.

In production, the `build` API call is responsible for generating a static Storybook build, storing it by default in the `storybook-static` directory if no additional configuration is provided. The generated output should contain everything the user needs to view its Storybook by opening either the `index.html` or `iframe.html` in a browser with no other processes running.

## Implementation

Under the hood, a builder is responsible for serving/building the preview `iframe`, which has its own set of requirements. To fully support Storybook, including the [essential features](https://storybook.js.org/docs/writing-stories.md) that ship with Storybook, it must consider the following.

### Import stories

The `stories` configuration field enables story loading in Storybook. It defines an array of file globs containing the physical location of the component's stories. The builder must be able to load those files and monitor them for changes and update the UI accordingly.

### Provide configuration options

By default, Storybook's configuration is handled in a dedicated file (`storybook/main.js|ts`), giving the user the option to customize it to suit its needs. The builder should also provide its own configuration support through additional fields or some other builder-appropriate mechanism. For example:

```ts
// vite-server.ts

export async function createViteServer(options: ExtendedOptions, devServer: Server) {
  const { port, presets } = options;

  // Defines the baseline config.
  const baseConfig = await commonConfig(options, 'development');
  const defaultConfig = {
    ...baseConfig,
    server: {
      middlewareMode: true,
      hmr: {
        port,
        server: devServer,
      },
      fs: {
        strict: true,
      },
    },
    optimizeDeps: await getOptimizeDeps(baseConfig, options),
  };

  const finalConfig = await presets.apply('viteFinal', defaultConfig, options);

  const envsRaw = await presets.apply<Promise<EnvsRaw>>('env');

  // Remainder implementation
}
```

### Handle preview.js exports

The [`preview.js`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) configuration file allows users to control how the story renders in the UI. This is provided via the [decorators](https://storybook.js.org/docs/writing-stories/decorators.md) named export. When Storybook starts, it converts these named exports into internal API calls via virtual module entry, for example, `addDecorator()`. The builder must also provide a similar implementation. For example:

```ts

export async function generateIframeScriptCode(options: ExtendedOptions) {
  const { presets, frameworkPath, framework } = options;
  const frameworkImportPath = frameworkPath || `@storybook/${framework}`;

  const presetEntries = await presets.apply('config', [], options);
  const configEntries = [...presetEntries].filter(Boolean);

  const absoluteFilesToImport = (files: string[], name: string) =>
    files
      .map((el, i) => `import ${name ? `* as ${name}_${i} from ` : ''}'${transformAbsPath(el)}'`)
      .join('\n');

  const importArray = (name: string, length: number) =>
    new Array(length).fill(0).map((_, i) => `${name}_${i}`);

  const code = `
    // Ensure that the client API is initialized by the framework before any other iframe code
    // is loaded. That way our client-apis can assume the existence of the API+store
    import { configure } from '${frameworkImportPath}';

    import {
      addDecorator,
      addParameters,
      addArgTypesEnhancer,
      addArgsEnhancer,
      setGlobalRender
    } from 'storybook/preview-api';
    import { logger } from 'storybook/internal/client-logger';
    ${absoluteFilesToImport(configEntries, 'config')}
    import * as preview from '${virtualPreviewFile}';
    import { configStories } from '${virtualStoriesFile}';

    const configs = [${importArray('config', configEntries.length)
      .concat('preview.default')
      .join(',')}].filter(Boolean)

    configs.forEach(config => {
      Object.keys(config).forEach((key) => {
        const value = config[key];
        switch (key) {
          case 'args':
          case 'argTypes': {
            return logger.warn('Invalid args/argTypes in config, ignoring.', JSON.stringify(value));
          }
          case 'decorators': {
            return value.forEach((decorator) => addDecorator(decorator, false));
          }
          case 'parameters': {
            return addParameters({ ...value }, false);
          }
          case 'render': {
            return setGlobalRender(value)
          }
          case 'globals':
          case 'globalTypes': {
            const v = {};
            v[key] = value;
            return addParameters(v, false);
          }
          case 'decorateStory':
          case 'renderToCanvas': {
            return null;
          }
          default: {
            // eslint-disable-next-line prefer-template
            return console.log(key + ' was not supported :( !');
          }
        }
      });
    })
    configStories(configure);
    `.trim();
  return code;
}
```

### MDX support

[Storybook's Docs](https://storybook.js.org/docs/writing-docs.md) includes the ability to author stories/documentation in MDX using a Webpack loader. The builder must also know how to interpret MDX and invoke Storybook's special extensions. For example:

```ts
// mdx-plugin.ts

export function mdxPlugin() {
  return mdx((filename) => {
    const compilers = [];

    if (filename.endsWith('stories.mdx') || filename.endsWith('story.mdx')) {
      compilers.push(createCompiler({}));
    }
    return {
      compilers,
    };
  });
}
```

### Generate source code snippets

Storybook annotates components and stories with additional metadata related to their inputs to automatically generate interactive controls and documentation. Currently, this is provided via Webpack loaders/plugins. The builder must re-implement this to support those features.

### Generate a static build

One of Storybook's core features it's the ability to generate a static build that can be [published](https://storybook.js.org/docs/sharing/publish-storybook.md) to a web hosting service. The builder must also be able to provide a similar mechanism. For example:

```ts
// build.ts

export async function build(options: ExtendedOptions) {
  const { presets } = options;

  const baseConfig = await commonConfig(options, 'build');
  const config = {
    ...baseConfig,
    build: {
      outDir: options.outputDir,
      emptyOutDir: false,
      sourcemap: true,
    },
  };

  const finalConfig = await presets.apply('viteFinal', config, options);

  const envsRaw = await presets.apply<Promise<EnvsRaw>>('env');
  // Stringify env variables after getting `envPrefix` from the final config
  const envs = stringifyProcessEnvs(envsRaw, finalConfig.envPrefix);
  // Update `define`
  finalConfig.define = {
    ...finalConfig.define,
    ...envs,
  };

  await viteBuild(finalConfig);
}
```

### Development server integration

By default, when Storybook starts in development mode, it relies on its internal development server. The builder needs to be able to integrate with it. For example:

```ts
// server.ts

export async function createViteServer(options: ExtendedOptions, devServer: Server) {
  const { port } = options;
  // Remainder server configuration

  // Creates the server.
  return createServer({
    // The server configuration goes here
    server: {
      middlewareMode: true,
      hmr: {
        port,
        server: devServer,
      },
    },
  });
}
```

### Shutdown the development server

The builder must provide a way to stop the development server once the process terminates; this can be via user input or error. For example:

```ts
// index.ts

let server: ViteDevServer;
export async function bail(): Promise<void> {
  return server?.close();
}

export const start: ViteBuilder['start'] = async ({ options, server: devServer }) => {
  // Remainder implementation goes here
  server = await createViteServer(options as ExtendedOptions, devServer);

  return {
    bail,
    totalTime: process.hrtime(startTime),
  };
};
```

### HMR support

While running in development mode, the builder's development server must be able to reload the page once a change happens, either in a story, component, or helper function.

### More information

This area is under rapid development, and the associated documentation is still in progress and subject to change. If you are interested in creating a builder, you can learn more about implementing a builder in Storybook by checking the source code for [Vite](https://github.com/storybookjs/storybook/tree/next/code/builders/builder-vite), [Webpack](https://github.com/storybookjs/storybook/tree/next/code/builders/builder-webpack5), or Modern Web's [dev-server-storybook](https://github.com/modernweb-dev/web/blob/master/packages/dev-server-storybook/src/serve/storybookPlugin.ts). When you're ready, open an [RFC](https://storybook.js.org/docs/contribute/RFC.md) to discuss your proposal with the Storybook community and maintainers.

**Learn more about builders**

- [Vite builder](https://storybook.js.org/docs/builders/vite.md) for bundling with Vite
- [Webpack builder](https://storybook.js.org/docs/builders/webpack.md) for bundling with Webpack
- Builder API for building a Storybook builder
