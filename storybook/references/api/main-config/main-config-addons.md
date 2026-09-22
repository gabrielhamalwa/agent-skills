# addons

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type: `(string | { name: string; options?: AddonOptions })[]`

Registers the [addons](https://storybook.js.org/docs/addons/install-addons.md) loaded by Storybook.

For each addon's available options, see their respective [documentation](https://storybook.js.org/integrations).

```ts
// .storybook/main.ts — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: [
    '@storybook/addon-docs',
    {
      name: '@storybook/addon-styling-webpack',
      options: {
        rules: [
          {
            test: /\.css$/,
            use: [
              'style-loader',
              'css-loader',
              {
                loader: 'postcss-loader',
                options: {
                  implementation: fileURLToPath(import.meta.resolve('postcss')),
                },
              },
            ],
          },
        ],
      },
    },
  ],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: [
    '@storybook/addon-docs',
    {
      name: '@storybook/addon-styling-webpack',
      options: {
        rules: [
          {
            test: /\.css$/,
            use: [
              'style-loader',
              'css-loader',
              {
                loader: 'postcss-loader',
                options: {
                  implementation: fileURLToPath(import.meta.resolve('postcss')),
                },
              },
            ],
          },
        ],
      },
    },
  ],
});
```
