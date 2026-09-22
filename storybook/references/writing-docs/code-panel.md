# Code panel

Code Panel is a replacement for the [Storysource addon](https://storybook.js.org/addons/@storybook/addon-storysource), which was [discontinued in Storybook 9](https://github.com/storybookjs/storybook/blob/next/MIGRATION.md#storysource-addon-removed).

The Code panel renders a story’s source code when viewing that story in the canvas. Any [args](https://storybook.js.org/docs/writing-stories/args.md) defined in the story are replaced with their values in the output.

![Code panel showing story's source code](../_assets/writing-docs/code-panel.png)

## Usage

To enable the Code panel, set `parameters.docs.codePanel` to `true`. For most projects, this is best done in the `.storybook/preview.*` file, to apply to all stories.

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using (e.g., react-vite, vue3-vite, angular, etc.)

const preview: Preview = {
  parameters: {
    docs: {
      codePanel: true,
    },
  },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  parameters: {
    docs: {
      codePanel: true,
    },
  },
});
```

You can also enable it at the component or story level:

```ts
// Button.stories.ts|tsx — CSF 3

const meta = {
  component: Button,
  parameters: {
    docs: {
      // 👇 Enable Code panel for all stories in this file
      codePanel: true,
    },
  },
} satisfies Meta<typeof Button>;
export default meta;

type Story = StoryObj<typeof meta>;

// 👇 This story will display the Code panel
export const Primary: Story = {
  args: {
    children: 'Button',
  },
};

export const Secondary: Story = {
  args: {
    children: 'Button',
    variant: 'secondary',
  },
  parameters: {
    docs: {
      // 👇 Disable Code panel for this specific story
      codePanel: false,
    },
  },
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
  parameters: {
    docs: {
      // 👇 Enable Code panel for all stories in this file
      codePanel: true,
    },
  },
});

// 👇 This story will display the Code panel
export const Primary = meta.story({
  args: {
    children: 'Button',
  },
});

export const Secondary = meta.story({
  args: {
    children: 'Button',
    variant: 'secondary',
  },
  parameters: {
    docs: {
      // 👇 Disable Code panel for this specific story
      codePanel: false,
    },
  },
});
```

## Configuration

Code panel renders the same snippet as the [Source docs block](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md), which is also used in [Autodocs](https://storybook.js.org/docs/writing-docs/autodocs.md) pages. The snippet is customizable and reuses the [Source configuration parameters](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md#source).
