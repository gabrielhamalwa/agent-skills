# Args

A story is a component with a set of arguments that define how the component should render. “Args” are Storybook’s mechanism for defining those arguments in a single JavaScript object. Args can be used to dynamically change props, slots, styles, inputs, etc. It allows Storybook and its addons to live edit components. You _do not_ need to modify your underlying component code to use args.

When an arg’s value changes, the component re-renders, allowing you to interact with components in Storybook’s UI via addons that affect args.

Learn how and why to write stories in [the introduction](https://storybook.js.org/docs/writing-stories.md). For details on how args work, read on.

## Args object

The `args` object can be defined at the [story](#story-args), [component](#component-args) and [global level](#global-args). It is a JSON serializable object composed of string keys with matching valid value types that can be passed into a component for your framework.

## Story args

To define the args of a single story, use the `args` CSF story key:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    primary: true,
    label: 'Button',
  },
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

export const Primary = meta.story({
  args: {
    primary: true,
    label: 'Button',
  },
});
```

These args will only apply to the story for which they are attached, although you can [reuse](https://storybook.js.org/docs/writing-stories/build-pages-with-storybook.md#args-composition-for-presentational-screens) them via JavaScript object reuse:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the name of your framework

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    primary: true,
    label: 'Button',
  },
};

export const PrimaryLongName: Story = {
  args: {
    ...Primary.args,
    label: 'Primary with a really long name',
  },
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

export const Primary = meta.story({
  args: {
    primary: true,
    label: 'Button',
  },
});

export const PrimaryLongName = meta.story({
  args: {
    ...Primary.input.args,
    label: 'Primary with a really long name',
  },
});
```

In the above example, we use the [object spread](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax) feature of ES 2015.

## Component args

You can also define args at the component level; they will apply to all the component's stories unless you overwrite them. To do so, use the `args` key on the `default` CSF export:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: Button,
  //👇 Creates specific argTypes
  argTypes: {
    backgroundColor: { control: 'color' },
  },
  args: {
    //👇 Now all Button stories will be primary.
    primary: true,
  },
} satisfies Meta<typeof Button>;

export default meta;
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
  //👇 Creates specific argTypes
  argTypes: {
    backgroundColor: { control: 'color' },
  },
  args: {
    //👇 Now all Button stories will be primary.
    primary: true,
  },
});
```

## Global args

You can also define args at the global level; they will apply to every component's stories unless you overwrite them. To do so, define the `args` property in the default export of `preview.*`:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  // The default value of the theme arg for all stories
  args: { theme: 'light' },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  // The default value of the theme arg for all stories
  args: { theme: 'light' },
});
```

For most uses of global args, [globals](https://storybook.js.org/docs/essentials/toolbars-and-globals.md) are a better tool for defining globally-applied settings, such as a theme. Using globals enables users to change the value with the toolbar menu.

## Args composition

You can separate the arguments to a story to compose in other stories. Here's how you can combine args for multiple stories of the same component.

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the name of your framework

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    primary: true,
    label: 'Button',
  },
};

export const Secondary: Story = {
  args: {
    ...Primary.args,
    primary: false,
  },
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

export const Primary = meta.story({
  args: {
    primary: true,
    label: 'Button',
  },
});

export const Secondary = meta.story({
  args: {
    ...Primary.input.args,
    primary: false,
  },
});
```

If you find yourself re-using the same args for most of a component's stories, you should consider using [component-level args](#component-args).

Args are useful when writing stories for composite components that are assembled from other components. Composite components often pass their arguments unchanged to their child components, and similarly, their stories can be compositions of their child components stories. With args, you can directly compose the arguments:

```ts
// Page.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

//👇 Imports all Header stories

const meta = {
  component: Page,
} satisfies Meta<typeof Page>;

export default meta;
type Story = StoryObj<typeof meta>;

export const LoggedIn: Story = {
  args: {
    ...HeaderStories.LoggedIn.args,
  },
};
```

```ts
// Page.stories.ts|tsx — CSF Next 🧪

//👇 Imports all Header stories

const meta = preview.meta({
  component: Page,
});

export const LoggedIn = meta.story({
  args: {
    ...HeaderStories.LoggedIn.input.args,
  },
});
```

## Args can modify any aspect of your component

You can use args in your stories to configure the component's appearance, similar to what you would do in an application. For example, here's how you could use a `footer` arg to populate a child component:

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

## Setting args through the URL

You can also override the set of initial args for the active story by adding an `args` query parameter to the URL. Typically, you would use [Controls](https://storybook.js.org/docs/essentials/controls.md) to handle this. For example, here's how you could set a `size` and `style` arg in the Storybook's URL:

```
?path=/story/avatar--default&args=style:rounded;size:100
```

As a safeguard against [XSS](https://owasp.org/www-community/attacks/xss/) attacks, the arg's keys and values provided in the URL are limited to alphanumeric characters, spaces, underscores, and dashes. Any other types will be ignored and removed from the URL, but you can still use them with the Controls panel and [within your story](#mapping-to-complex-arg-values).

The `args` param is always a set of `key: value` pairs delimited with a semicolon `;`. Values will be coerced (cast) to their respective `argTypes` (which may have been automatically inferred). Objects and arrays are supported. Special values `null` and `undefined` can be set by prefixing with a bang `!`. For example, `args=obj.key:val;arr[0]:one;arr[1]:two;nil:!null` will be interpreted as:

```js
{
  obj: { key: 'val' },
  arr: ['one', 'two'],
  nil: null
}
```

Similarly, special formats are available for dates and colors. Date objects will be encoded as `!date(value)` with value represented as an ISO date string. Colors are encoded as `!hex(value)`, `!rgba(value)` or `!hsla(value)`. Note that rgb(a) and hsl(a) should not contain spaces or percentage signs in the URL.

Args specified through the URL will extend and override any default values of args set on the story.

## Setting args from within a story

Interactive components often need to be controlled by their containing component or page to respond to events, modify their state and reflect those changes in the UI. For example, when a user toggles a switch component, the switch should be checked, and the arg shown in Storybook should reflect the change. To enable this, you can use the `useArgs` API exported by `storybook/preview-api`:

```tsx
// my-component/component.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  title: 'Inputs/Checkbox',
  component: Checkbox,
} satisfies Meta<typeof Checkbox>;
export default meta;

