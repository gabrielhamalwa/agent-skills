# previewHead

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type: `(head: string) => string`

Programmatically adjust the [preview `<head>`](https://storybook.js.org/docs/configure/story-rendering.md#adding-to-head) of your Storybook. Most often used by [addon authors](https://storybook.js.org/docs/addons/writing-presets.md#ui-configuration).

If you don't need to programmatically adjust the preview head, you can add scripts and styles to [`preview-head.html`](https://storybook.js.org/docs/configure/story-rendering.md#adding-to-head) instead.

For example, you can conditionally add scripts or styles, depending on the environment:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  previewHead: (head) => `
    ${head}
    ${
      process.env.ANALYTICS_ID ? '<script src="https://cdn.example.com/analytics.js"></script>' : ''
    }
  `,
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  previewHead: (head) => `
    ${head}
    ${
      process.env.ANALYTICS_ID ? '<script src="https://cdn.example.com/analytics.js"></script>' : ''
    }
  `,
});
```
