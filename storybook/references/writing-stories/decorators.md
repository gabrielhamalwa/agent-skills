# Decorators

A decorator is a way to wrap a story in extra “rendering” functionality. Many addons define decorators to augment your stories with extra rendering or gather details about how your story renders.

When writing stories, decorators are typically used to wrap stories with extra markup or context mocking.

## Wrap stories with extra markup

Some components require a “harness” to render in a useful way. For instance, if a component runs right up to its edges, you might want to space it inside Storybook. Use a decorator to add spacing for all stories of the component.

![Story without padding](../_assets/writing-stories/decorators-no-padding.png)

```tsx
// YourComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: YourComponent,
  decorators: [
    (Story) => (
      <div style={{ margin: '3em' }}>
        
        
      </div>
    ),
  ],
} satisfies Meta<typeof YourComponent>;

export default meta;
```

```tsx
// YourComponent.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: YourComponent,
  decorators: [
    (Story) => (
      <div style={{ margin: '3em' }}>
        
        
      </div>
    ),
  ],
});
```

![Story with padding](../_assets/writing-stories/decorators-padding.png)

## “Context” for mocking

The second argument to a decorator function is the **story context** which contains the properties:

- `args` - the story arguments. You can use some [`args`](https://storybook.js.org/docs/writing-stories/args.md) in your decorators and drop them in the story implementation itself.
- `argTypes`- Storybook's [argTypes](https://storybook.js.org/docs/api/arg-types.md) allow you to customize and fine-tune your stories [`args`](https://storybook.js.org/docs/writing-stories/args.md).
- `globals` - Storybook-wide [globals](https://storybook.js.org/docs/essentials/toolbars-and-globals.md#globals). In particular you can use the [toolbars feature](https://storybook.js.org/docs/essentials/toolbars-and-globals.md#global-types-and-the-toolbar-annotation) to allow you to change these values using Storybook’s UI.
- `hooks` - Storybook's API hooks (e.g., `useArgs`, `useGlobals`). These are available in both decorators and story render functions. When using these hooks in a render function alongside framework hooks (e.g., React's `useState`, `useEffect`), use Storybook's hook equivalents from `storybook/preview-api` instead to avoid errors on re-render.
- `parameters`- the story's static metadata, most commonly used to control Storybook's behavior of features and addons.
- `viewMode`- Storybook's current active window (e.g., canvas, docs).

This context can be used to adjust the behavior of your decorator based on the story's arguments or other metadata. For example, you could create a decorator that allows you to optionally apply a layout to the story, by defining `parameters.pageLayout = 'page'` (or `'page-mobile'`):
:

```tsx
// .storybook/preview.tsx — CSF 3

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

const preview: Preview = {
  decorators: [
    // 👇 Defining the decorator in the preview file applies it to all stories
    (Story, { parameters }) => {
      // 👇 Make it configurable by reading from parameters
      const { pageLayout } = parameters;
      switch (pageLayout) {
        case 'page':
          return (
            // Your page layout is probably a little more complex than this
            <div className="page-layout">
              
            </div>
          );
        case 'page-mobile':
          return (
            <div className="page-mobile-layout">
              
            </div>
          );
        default:
          // In the default case, don't apply a layout
          return ;
      }
    },
  ],
};

export default preview;
```

```tsx
// .storybook/preview.tsx — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  decorators: [
    // 👇 Defining the decorator in the preview file applies it to all stories
    (Story, { parameters }) => {
      // 👇 Make it configurable by reading from parameters
      const { pageLayout } = parameters;
      switch (pageLayout) {
        case 'page':
          return (
            // Your page layout is probably a little more complex than this
            <div className="page-layout">
              
            </div>
          );
        case 'page-mobile':
          return (
            <div className="page-mobile-layout">
              
            </div>
          );
        default:
          // In the default case, don't apply a layout
          return ;
      }
    },
  ],
});
```

For another example, see the section on [configuring the mock provider](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-providers.md#configuring-the-mock-provider), which demonstrates how to use the same technique to change which theme is provided to the component.

### Using decorators to provide data

If your components are “connected” and require side-loaded data to render, you can use decorators to provide that data in a mocked way without having to refactor your components to take that data as an arg. There are several techniques to achieve this. Depending on exactly how you are loading that data. Read more in the [building pages in Storybook](https://storybook.js.org/docs/writing-stories/build-pages-with-storybook.md) section.

## Story decorators

To define a decorator for a single story, use the `decorators` key on a named export:

```tsx
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  decorators: [
    (Story) => (
      <div style={{ margin: '3em' }}>
        
        
      </div>
    ),
  ],
};
```

```tsx
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

export const Primary = meta.story({
  decorators: [
    (Story) => (
      <div style={{ margin: '3em' }}>
        
        
      </div>
    ),
  ],
});
```

It is useful to ensure that the story remains a “pure” rendering of the component under test and that any extra HTML or components are used only as decorators. In particular the [Source](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md) Doc Block works best when you do this.

## Component decorators

To define a decorator for all stories of a component, use the `decorators` key of the default CSF export:

```tsx
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: Button,
  decorators: [
    (Story) => (
      <div style={{ margin: '3em' }}>
        
        
      </div>
    ),
  ],
} satisfies Meta<typeof Button>;

export default meta;
```

```tsx
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
  decorators: [
    (Story) => (
      <div style={{ margin: '3em' }}>
        
        
      </div>
    ),
  ],
});
```

## Global decorators

We can also set a decorator for **all stories** via the `decorators` export of your [`.storybook/preview.ts|tsx`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) file (this is the file where you configure all stories):

```tsx
// .storybook/preview.tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const preview: Preview = {
  decorators: [
    (Story) => (
      <div style={{ margin: '3em' }}>
        
        
      </div>
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
      <div style={{ margin: '3em' }}>
        
        
      </div>
    ),
  ],
});
```

## Decorator inheritance

Like parameters, decorators can be defined globally, at the component level, and for a single story (as we’ve seen).

All decorators relevant to a story will run in the following order once the story renders:

- Global decorators, in the order they are defined
- Component decorators, in the order they are defined
- Story decorators, in the order they are defined, starting from the innermost decorator and working outwards and up the hierarchy in the same order