type Story = StoryObj<typeof Checkbox>;

export const Example = {
  args: {
    isChecked: false,
    label: 'Try Me!',
  },
  /**
   * 👇 To avoid linting issues, it is recommended to use a function with a capitalized name.
   * If you are not concerned with linting, you may use an arrow function.
   */
  render: function Render(args) {
    const [{ isChecked }, updateArgs] = useArgs();

    function onChange() {
      updateArgs({ isChecked: !isChecked });
    }

    return ;
  },
} satisfies Story;
```

```tsx
// my-component/component.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  title: 'Inputs/Checkbox',
  component: Checkbox,
});

export const Example = meta.story({
  args: {
    isChecked: false,
    label: 'Try Me!',
  },
  /**
   * 👇 To avoid linting issues, it is recommended to use a function with a capitalized name.
   * If you are not concerned with linting, you may use an arrow function.
   */
  render: function Render(args) {
    const [{ isChecked }, updateArgs] = useArgs();

    function onChange() {
      updateArgs({ isChecked: !isChecked });
    }

    return ;
  },
});
```

If you're using Storybook's hooks API in the story's render function, **do not** mix them with React's hooks such as `useState`, `useEffect`, or `useRef`. This is because side effects and re-rendering triggered by React's hooks do not run through Storybook's hook context, which can cause an error on re-render. To manage state and side effects within a story, you must use Storybook's equivalent hooks, such as `useState`, `useEffect`, and `useRef` from `storybook/preview-api`.

## Mapping to complex arg values

Complex values such as JSX elements cannot be serialized to the manager (e.g., the Controls panel) or synced with the URL. Arg values can be "mapped" from a simple string to a complex type using the `mapping` property in `argTypes` to work around this limitation. It works in any arg but makes the most sense when used with the `select` control type.

```ts
// Example.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Example,
  argTypes: {
    label: {
      control: { type: 'select' },
      options: ['Normal', 'Bold', 'Italic'],
      mapping: {
        Bold: <b>Bold</b>,
        Italic: <i>Italic</i>,
      },
    },
  },
} satisfies Meta<typeof Example>;

export default meta;
```

```ts
// Example.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Example,
  argTypes: {
    label: {
      control: { type: 'select' },
      options: ['Normal', 'Bold', 'Italic'],
      mapping: {
        Bold: <b>Bold</b>,
        Italic: <i>Italic</i>,
      },
    },
  },
});
```

Note that `mapping` does not have to be exhaustive. If the arg value is not a property of `mapping`, the value will be used directly. Keys in `mapping` always correspond to arg _values_, not their index in the `options` array.

<details>
<summary>Using args in addons</summary>

If you are [writing an addon](https://storybook.js.org/docs/addons/writing-addons.md) that wants to read or update args, use the `useArgs` hook exported by `storybook/manager-api`:

```js
// my-addon/src/manager.js|ts

const [args, updateArgs, resetArgs] = useArgs();

// To update one or more args:
updateArgs({ key: 'value' });

// To reset one (or more) args:
resetArgs((argNames: ['key']));

// To reset all args
resetArgs();
```

</details>
