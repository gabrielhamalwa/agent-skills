# Canvas

The `Canvas` block is a wrapper around a [`Story`](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md), featuring a toolbar that allows you to interact with its content while automatically providing the required [`Source`](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md) snippets.

![Screenshot of Canvas block](../../_assets/api/doc-block-canvas.png)

When using the Canvas block in MDX, it references a story with the `of` prop:

```mdx title="ButtonDocs.mdx"

```

In previous versions of Storybook it was possible to pass in arbitrary components as children to `Canvas`. That is deprecated and the `Canvas` block now only supports a single story.

## Canvas

```js

```

<details>
<summary>Configuring with props <strong>and</strong> parameters</summary>

ℹ️ Like most blocks, the `Canvas` block is configured with props in MDX. Many of those props derive their default value from a corresponding [parameter](https://storybook.js.org/docs/writing-stories/parameters.md) in the block's namespace, `parameters.docs.canvas`.

The following `sourceState` configurations are equivalent:

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
      canvas: { sourceState: 'shown' },
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
      canvas: { sourceState: 'shown' },
    },
  },
});
```

```mdx title="ButtonDocs.mdx"

```

The example above applied the parameter at the [story](https://storybook.js.org/docs/writing-stories/parameters.md#story-parameters) level, but it could also be applied at the [component](https://storybook.js.org/docs/writing-stories/parameters.md#component-parameters) (or meta) level or [project](https://storybook.js.org/docs/writing-stories/parameters.md#global-parameters) level.

</details>

### `additionalActions`

Type:

```ts
Array<{
  title: string | JSX.Element;
  className?: string;
  onClick: () => void;
  disabled?: boolean;
}>;
```

Default: `parameters.docs.canvas.additionalActions`

Provides any additional custom actions to show in the bottom right corner. These are simple buttons that do anything you specify in the `onClick` function.

```mdx title="ButtonDocs.mdx"

<Canvas
  additionalActions={[
    {
      title: 'Open in GitHub',
      onClick: () => {
        window.open(
          'https://github.com/storybookjs/storybook/blob/next/code/ui/blocks/src/examples/Button.stories.tsx',
          '_blank',
        );
      },
    },
  ]}
  of={ButtonStories.Primary}
/>
```

### `className`

Type: `string`

Default: `parameters.docs.canvas.className`

Provides HTML class(es) to the preview element, for custom styling.

### `layout`

Type: `'centered' | 'fullscreen' | 'padded'`

Default: `parameters.layout` or `parameters.docs.canvas.layout` or `'padded'`

Specifies how the canvas should layout the story.

- **centered**: Center the story within the canvas
- **padded**: (default) Add padding to the story
- **fullscreen**: Show the story as-is, without padding

In addition to the `parameters.docs.canvas.layout` property or the `layout` prop, the `Canvas` block will respect the `parameters.layout` value that defines [how a story is laid out](https://storybook.js.org/docs/configure/story-layout.md) in the regular story view.

### `meta`

Type: CSF file exports

Specifies the CSF file to which the story is associated.

You can render a story from a CSF file that you haven’t attached to the MDX file (via `Meta`) by using the `meta` prop. Pass the **full set of exports** from the CSF file (not the default export!).

```mdx title="ButtonDocs.mdx"

```

### `of`

Type: Story export

Specifies which story's source is displayed.

### `source`

Type: `SourceProps['code'] | SourceProps['format'] | SourceProps['language'] | SourceProps['type']`

Specifies the props passed to the inner `Source` block. For more information, see the `Source` Doc Block [documentation](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md).

The dark prop is ignored, as the `Source` block is always rendered in dark mode when shown as part of a `Canvas` block.

### `sourceState`

Type: `'hidden' | 'shown' | 'none'`

Default: `parameters.docs.canvas.sourceState` or `'hidden'`

Specifies the initial state of the source panel.

- **hidden**: the source panel is hidden by default
- **shown**: the source panel is shown by default
- **none**: the source panel is not available and the button to show it is not rendered

### `story`

Type: `StoryProps['inline'] | StoryProps['height'] | StoryProps['autoplay']`

Specifies the props passed to the inner `Story` block. For more information, see the `Story` Doc Block [documentation](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md).

### `withToolbar`

Type: `boolean`

Default: `parameters.docs.canvas.withToolbar`

Determines whether to render a toolbar containing tools to interact with the story.
