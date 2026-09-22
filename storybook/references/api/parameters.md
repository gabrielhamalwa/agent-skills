# Parameters

Parameters are static metadata used to configure your [stories](https://storybook.js.org/docs/get-started/whats-a-story.md) and [addons](https://storybook.js.org/docs/addons.md) in Storybook. They are specified at the story, meta (component), project (global) levels.

## Story parameters

Parameters specified at the story level apply to that story only. They are defined in the `parameters` property of the story (named export):

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  // 👇 Story-level parameters
  parameters: {
    backgrounds: {
      options: {
        red: { name: 'Red', value: '#f00' },
        green: { name: 'Green', value: '#0f0' },
        blue: { name: 'Blue', value: '#00f' },
      },
    },
  },
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

export const Primary = meta.story({
  // 👇 Story-level parameters
  parameters: {
    backgrounds: {
      options: {
        red: { name: 'Red', value: '#f00' },
        green: { name: 'Green', value: '#0f0' },
        blue: { name: 'Blue', value: '#00f' },
      },
    },
  },
});
```

Parameters specified at the story level will [override](#parameter-inheritance) those specified at the project level and meta (component) level.

## Meta parameters

Parameter's specified in a [CSF](https://storybook.js.org/docs/writing-stories/index.md#component-story-format) file's meta configuration apply to all stories in that file. They are defined in the `parameters` property of the meta (or default export):

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
  //👇 Creates specific parameters at the component level
  parameters: {
    backgrounds: {
      options: {},
    },
  },
} satisfies Meta<typeof Button>;

export default meta;
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
  //👇 Creates specific parameters at the component level
  parameters: {
    backgrounds: {
      options: {},
    },
  },
});
```

Parameters specified at the meta (component) level will [override](#parameter-inheritance) those specified at the project level.

## Project parameters

Parameters specified at the project (global) level apply to **all stories** in your Storybook. They are defined in the `parameters` property of the meta (or default export) in your `.storybook/preview.*` file:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  parameters: {
    backgrounds: {
      options: {
        light: { name: 'Light', value: '#fff' },
        dark: { name: 'Dark', value: '#333' },
      },
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
    backgrounds: {
      options: {
        light: { name: 'Light', value: '#fff' },
        dark: { name: 'Dark', value: '#333' },
      },
    },
  },
});
```

## Available parameters

Storybook only accepts a few parameters directly.

### `layout`

Type: `'centered' | 'fullscreen' | 'padded'`

Default: `'padded'`

Specifies how the canvas should [lay out the story](https://storybook.js.org/docs/configure/story-layout.md).

- **centered**: Center the story within the canvas
- **padded**: (default) Add padding to the story
- **fullscreen**: Show the story as-is, without padding

### `htmlLang`

Type: `string`

Default: `'en'`

A [BCP-47 language tag](https://en.wikipedia.org/wiki/IETF_language_tag) (e.g. `'ja'`, `'de'`, `'fr-CH'`) describing the language of the **rendered story UI**. In story view it sets the `lang` attribute on the preview's `<html>` element; in docs view it sets `lang` on each embedded story canvas. Inherited project → meta → story.

Use this to language the components you render — for example, a German story added for copy-length validation inside an otherwise English design system.

Storybook's own interface (the manager UI and docs chrome such as toolbars and ArgTypes headers) always reports as English and is unaffected by this parameter.

### `docs.lang`

Type: `string`

Default: `'en'`

A BCP-47 language tag describing the language of the **docs prose** that Storybook renders — component and story descriptions, ArgTypes description cells, and free-form MDX prose. Resolved project → meta for page-level content and project → meta → story for per-story content.

This is independent of [`htmlLang`](#htmllang): the language you _document_ in can differ from the language your stories _render_ in. Storybook chrome (toolbars, ArgTypes column headers, anchor links) stays English regardless.

### `options`

Type:

```ts
{
  storySort?: StorySortConfig | StorySortFn;
}
```

The `options` parameter can _only_ be applied at the [project level](#project-parameters).

#### `options.storySort`

Type: `StorySortConfig | StorySortFn`

```ts
type StorySortConfig = {
  includeNames?: boolean;
  locales?: string;
  method?: 'alphabetical' | 'alphabetical-by-kind' | 'custom';
  order?: string[];
};

type Story = {
  id: string;
  importPath: string;
  name: string;
  title: string;
};

type StorySortFn = (a: Story, b: Story) => number;
```

Specifies the order in which stories are displayed in the Storybook UI.

When specifying a configuration object, the following options are available:

- **includeNames**: Whether to include the story name in the sorting algorithm. Defaults to `false`.
- **locales**: The locale to use when sorting stories. Defaults to your system locale.
- **method**: The sorting method to use. Defaults to `alphabetical`.
  - **alphabetical**: Sort stories alphabetically by name.
  - **alphabetical-by-kind**: Sort stories alphabetically by kind, then by name.
  - **custom**: Use a custom sorting function.
- **order**: Stories in the specified order will be displayed first, in the order specified. All other stories will be displayed after, in alphabetical order. The order array can accept a nested array to sort 2nd-level story kinds, e.g. `['Intro', 'Pages', ['Home', 'Login', 'Admin'], 'Components']`.

When specifying a custom sorting function, the function behaves like a typical JavaScript sorting function. It accepts two stories to compare and returns a number. For example:

```js
(a, b) => (a.id === b.id ? 0 : a.id.localeCompare(b.id, undefined, { numeric: true }));
```

See [the guide](https://storybook.js.org/docs/writing-stories/naming-components-and-hierarchy.md#sorting-stories) for usage examples.

### `test`

Type:

```ts
{
  clearMocks?: boolean;
  mockReset?: boolean;
  restoreMocks?: boolean;
  dangerouslyIgnoreUnhandledErrors?: boolean;
}
```

#### `clearMocks`

Type: `boolean`

Default: `false`

[Similar to Vitest](https://vitest.dev/config/#clearmocks), it will call `.mockClear()` on all spies created with `fn()` from `storybook/test` when a story unmounts. This will clear mock history, but not reset its implementation to the default one.

#### `mockReset`

Type: `boolean`

Default: `false`

[Similar to Vitest](https://vitest.dev/config/#mockreset), it will call `.mockReset()` on all spies created with `fn()` from `storybook/test` when a story unmounts. This will clear mock history and reset its implementation to an empty function (will return `undefined`).

#### `restoreMocks`

Type: `boolean`

Default: `true`

[Similar to Vitest](https://vitest.dev/config/#restoremocks), it will call `.restoreMocks()` on all spies created with `fn()` from `storybook/test` when a story unmounts. This will clear mock history and reset its implementation to the original one.

#### `dangerouslyIgnoreUnhandledErrors`

Type: `boolean`

Default: `false`

Unhandled errors might cause false positive assertions. Setting this to `true` will prevent the [play function](https://storybook.js.org/docs/writing-stories/play-function.md) from failing and showing a warning when unhandled errors are thrown during execution.

---

### Essentials

All other parameters are contributed by features. The [essential feature's](https://storybook.js.org/docs/essentials.md) parameters are documented on their individual pages:

- [Actions](https://storybook.js.org/docs/essentials/actions.md#parameters)
- [Backgrounds](https://storybook.js.org/docs/essentials/backgrounds.md#parameters)
- [Controls](https://storybook.js.org/docs/essentials/controls.md#parameters)
- [Highlight](https://storybook.js.org/docs/essentials/highlight.md#parameters)
- [Measure & Outline](https://storybook.js.org/docs/essentials/measure-and-outline.md#parameters)
- [Viewport](https://storybook.js.org/docs/essentials/viewport.md#parameters)

## Parameter inheritance

No matter where they're specified, parameters are ultimately applied to a single story. Parameters specified at the project (global) level are applied to every story in that project. Those specified at the meta (component) level are applied to every story associated with that meta. And parameters specified for a story only apply to that story.

When specifying parameters, they are merged together in order of increasing specificity:

1. Project (global) parameters
2. Meta (component) parameters
3. Story parameters

Parameters are **merged**, so objects are deep-merged, but arrays and other properties are overwritten.

In other words, the following specifications of parameters:

```js title=".storybook/preview.js"
const preview = {
  // 👇 Project-level parameters
  parameters: {
    layout: 'centered',
    demo: {
      demoProperty: 'a',
      demoArray: [1, 2],
    },
  },
  // ...
};
export default preview;
```

```js title="Dialog.stories.js|ts"
const meta = {
  component: Dialog,
  // 👇 Meta-level parameters
  parameters: {
    layout: 'fullscreen',
    demo: {
      demoProperty: 'b',
      anotherDemoProperty: 'b',
    },
  },
};
export default meta;

// (no additional parameters specified)
export const Basic = {};

export const LargeScreen = {
  // 👇 Story-level parameters
  parameters: {
    layout: 'padded',
    demo: {
      demoArray: [3, 4],
    },
  },
};
```

Will result in the following parameter values applied to each story:

```js
// Applied story parameters

// For the Basic story:
{
  layout: 'fullscreen',
  demo: {
    demoProperty: 'b',
    anotherDemoProperty: 'b',
    demoArray: [1, 2],
  },
}

// For the LargeScreen story:
{
  layout: 'padded',
  demo: {
    demoProperty: 'b',
    anotherDemoProperty: 'b',
    demoArray: [3, 4],
  },
}
```
