# Setup Storybook

Now that you’ve learned what stories are and how to browse them, let’s demo working on one of your components.

Pick a simple component from your project, like a Button, and write a `.stories.js`, `.stories.ts`, or `.stories.svelte` file to go along with it. It might look something like this:

```ts
// YourComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

//👇 This default export determines where your story goes in the story list
const meta = {
  component: YourComponent,
} satisfies Meta<typeof YourComponent>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Basic: Story = {
  args: {
    //👇 The args you need here will depend on your component
  },
};
```

```ts
// YourComponent.stories.ts|tsx — CSF Next 🧪

//👇 This default export determines where your story goes in the story list
const meta = preview.meta({
  component: YourComponent,
});

export const Basic = meta.story({
  args: {
    //👇 The args you need here will depend on your component
  },
});
```

Go to your Storybook to view the rendered component. It’s OK if it looks a bit unusual right now.

Depending on your technology stack, you also might need to configure the Storybook environment further.

## Render component styles

Storybook isn’t opinionated about how you generate or load CSS. It renders whatever DOM elements you provide. But sometimes, things won’t “look right” out of the box.

You may have to configure your CSS tooling for Storybook’s rendering environment. Here are some setup guides for popular tools in the community.

- [Tailwind](https://storybook.js.org/recipes/tailwindcss/)
- [Material UI](https://storybook.js.org/recipes/@mui/material/)
- [Vuetify](https://storybook.js.org/recipes/vuetify/)
- [Styled Components](https://storybook.js.org/recipes/styled-components/)
- [Emotion](https://storybook.js.org/recipes/@emotion/styled/)
- [Sass](https://storybook.js.org/recipes/sass/)
- [Bootstrap](https://storybook.js.org/recipes/bootstrap/)
- [Less](https://storybook.js.org/recipes/less/)
- [Vanilla-extract](https://storybook.js.org/recipes/@vanilla-extract/css/)

Don't see the tool that you're looking for? Check out the [styling and css](https://storybook.js.org/docs/configure/styling-and-css.md) page for more details.

## Configure Storybook for your stack

Storybook comes with a permissive [default configuration](https://storybook.js.org/docs/configure.md). It attempts to customize itself to fit your setup. But it’s not foolproof.

Your project may have additional requirements before components can be rendered in isolation. This warrants customizing configuration further. There are three broad categories of configuration you might need.

<details>
<summary>Build configuration like Webpack and Babel</summary>

If you see errors on the CLI when you run the `yarn storybook` command, you likely need to make changes to Storybook’s build configuration. Here are some things to try:

- [Presets](https://storybook.js.org/docs/addons/addon-types.md) bundle common configurations for various technologies into Storybook. In particular, presets exist for Create React App and Ant Design.
- Specify a custom [Babel configuration](https://storybook.js.org/docs/configure/integration/compilers.md#babel) for Storybook. Storybook automatically tries to use your project’s config if it can.
- Adjust the [Webpack configuration](https://storybook.js.org/docs/builders/webpack.md) that Storybook uses. Try patching in your own configuration if needed.

</details>

<details>
<summary>Runtime configuration</summary>

If Storybook builds but you see an error immediately when connecting to it in the browser, in that case, chances are one of your input files is not compiling/transpiling correctly to be interpreted by the browser. Storybook supports evergreen browsers, but you may need to check the Babel and Webpack settings (see above) to ensure your component code works correctly.

</details>

<details id="component-context" name="component-context">
<summary>Component context</summary>

If a particular story has a problem rendering, often it means your component expects a specific environment is available to the component.

A common frontend pattern is for components to assume that they render in a specific “context” with parent components higher up the rendering hierarchy (for instance, theme providers).

Use [decorators](https://storybook.js.org/docs/writing-stories/decorators.md) to “wrap” every story in the necessary context providers. The [`.storybook/preview.*`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) file allows you to customize how components render in Canvas, the preview iframe. This file can be written in JavaScript (`preview.jsx`) or TypeScript (`preview.tsx`). See how you can wrap every component rendered in Storybook with [Styled Components](https://styled-components.com/) `ThemeProvider`, [Vue's Vuetify](https://vuetifyjs.com/en/), Svelte's [Bits UI](https://bits-ui.com/) `BitsConfig`, or with an Angular theme provider component in the example below.

Use [decorators](https://storybook.js.org/docs/writing-stories/decorators.md) to “wrap” every story in the necessary context providers. The [`.storybook/preview.*`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) file allows you to customize how components render in Canvas, the preview iframe. This file can be written in JavaScript (`preview.js`) or TypeScript (`preview.ts`). See how you can wrap every component rendered in Storybook with [Styled Components](https://styled-components.com/) `ThemeProvider`, [Vue's Vuetify](https://vuetifyjs.com/en/), Svelte's [Bits UI](https://bits-ui.com/) `BitsConfig`, or with an Angular theme provider component in the example below.

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

</details>

## Load assets and resources

We recommend serving external resources and assets requested in your components statically with Storybook. It ensures that assets are always available to your stories. Read our [documentation](https://storybook.js.org/docs/configure/integration/images-and-assets.md) to learn how to host static files with Storybook.
