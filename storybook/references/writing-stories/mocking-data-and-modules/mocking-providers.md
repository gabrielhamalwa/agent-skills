# Mocking providers

The [context provider pattern](https://react.dev/learn/passing-data-deeply-with-context) and how to mock it only applies to renderers that use JSX, like [React](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/?renderer=react.md) or [Solid](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/?renderer=solid.md).

Components can receive data or configuration from context providers. For example, a styled component might access its theme from a ThemeProvider or Redux uses React context to provide components access to app data. To mock a provider, you can wrap your component in a [decorator](https://storybook.js.org/docs/writing-stories/decorators.md) that includes the necessary context.

```tsx
// .storybook/preview.tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const preview: Preview = {
  decorators: [
    (Story) => (
      
        
        
      
    ),
  ],
};

export default preview;
```

```tsx
// .storybook/preview.tsx — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  decorators: [
    (Story) => (
      
        
        
      
    ),
  ],
});
```

Note the file extension above (`.tsx` or `.jsx`). You may need to adjust your preview file's extension to allow use of JSX, depending on your project's settings.

For another example, reference the [Screens](https://storybook.js.org/tutorials/intro-to-storybook/react/en/screen/) chapter of the Intro to Storybook tutorial, where we mock a Redux provider with mock data.

## Configuring the mock provider

When mocking a provider, it may be necessary to configure the provider to supply a different value for individual stories. For example, you might want to test a component with different themes or user roles.

One way to do this is to define the decorator for each story individually. But if you imagine a scenario where you wish to create stories for each of your components in both light and dark themes, this approach can quickly become cumbersome.

For a better way, with much less repetition, you can use the [decorator function's second "context" argument](https://storybook.js.org/docs/writing-stories/decorators.md#context-for-mocking) to access a story's [`parameters`](https://storybook.js.org/docs/writing-stories/parameters.md) and adjust the provided value. This way, you can define the provider once and adjust its value for each story.

For example, we can adjust the decorator from above to read from `parameters.theme` to determine which theme to provide:

```tsx
// .storybook/preview.ts|tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

// themes = { light, dark }

const preview: Preview = {
  decorators: [
    // 👇 Defining the decorator in the preview file applies it to all stories
    (Story, { parameters }) => {
      // 👇 Make it configurable by reading the theme value from parameters
      const { theme = 'light' } = parameters;
      return (
        
          
        
      );
    },
  ],
};

export default preview;
```

```tsx
// .storybook/preview.tsx — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

// themes = { light, dark }

export default definePreview({
  decorators: [
    // 👇 Defining the decorator in the preview file applies it to all stories
    (Story, { parameters }) => {
      // 👇 Make it configurable by reading the theme value from parameters
      const { theme = 'light' } = parameters;
      return (
        
          
        
      );
    },
  ],
});
```

Now, you can define a `theme` parameter in your stories to adjust the theme provided by the decorator:

```ts
// Button.stories.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;
export default meta;

type Story = StoryObj<typeof meta>;

// Wrapped in light theme
export const Basic: Story = {};

// Wrapped in dark theme
export const Dark: Story = {
  parameters: {
    theme: 'dark',
  },
};
```

```ts
// Button.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

// Wrapped in light theme
export const Basic = meta.story();

// Wrapped in dark theme
export const Dark = meta.story({
  parameters: {
    theme: 'dark',
  },
});
```

This powerful approach allows you to provide any value (theme, user role, mock data, etc.) to your components in a way that is both flexible and maintainable.
