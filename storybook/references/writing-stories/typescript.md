# Writing stories in TypeScript

Writing your stories in [TypeScript](https://www.typescriptlang.org/) makes you more productive. You don't have to jump between files to look up component props. Your code editor will alert you about missing required props and even autocomplete prop values, just like when using your components within your app. Plus, Storybook infers those component types to auto-generate the [Controls](https://storybook.js.org/docs/api/doc-blocks/doc-block-controls.md) table.

Storybook has built-in TypeScript support, so you can get started with zero configuration required.

[CSF Next](https://storybook.js.org/docs/api/csf/csf-next.md) (currently in preview) provides significantly improved TypeScript support, which infers component types automatically and requires no explicit typing for most cases. We recommend using CSF Next for all new TypeScript stories.

You only need to add types when using [custom args](#typing-custom-args).

## Typing stories with `Meta` and `StoryObj`

When writing stories, there are two aspects that are helpful to type. The first is the [component meta](https://storybook.js.org/docs/writing-stories/index.md#default-export), which describes and configures the component and its stories. In a [CSF file](https://storybook.js.org/docs/api/csf.md), this is the default export. The second is the [stories themselves](https://storybook.js.org/docs/writing-stories/index.md#defining-stories).

Storybook provides utility types for each of these, named `Meta` and `StoryObj`. Here's an example CSF file using those types:

```ts
// Button.stories.ts
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;
export default meta;

type Story = StoryObj<typeof meta>;

export const Basic = {} satisfies Story;

export const Primary = {
  args: {
    primary: true,
  },
} satisfies Story;
```

### Props type parameter

`Meta` and `StoryObj` types are both [generics](https://www.typescriptlang.org/docs/handbook/2/generics.html#working-with-generic-type-variables), so you can provide them with an optional prop type parameter for the component type or the component's props type (e.g., the `typeof Button` portion of `Meta<typeof Button>`). By doing so, TypeScript will prevent you from defining an invalid arg, and all [decorators](https://storybook.js.org/docs/writing-stories/decorators.md), [play functions](https://storybook.js.org/docs/writing-stories/play-function.md), or [loaders](https://storybook.js.org/docs/writing-stories/loaders.md) will type their function arguments.

The example above passes a component type. See [**Typing custom args**](#typing-custom-args) for an example of passing a props type.

### Using `satisfies` for better type safety

  

    We are not yet able to provide additional type safety using the `satisfies` operator with Angular and Web components.

    <details>
      <summary>More info</summary>

      Both Angular and Web components utilize a class plus decorator approach. The decorators provide runtime metadata, but do not offer metadata at compile time.

      As a result, it appears impossible to determine if a property in the class is a required property or an optional property (but non-nullable due to a default value) or a non-nullable internal state variable.

      For more information, please refer to [this discussion](https://github.com/storybookjs/storybook/discussions/20988).

    </details>

  

If you are using TypeScript 4.9+, you can take advantage of the new [`satisfies`](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-4-9.html) operator to get stricter type checking. Now you will receive type errors for missing required args, not just invalid ones.

Using `satisfies` to apply a story's type helps maintain type safety when sharing a [play function](https://storybook.js.org/docs/writing-stories/play-function.md) across stories. Without it, TypeScript will throw an error that the `play` function may be undefined. The `satisfies` operator enables TypeScript to infer whether the play function is defined or not.

Finally, use of `satisfies` allows you to pass `typeof meta` to the `StoryObj` generic. This informs TypeScript of the connection between the `meta` and `StoryObj` types, which allows it to infer the `args` type from the `meta` type. In other words, TypeScript will understand that args can be defined both at the story and meta level and won't throw an error when a required arg is defined at the meta level, but not at the story level.

## Typing custom args

Sometimes stories need to define args that aren’t included in the component's props. For this case, you can use an [intersection type](https://www.typescriptlang.org/docs/handbook/2/objects.html#intersection-types) to combine a component's props type and your custom args' type. For example, here's how you could use a `footer` arg to populate a child component:

```tsx
// Page.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

type PagePropsAndCustomArgs = React.ComponentProps<typeof Page> & { footer?: string };

const meta = {
  component: Page,
  render: ({ footer, ...args }) => (
    
      <footer>{footer}</footer>
    
  ),
} satisfies Meta;
export default meta;

type Story = StoryObj<typeof meta>;

export const CustomFooter = {
  args: {
    footer: 'Built with Storybook',
  },
} satisfies Story;
```

```tsx
// Page.stories.ts|tsx — CSF Next 🧪

type PagePropsAndCustomArgs = React.ComponentProps<typeof Page> & {
  footer?: string;
};

const meta = preview.type<{ args: PagePropsAndCustomArgs }>().meta({
  component: Page,
  render: ({ footer, ...args }) => (
    <Page {...args}>
      <footer>{footer}</footer>
    
  ),
});

export const CustomFooter = meta.story({
  args: {
    footer: 'Built with Storybook',
  },
});
```
