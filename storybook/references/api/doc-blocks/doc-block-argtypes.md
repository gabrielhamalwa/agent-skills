# ArgTypes

The `ArgTypes` block can be used to show a static table of [arg types](https://storybook.js.org/docs/api/arg-types.md) for a given component, as a way to document its interface.

If you’re looking for a dynamic table that shows a story’s current arg values for a story and supports users changing them, see the [`Controls`](https://storybook.js.org/docs/api/doc-blocks/doc-block-controls.md) block instead.

![Screenshot of ArgTypes block](../../_assets/api/doc-block-argtypes.png)

```mdx title="ButtonDocs.mdx"

```

## ArgTypes

```js

```

<details>
<summary>Configuring with props <strong>and</strong> parameters</summary>

ℹ️ Like most blocks, the `ArgTypes` block is configured with props in MDX. Many of those props derive their default value from a corresponding [parameter](https://storybook.js.org/docs/writing-stories/parameters.md) in the block's namespace, `parameters.docs.argTypes`.

The following `exclude` configurations are equivalent:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
  parameters: {
    docs: {
      argTypes: { exclude: ['style'] },
    },
  },
} satisfies Meta<typeof Button>;

export default meta;
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
  parameters: {
    docs: {
      argTypes: { exclude: ['style'] },
    },
  },
});
```

```mdx title="ButtonDocs.mdx"

```

The example above applied the parameter at the [component](https://storybook.js.org/docs/writing-stories/parameters.md#component-parameters) (or meta) level, but it could also be applied at the [project](https://storybook.js.org/docs/writing-stories/parameters.md#global-parameters) or [story](https://storybook.js.org/docs/writing-stories/parameters.md#story-parameters) level.

</details>

### `exclude`

Type: `string[] | RegExp`

Default: `parameters.docs.argTypes.exclude`

Specifies which arg types to exclude from the args table. Any arg types whose names match the regex or are part of the array will be left out.

### `include`

Type: `string[] | RegExp`

Default: `parameters.docs.argTypes.include`

Specifies which arg types to include in the args table. Any arg types whose names don’t match the regex or are not part of the array will be left out.

### `of`

Type: Story export or CSF file exports

Specifies which story to get the arg types from. If a CSF file exports is provided, it will use the primary (first) story in the file.

### `sort`

Type: `'none' | 'alpha' | 'requiredFirst'`

Default: `parameters.docs.argTypes.sort` or `'none'`

Specifies how the arg types are sorted.

- **none**: Unsorted, displayed in the same order the arg types are processed in
- **alpha**: Sorted alphabetically, by the arg type's name
- **requiredFirst**: Same as `alpha`, with any required arg types displayed first
