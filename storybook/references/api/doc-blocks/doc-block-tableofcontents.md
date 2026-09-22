# TableOfContents

The `TableOfContents` block renders a table of contents for the current documentation page, allowing users to navigate between sections quickly. It appears as a fixed sidebar on the right side of the documentation page and is hidden on smaller screens (below 768px).

The table of contents is enabled and configured via the `docs.toc` [parameter](https://storybook.js.org/docs/writing-stories/parameters.md) rather than being added directly to MDX files. When enabled, it is automatically rendered alongside the page content by [Storybook's docs container](https://storybook.js.org/docs/api/doc-blocks/doc-block-meta.md).

For a step-by-step guide on enabling and customizing the table of contents, see the [Generate a table of contents](https://storybook.js.org/docs/writing-docs/autodocs.md#generate-a-table-of-contents) section in the Autodocs documentation.

## Enabling the table of contents

Enable the table of contents globally in your Storybook preview configuration:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  parameters: {
    docs: {
      toc: true, // 👈 Enables the table of contents
    },
  },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  addons: [addonDocs()],
  parameters: {
    docs: {
      toc: true, // 👈 Enables the table of contents
    },
  },
});
```

You can also enable or disable it for specific components in their stories file:

```ts
// MyComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: MyComponent,
  tags: ['autodocs'],
  parameters: {
    docs: {
      toc: {
        disable: true, // 👈 Disables the table of contents
      },
    },
  },
} satisfies Meta<typeof MyComponent>;

export default meta;
```

```ts
// MyComponent.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: MyComponent,
  tags: ['autodocs'],
  parameters: {
    docs: {
      toc: {
        disable: true, // 👈 Disables the table of contents
      },
    },
  },
});
```

## `toc` parameter options

The `docs.toc` parameter accepts either `true` (to enable with defaults) or an object with the following properties:

### `contentsSelector`

Type: `string`

Default: `'.sbdocs-content'`

CSS selector for the container to search for headings. Use this if you have a custom docs page layout.

### `disable`

Type: `boolean`

Default: `false`

When `true`, it hides the table of contents for the documentation page. A hidden (empty) container is still rendered to preserve the page layout.

### `headingSelector`

Type: `string`

Default: `'h3'`

CSS selector that defines which heading levels to include in the table of contents. For example, use `'h1, h2, h3'` to include the top three heading levels.

### `ignoreSelector`

Type: `string`

Default: `'.docs-story *, .skip-toc'`

CSS selector for headings to exclude from the table of contents. By default, headings inside story blocks are excluded. To also exclude a specific heading, add the `skip-toc` class to it.

### `title`

Type: `string | null | ReactElement`

Default: `'Table of contents'` (visually hidden)

Text or element to display as the title above the table of contents. Set to `null` to render no title. When a string is provided, it is rendered as a visually hidden `<h2>` by default; pass a non-empty string to make it visible.

### `unsafeTocbotOptions`

Type: `object`

Provides additional configuration options passed directly to the underlying [`Tocbot`](https://tscanlin.github.io/tocbot/) library. These options are not guaranteed to remain available in future versions of Storybook.

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  parameters: {
    docs: {
      toc: {
        contentsSelector: '.sbdocs-content',
        headingSelector: 'h1, h2, h3',
        ignoreSelector: '#primary',
        title: 'Table of Contents',
        disable: false,
        unsafeTocbotOptions: {
          orderedList: false,
        },
      },
    },
  },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  addons: [addonDocs()],
  parameters: {
    docs: {
      toc: {
        contentsSelector: '.sbdocs-content',
        headingSelector: 'h1, h2, h3',
        ignoreSelector: '#primary',
        title: 'Table of Contents',
        disable: false,
        unsafeTocbotOptions: {
          orderedList: false,
        },
      },
    },
  },
});
```
