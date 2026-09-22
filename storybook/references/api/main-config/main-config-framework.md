# framework

(**Required**)

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type: `FrameworkName | { name: FrameworkName; options?: FrameworkOptions }`

Configures Storybook based on a set of [framework-specific](https://storybook.js.org/docs/configure/integration/frameworks.md) settings.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const config: StorybookConfig = {
  framework: {
    name: '@storybook/your-framework',
    options: {
      legacyRootApi: true,
    },
  },
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: {
    name: '@storybook/your-framework',
    options: {
      legacyRootApi: true,
    },
  },
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
});
```

## `name`

Type: `string`

For available frameworks and their options, see their respective [documentation](https://github.com/storybookjs/storybook/tree/next/code/frameworks).

## `options`

Type: `Record<string, any>`

While many options are specific to a framework, there are some options that are shared across some frameworks, e.g. those that configure Storybook's [builder](https://storybook.js.org/docs/api/main-config/main-config-core.md#builder).

### `options.builder`

Type: `Record<string, any>`

Configures Storybook's builder, [Vite](https://storybook.js.org/docs/builders/vite.md) or [Webpack](https://storybook.js.org/docs/builders/webpack.md).
