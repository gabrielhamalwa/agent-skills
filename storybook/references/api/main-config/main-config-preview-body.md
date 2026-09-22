# previewBody

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type: `(body: string) => string`

Programmatically adjust the [preview `<body>`](https://storybook.js.org/docs/configure/story-rendering.md#adding-to-body) of your Storybook. Most often used by [addon authors](https://storybook.js.org/docs/addons/writing-presets.md#ui-configuration).

If you don't need to programmatically adjust the preview body, you can add scripts and styles to [`preview-body.html`](https://storybook.js.org/docs/configure/story-rendering.md#adding-to-body) instead.

For example, you can conditionally add scripts or styles, depending on the environment:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  previewBody: (body) => `
    ${body}
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
  previewBody: (body) => `
    ${body}
    ${
      process.env.ANALYTICS_ID ? '<script src="https://cdn.example.com/analytics.js"></script>' : ''
    }
  `,
});
```
