# Source

The `Source` block is used to render a snippet of source code directly.

![Screenshot of Source block](../../_assets/api/doc-block-source.png)

```mdx title="ButtonDocs.mdx"

```

## Source

```js

```

<details>
<summary>Configuring with props <strong>and</strong> parameters</summary>

ℹ️ Like most blocks, the `Source` block is configured with props in MDX. Many of those props derive their default value from a corresponding [parameter](https://storybook.js.org/docs/writing-stories/parameters.md) in the block's namespace, `parameters.docs.source`.

The following `language` configurations are equivalent:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Basic: Story = {
  parameters: {
    docs: {
      source: { language: 'ts' },
    },
  },
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

export const Basic = meta.story({
  parameters: {
    docs: {
      source: { language: 'tsx' },
    },
  },
});
```

```mdx title="ButtonDocs.mdx"

```

The example above applied the parameter at the [story](https://storybook.js.org/docs/writing-stories/parameters.md#story-parameters) level, but it could also be applied at the [component](https://storybook.js.org/docs/writing-stories/parameters.md#component-parameters) (or meta) level or [project](https://storybook.js.org/docs/writing-stories/parameters.md#global-parameters) level.

</details>

### `code`

Type: `string`

Default: `parameters.docs.source.code`

Provides the source code to be rendered.

```mdx title="ButtonDocs.mdx"

```

### `dark`

Type: `boolean`

Default: `parameters.docs.source.dark`

Determines if the snippet is rendered in dark mode.

Light mode is only supported when the `Source` block is rendered independently. When rendered as part of a [`Canvas` block](https://storybook.js.org/docs/api/doc-blocks/doc-block-canvas.md)—like it is in [autodocs](https://storybook.js.org/docs/writing-docs/autodocs.md)—it will always use dark mode.

### `excludeDecorators`

Type: `boolean`

Default: `parameters.docs.source.excludeDecorators`

Determines if [decorators](https://storybook.js.org/docs/writing-stories/decorators.md) are rendered in the source code snippet.

### `language`

Type:

```ts
'jsextra' | 'jsx' | 'json' | 'yml' | 'md' | 'bash' | 'css' | 'html' | 'tsx' | 'typescript' | 'graphql'
```

Default: `parameters.docs.source.language` or `'jsx'`

Specifies the language used for syntax highlighting.

### `of`

Type: Story export

Specifies which story's source is rendered.

### `transform`

Type: `(code: string, storyContext: StoryContext) => string | Promise<string>`

Default: `parameters.docs.source.transform`

An async function to dynamically transform the source before being rendered, based on the original source and any story context necessary. The returned string is displayed as-is.
If both [`code`](#code) and `transform` are specified, `transform` will be ignored.

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g., nextjs-vite, vue3-vite, angular, sveltekit, etc.

const preview: Preview = {
  parameters: {
    docs: {
      source: {
        transform: async (source) => {
          const prettier = await import('prettier/standalone');
          const prettierPluginBabel = await import('prettier/plugins/babel');
          const prettierPluginEstree = await import('prettier/plugins/estree');

          return prettier.format(source, {
            parser: 'babel',
            plugins: [prettierPluginBabel, prettierPluginEstree],
          });
        },
      },
    },
  },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using, e.g., nextjs, nextjs-vite, react-vite, etc.

const preview = definePreview({
  parameters: {
    docs: {
      source: {
        transform: async (source) => {
          const prettier = await import('prettier/standalone');
          const prettierPluginBabel = await import('prettier/plugins/babel');
          const prettierPluginEstree = await import('prettier/plugins/estree');

          return prettier.format(source, {
            parser: 'babel',
            plugins: [prettierPluginBabel, prettierPluginEstree],
          });
        },
      },
    },
  },
});

export default preview;
```

This example shows how to use Prettier to format all source code snippets in your documentation. The transform function is applied globally through the preview configuration, ensuring consistent code formatting across all stories.

### `type`

Type: `'auto' | 'code' | 'dynamic'`

Default: `parameters.docs.source.type` or `'auto'`

Specifies how the source code is rendered.

- **auto**: Same as **dynamic**, if the story's `render` function accepts args inputs and **dynamic** is supported by the framework in use; otherwise same as **code**
- **code**: Renders the value of [`code` prop](#code), otherwise renders static story source
- **dynamic**: Renders the story source with dynamically updated arg values

Note that dynamic snippets will only work if the story uses [`args`](https://storybook.js.org/docs/writing-stories/args.md) and the [`Story` block](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md) for that story is rendered along with the `Source` block.

#### Overriding the default prop sorting behavior

For React-based frameworks, dynamic snippets are automatically sorted alphabetically by default. To override this behavior, set the `sortProps` option to `false` to preserve the original order of the props in which they were defined in the story.

```ts
// .storybook/preview.tsx — CSF 3
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

const preview = {
  parameters: {
    jsx: {
      // 👇 Preserve the order in which props are defined, instead of sorting them alphabetically
      sortProps: false,
    },
  },
} satisfies Preview;

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  parameters: {
    jsx: {
      // 👇 Preserve the order in which props are defined, instead of sorting them alphabetically
      sortProps: false,
    },
  },
});
```

Similar to other parameters, you can define it at the project level in the `.storybook/preview.*` file, component level in the meta definition (or default export), or in the story itself.
