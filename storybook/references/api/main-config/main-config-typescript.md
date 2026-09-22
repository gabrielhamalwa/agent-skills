# typescript

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type:

```ts
{
  check?: boolean;
  checkOptions?: CheckOptions;
  reactDocgen?: 'react-docgen' | 'react-docgen-typescript' | false;
  reactDocgenTypescriptOptions?: ReactDocgenTypescriptOptions;
  skipCompiler?: boolean;
}
```

```ts
{
  check?: boolean;
  checkOptions?: CheckOptions;
  skipCompiler?: boolean;
}
```

Configures how Storybook handles [TypeScript files](https://storybook.js.org/docs/configure/integration/typescript.md).

## `check`

Type: `boolean`

Optionally run [fork-ts-checker-webpack-plugin](https://github.com/TypeStrong/fork-ts-checker-webpack-plugin). Note that because this uses a Webpack plugin, it is only available when using the [Webpack builder](https://storybook.js.org/docs/builders/webpack.md).

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  typescript: {
    check: true,
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
  typescript: {
    check: true,
  },
});
```

## `checkOptions`

Type: `CheckOptions`

Options to pass to `fork-ts-checker-webpack-plugin`, if [enabled](#check). See [docs for available options](https://github.com/TypeStrong/fork-ts-checker-webpack-plugin/blob/v4.1.6/README.md#options).

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-webpack5, nextjs, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  typescript: {
    check: true,
    checkOptions: {
      eslint: true,
    },
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-webpack5, nextjs, nextjs-webpack5)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  typescript: {
    check: true,
    checkOptions: {
      eslint: true,
    },
  },
});
```

## `reactDocgen`

Type: `'react-docgen' | 'react-docgen-typescript' | false`

Default:

- `false`: if `@storybook/react` is not installed
- `'react-docgen'`: if `@storybook/react` is installed

Configures which library, if any, Storybook uses to parse React components, [react-docgen](https://github.com/reactjs/react-docgen) or [react-docgen-typescript](https://github.com/styleguidist/react-docgen-typescript). Set to `false` to disable parsing React components. `react-docgen-typescript` invokes the TypeScript compiler, which makes it slow but generally accurate. `react-docgen` performs its own analysis, which is much faster but incomplete.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  typescript: {
    reactDocgen: 'react-docgen',
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
  typescript: {
    reactDocgen: 'react-docgen',
  },
});
```

## `reactDocgenTypescriptOptions`

Type: `ReactDocgenTypescriptOptions`

Configures the options to pass to `react-docgen-typescript-plugin` if `react-docgen-typescript` is enabled. See docs for available options [for Webpack projects](https://github.com/hipstersmoothie/react-docgen-typescript-plugin) or [for Vite projects](https://github.com/joshwooding/vite-plugin-react-docgen-typescript).

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  typescript: {
    reactDocgen: 'react-docgen-typescript',
    reactDocgenTypescriptOptions: {
      shouldExtractLiteralValuesFromEnum: true,
      // 👇 Default prop filter, which excludes props from node_modules
      propFilter: (prop) => (prop.parent ? !/node_modules/.test(prop.parent.fileName) : true),
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
  typescript: {
    reactDocgen: 'react-docgen-typescript',
    reactDocgenTypescriptOptions: {
      shouldExtractLiteralValuesFromEnum: true,
      // 👇 Default prop filter, which excludes props from node_modules
      propFilter: (prop) => (prop.parent ? !/node_modules/.test(prop.parent.fileName) : true),
    },
  },
});
```

## `skipCompiler`

Type: `boolean`

Disable parsing of TypeScript files through the compiler, which is used for Webpack5.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  typescript: {
    skipCompiler: true,
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
  typescript: {
    skipCompiler: true,
  },
});
```
