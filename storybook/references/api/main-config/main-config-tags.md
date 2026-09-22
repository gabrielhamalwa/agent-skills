# tags

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type: `{ [tagName: string]: { defaultFilterSelection?: 'include' | 'exclude' } }`

Define custom [tags](https://storybook.js.org/docs/writing-stories/tags.md) for your stories, or alter the default configuration of built-in tags.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  tags: {
    // 👇 Define a custom tag named "experimental"
    experimental: {
      defaultFilterSelection: 'exclude', // Or 'include'
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
  tags: {
    // 👇 Define a custom tag named "experimental"
    experimental: {
      defaultFilterSelection: 'exclude', // Or 'include'
    },
  },
});
```

## `[tagName]`

Type: `string`

The name of the tag. This can be any static (i.e. not created dynamically) string, either a built-in tag or a custom tag of your own design.

### `[tagName].defaultFilterSelection`

Type: `'include' | 'exclude'`

Set the default filter selection state for a tag in the Storybook sidebar. If set to `include`, stories with this tag are selected as included. If set to `exclude`, stories with this tag are selected as excluded, and must be explicitly included by selecting the tag in the sidebar filter menu. If not set, the tag has no default selection.

![Filtering by tags](../../_assets/writing-stories/tag-filter.png)
