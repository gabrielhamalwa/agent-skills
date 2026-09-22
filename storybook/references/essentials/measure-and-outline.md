# Measure & outline

Storybook's measure and outline features give you the necessary tooling to inspect and visually debug CSS layout and alignment issues within your stories. It makes it easy to catch UI bugs early in development.

## Measure

While working with composite components or page layouts, dealing with whitespace (i.e., `margin`, `padding`, `border`) and individual component measurements can be tedious. It would require that you open up the browser's development tools and manually inspect the DOM tree for issues and UI bugs.

Instead, you can quickly visualize each component's measurements by clicking the measure button in the toolbar. Now when you hover over an element in your story, that element's dimensions and any whitespace (i.e., `margin`, `padding`, `border`) will be shown.

![Measure feature enabled displaying the component's dimensions](../_assets/essentials/addon-measure.png)

Alternatively you can press the `m` key on your keyboard to toggle measure on and off.

## Outline

When building your layouts, checking the visual alignment of all components can be pretty complicated, especially if your components are spread apart or contain unique shapes.

Click the outline button in the toolbar to toggle the outlines associated with all your UI elements, allowing you to spot bugs and broken layouts instantly.

![Outline feature enabled on the component's story](../_assets/essentials/addon-outline.png)

## Disable the features

If you want to turn off measure or outline for a story, you can do so by configuring the `measure` or `outline` parameter, like so:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Large: Story = {
  parameters: {
    measure: { disable: true },
    outline: { disable: true },
  },
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

export const Large = meta.story({
  parameters: {
    measure: { disable: true },
    outline: { disable: true },
  },
});
```

To disable either feature across your entire Storybook instead, [do so in your main configuration file](https://storybook.js.org/docs/essentials/index.md#disabling-features).

## API

### Parameters

These features contribute the following [parameters](https://storybook.js.org/docs/writing-stories/parameters.md) to Storybook, under the `measure` or `outline` namespace:

#### `disable`

Type: `boolean`

Removes the tool from the toolbar and disables the feature's behavior. If you wish to disable the feature for the entire Storybook, you should [do so in your main configuration file](https://storybook.js.org/docs/essentials/index.md#disabling-features).

This parameter is most useful to allow overriding at more specific levels. For example, if this parameter is set to `true` at the project level, it could then be re-enabled by setting it to `false` at the meta (component) or story level.
