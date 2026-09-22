# Loaders

Loaders are asynchronous functions that load data for a story and its [decorators](https://storybook.js.org/docs/writing-stories/decorators.md). A story's loaders run before the story renders, and the loaded data injected into the story via its render context.

Loaders can be used to load any asset, lazy load components, or fetch data from a remote API. This feature was designed as a performance optimization to handle large story imports. However, [args](https://storybook.js.org/docs/writing-stories/args.md) is the recommended way to manage story data. We're building up an ecosystem of tools and techniques around Args that might not be compatible with loaded data.

They are an advanced feature (i.e., escape hatch), and we only recommend using them if you have a specific need that other means can't fulfill.

## Fetching API data

Stories are isolated component examples that render internal data defined as part of the story or alongside the story as [args](https://storybook.js.org/docs/writing-stories/args.md).

Loaders are helpful when you need to load story data externally (e.g., from a remote API). Consider the following example that fetches a todo item to display in a todo list:

```tsx
// MyComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

/*
 *👇 Render functions are a framework specific feature to allow you control on how the component renders.
 * See https://storybook.js.org/docs/api/csf
 * to learn how to use render functions.
 */
const meta = {
  component: TodoItem,
  render: (args, { loaded: { todo } }) => ,
} satisfies Meta<typeof TodoItem>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  loaders: [
    async () => ({
      todo: await (await fetch('https://jsonplaceholder.typicode.com/todos/1')).json(),
    }),
  ],
};
```

```tsx
// MyComponent.stories.ts|tsx — CSF Next 🧪

/*
 *👇 Render functions are a framework specific feature to allow you control on how the component renders.
 * See https://storybook.js.org/docs/api/csf
 * to learn how to use render functions.
 */
const meta = preview.meta({
  component: TodoItem,
  render: (args, { loaded: { todo } }) => ,
});

export const Primary = meta.story({
  loaders: [
    async () => ({
      todo: await (await fetch('https://jsonplaceholder.typicode.com/todos/1')).json(),
    }),
  ],
});
```

The response obtained from the remote API call is combined into a `loaded` field on the story context, which is the second argument to a story function. For example, in React, the story's args were spread first to prioritize them over the static data provided by the loader. With other frameworks (e.g., Angular), you can write your stories as you'd usually do.

## Global loaders

We can also set a loader for **all stories** via the `loaders` export of your [`.storybook/preview.js`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) file (this is the file where you configure all stories):

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  loaders: [
    async () => ({
      currentUser: await (await fetch('https://jsonplaceholder.typicode.com/users/1')).json(),
    }),
  ],
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  loaders: [
    async () => ({
      currentUser: await (await fetch('https://jsonplaceholder.typicode.com/users/1')).json(),
    }),
  ],
});
```

In this example, we load a "current user" available as `loaded.currentUser` for all stories.

## Loader inheritance

Like [parameters](https://storybook.js.org/docs/writing-stories/parameters.md), loaders can be defined globally, at the component level, and for a single story (as we’ve seen).

All loaders, defined at all levels that apply to a story, run before the story renders in Storybook's canvas.

- All loaders run in parallel
- All results are the `loaded` field in the story context
- If there are keys that overlap, "later" loaders take precedence (from lowest to highest):
  - Global loaders, in the order they are defined
  - Component loaders, in the order they are defined
  - Story loaders, in the order they are defined
