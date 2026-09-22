# Description

The `Description` block displays the description for a component, story, or meta, obtained from their respective JSDoc comments.

![Screenshot of Description block](../../_assets/api/doc-block-title-subtitle-description.png)

```mdx title="ButtonDocs.mdx"

```

## Description

```js

```

`Description` is configured with the following props:

### `of`

Type: Story export or CSF file exports

Specifies where to pull the description from. It can either point to a story or a meta, depending on which description you want to show.

Descriptions are pulled from the JSDoc comments or parameters, and they are rendered as markdown. See [Writing descriptions](#writing-descriptions) for more details.

## Writing descriptions

There are multiple places to write the description of a component/story, depending on what you want to achieve. Descriptions can be written at the story level to describe each story of a component, or they can be written at the meta or component level to describe the component in general.

Descriptions can be written as [JSDoc comments](https://jsdoc.app/about-getting-started.html) above stories, meta, or components. Alternatively they can also be specified in [`parameters`](https://storybook.js.org/docs/writing-stories/parameters.md). To describe a story via parameters instead of comments, add it to `parameters.docs.description.story`; to describe meta/component, add it to `parameters.docs.description.component`.

We recommend using JSDoc comments for descriptions, and only use the `parameters.docs.description.X` properties in situations where comments are not possible to write for some reason, or where you want the description shown in Storybook to be different from the comments. Comments provide a better writing experience as you don’t have to worry about indentation, and they are more discoverable for other developers that are exploring the story/component sources.

When documenting a story, reference a story export in the `of` prop (see below) and the Description block will look for descriptions in the following order:

1. `parameters.docs.description.story` in the story
2. JSDoc comments above the story

When documenting a component, reference a meta export in the `of` prop (see below) and the Description block will look for descriptions in the following order:

1. `parameters.docs.description.component` in the meta
2. JSDoc comments above the meta
3. JSDoc comments above the component

This flow gives you powerful ways to override the description for each scenario. Take the following example:

```jsx title="Button.jsx"
/**
 * The Button component shows a button
 */
export const Button = () => <button>Click me</button>;
```

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

/**
 * Button stories
 * These stories showcase the button
 */
const meta = {
  component: Button,
  parameters: {
    docs: {
      description: {
        component: 'Another description, overriding the comments',
      },
    },
  },
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

/**
 * Primary Button
 * This is the primary button
 */
export const Primary: Story = {
  parameters: {
    docs: {
      description: {
        story: 'Another description on the story, overriding the comments',
      },
    },
  },
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

/**
 * Button stories
 * These stories showcase the button
 */
const meta = preview.meta({
  component: Button,
  parameters: {
    docs: {
      description: {
        component: 'Another description, overriding the comments',
      },
    },
  },
});

/**
 * Primary Button
 * This is the primary button
 */
export const Primary = meta.story({
  parameters: {
    docs: {
      description: {
        story: 'Another description on the story, overriding the comments',
      },
    },
  },
});
```

```mdx title="ButtonDocs.mdx"

```
