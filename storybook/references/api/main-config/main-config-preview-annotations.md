# previewAnnotations

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type: `string[] | ((config: string[], options: Options) => string[] | Promise<string[]>)`

Add additional scripts to run in the story preview.

Mostly used by [frameworks](https://storybook.js.org/docs/contribute/framework.md#previewjs-example). Storybook users and [addon authors](https://storybook.js.org/docs/addons/writing-presets.md) should add scripts to [`preview.js`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) instead.

```ts
// @storybook/nextjs framework's src/preset.ts

export const previewAnnotations: StorybookConfig['previewAnnotations'] = (entry = []) => [
  ...entry,
  import.meta.resolve('@storybook/nextjs/preview'),
];
```
