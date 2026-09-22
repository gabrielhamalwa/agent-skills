# Controls

The `Controls` block can be used to show a dynamic table of args for a given story, as a way to document its interface, and to allow you to change the args for a (separately) rendered story (via the [`Story`](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md) or [`Canvas`](https://storybook.js.org/docs/api/doc-blocks/doc-block-canvas.md) blocks).

If you’re looking for a static table that shows a component's arg types with no controls, see the [`ArgTypes`](https://storybook.js.org/docs/api/doc-blocks/doc-block-argtypes.md) block instead.

![Screenshot of Controls block](../../_assets/api/doc-block-controls.png)

```mdx title="ButtonDocs.mdx"

```

The Controls doc block will only have functioning UI controls if you haven't turned off inline stories with the [`inline`](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md#inline) configuration option.

## Controls

```js

```

<details>
<summary>Configuring with props <strong>and</strong> parameters</summary>

ℹ️ Like most blocks, the `Controls` block is configured with props in MDX. Many of those props derive their default value from a corresponding [parameter](https://storybook.js.org/docs/writing-stories/parameters.md) in the block's namespace, `parameters.docs.controls`.

The following `exclude` configurations are equivalent:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
  parameters: {
    docs: {
      controls: { exclude: ['style'] },
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
      controls: { exclude: ['style'] },
    },
  },
});
```

```mdx title="ButtonDocs.mdx"

```

The example above applied the parameter at the [component](https://storybook.js.org/docs/writing-stories/parameters.md#component-parameters) (or meta) level, but it could also be applied at the [project](https://storybook.js.org/docs/writing-stories/parameters.md#global-parameters) or [story](https://storybook.js.org/docs/writing-stories/parameters.md#story-parameters) level.

</details>

This API configures the `Controls` blocks used within docs pages. To configure the Controls panel, see the [feature documentation](https://storybook.js.org/docs/essentials/controls.md). To configure individual controls, specify [argTypes](https://storybook.js.org/docs/api/arg-types.md#control) for each.

### `exclude`

Type: `string[] | RegExp`

Default: `parameters.docs.controls.exclude`

Specifies which controls to exclude from the args table. Any controls whose names match the regex or are part of the array will be left out.

### `include`

Type: `string[] | RegExp`

Default: `parameters.docs.controls.include`

Specifies which controls to include in the args table. Any controls whose names don't match the regex or are not part of the array will be left out.

### `of`

Type: Story export or CSF file exports

Specifies which story to get the controls from. If a CSF file exports is provided, it will use the primary (first) story in the file.

### `sort`

Type: `'none' | 'alpha' | 'requiredFirst'`

Default: `parameters.docs.controls.sort` or `'none'`

Specifies how the controls are sorted.

- **none**: Unsorted, displayed in the same order the controls are processed in
- **alpha**: Sorted alphabetically, by the arg type's name
- **requiredFirst**: Same as `alpha`, with any required controls displayed first
