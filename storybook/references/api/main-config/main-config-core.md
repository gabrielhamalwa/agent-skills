# core

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type:

```ts
{
  allowedHosts?: string[] | true;
  builder?: string | { name: string; options?: BuilderOptions };
  channelOptions?: ChannelOptions;
  crossOriginIsolated?: boolean;
  disableProjectJson?: boolean;
  disableTelemetry?: boolean;
  disableWebpackDefaults?: boolean;
  disableWhatsNewNotifications?: boolean;
  enableCrashReports?: boolean;
  renderer?: RendererName;
}
```

Configures Storybook's internal features.

## `allowedHosts`

Type: `string[] | true`

Default: `[]`

Configures the allowed hosts for the Storybook dev server, used for Origin and Host header validation. Storybook's localhost and local network (or [`--host`](https://storybook.js.org/docs/api/cli-options.md#dev)) addresses are always allowed. Use this when accessing your local Storybook instance through a reverse proxy (e.g. your webapp dev server). Set to `true` to disable hostname validation (insecure).

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    allowedHosts: ['storybook.example.local'],
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  framework: '@storybook/your-framework',
  core: {
    allowedHosts: ['storybook.example.local'],
  },
});
```

## `builder`

Type:

```ts
| '@storybook/builder-vite' | '@storybook/builder-webpack5'
| {
    name: '@storybook/builder-vite' | '@storybook/builder-webpack5';
    options?: BuilderOptions;
  }
```

Configures Storybook's builder, [Vite](https://storybook.js.org/docs/builders/vite.md) or [Webpack](https://storybook.js.org/docs/builders/webpack.md).

With the new [Framework API](https://storybook.js.org/docs/api/new-frameworks.md), [`framework.options.builder`](https://storybook.js.org/docs/api/main-config/main-config-framework.md#optionsbuilder) is now the preferred way to configure the builder.

You should only use `core.builder.options` if you need to configure a builder that is not part of a framework.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  framework: '@storybook/your-framework',
  core: {
    builder: {
      name: '@storybook/builder-vite',
      options: {
        viteConfigPath: '../../../vite.config.js',
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
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  framework: '@storybook/your-framework',
  core: {
    builder: {
      name: '@storybook/builder-vite',
      options: {
        viteConfigPath: '../../../vite.config.js',
      },
    },
  },
});
```

## `channelOptions`

Type: `ChannelOptions`

```ts
{
  allowDate: boolean;
  allowRegExp: boolean;
  allowSymbol: boolean;
  allowUndefined: boolean;
  maxDepth: number;
  space: number | undefined;
}
```

Configures the channel used by Storybook to communicate between the manager and preview.

Only two properties are likely to be used:

### `channelOptions.maxDepth`

Type: `number`

Default: `3`

The maximum depth of nested objects to serialize across the channel. Larger values will be slower.

## `crossOriginIsolated`

Type: `boolean`

Enable CORS headings to run document in a "secure context". See [SharedArrayBuffer security requirements](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer#security_requirements)

This enables these headers in development-mode:

- `Cross-Origin-Opener-Policy: same-origin`
- `Cross-Origin-Embedder-Policy: require-corp`

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    crossOriginIsolated: true,
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
    crossOriginIsolated: true,
  },
});
```

## `disableProjectJson`

Type: `boolean`

Disables the generation of `project.json`, a file containing Storybook metadata

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    disableProjectJson: true,
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
    disableProjectJson: true,
  },
});
```

## `disableTelemetry`

Type: `boolean`

Disables Storybook's [telemetry collection](https://storybook.js.org/docs/configure/telemetry.md).

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    disableTelemetry: true,
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
    disableTelemetry: true,
  },
});
```

## `disableWebpackDefaults`

Type: `boolean`

Disables Storybook's default Webpack configuration.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, angular, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    disableWebpackDefaults: true,
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
    disableWebpackDefaults: true,
  },
});
```

## `disableWhatsNewNotifications`

Type: `boolean`

Disables the "What's New" notifications in the UI for new Storybook versions and ecosystem updates (e.g., [addons](https://storybook.js.org/integrations/), [content](https://storybook.js.org/blog/), etc.).

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    disableWhatsNewNotifications: true,
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
    disableWhatsNewNotifications: true,
  },
});
```

## `enableCrashReports`

Type: `boolean`

Enable crash reports to be sent to Storybook [telemetry](https://storybook.js.org/docs/configure/telemetry.md).

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  core: {
    enableCrashReports: true, // 👈 Appends the crash reports to the telemetry events
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
    enableCrashReports: true, // 👈 Appends the crash reports to the telemetry events
  },
});
```

## `renderer`

Type: `RendererName`
