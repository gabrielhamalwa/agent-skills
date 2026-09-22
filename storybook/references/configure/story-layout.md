# Story layout

The `layout` [parameter](https://storybook.js.org/docs/writing-stories/parameters.md) allows you to configure how stories are positioned in Storybook's Canvas tab.

## Global layout

You can add the parameter to your [`./storybook/preview.js`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering), like so:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  parameters: {
    layout: 'centered',
  },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  parameters: {
    layout: 'centered',
  },
});
```

![Layout params centered story](../_assets/configure/layout-params-story-centered.png)

In the example above, Storybook will center all stories in the UI. `layout` accepts these options:

- `centered`: center the component horizontally and vertically in the Canvas
- `fullscreen`: allow the component to expand to the full width and height of the Canvas
- `padded`: _(default)_ Add extra padding around the component

## Component layout

You can also set it at a component level like so:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
  // Sets the layout parameter component wide.
  parameters: {
    layout: 'centered',
  },
} satisfies Meta<typeof Button>;

export default meta;
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
  // Sets the layout parameter component wide.
  parameters: {
    layout: 'centered',
  },
});
```

## Story layout

Or even apply it to specific stories like so:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const WithLayout: Story = {
  parameters: {
    layout: 'centered',
  },
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

export const WithLayout = meta.story({
  parameters: {
    layout: 'centered',
  },
});
```
