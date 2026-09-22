# Essentials

Storybook essentials is a set of tools that help you build, test, and document your components within Storybook. It includes the following:

- [Actions](https://storybook.js.org/docs/essentials/actions.md)
- [Backgrounds](https://storybook.js.org/docs/essentials/backgrounds.md)
- [Controls](https://storybook.js.org/docs/essentials/controls.md)
- [Highlight](https://storybook.js.org/docs/essentials/highlight.md)
- [Measure & outline](https://storybook.js.org/docs/essentials/measure-and-outline.md)
- [Toolbars & globals](https://storybook.js.org/docs/essentials/toolbars-and-globals.md)
- [Viewport](https://storybook.js.org/docs/essentials/viewport.md)

## Configuration

Essentials is “zero-config”. It comes with a recommended configuration out of the box.

Many of the features above can be configured via [parameters](https://storybook.js.org/docs/writing-stories/parameters.md). See each feature's documentation (linked above) for more details.

## Disabling features

If you need to disable any of the essential features, you can do it by changing your [`.storybook/main.js|ts`](https://storybook.js.org/docs/configure/index.md#configure-your-storybook-project) file.

For example, if you wanted to disable the [backgrounds feature](https://storybook.js.org/docs/essentials/backgrounds.md), you would apply the following change to your Storybook configuration:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    backgrounds: false, // 👈 disable the backgrounds feature
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
  features: {
    backgrounds: false, // 👈 disable the backgrounds feature
  },
});
```

You can use the following keys for each individual feature: `actions`, `backgrounds`, `controls`, `highlight`, `measure`, `outline`, `toolbars`, and `viewport`.
