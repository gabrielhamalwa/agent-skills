# Story rendering

In Storybook, your stories render in a particular “preview” iframe (also called the Canvas) inside the larger Storybook web application. The JavaScript build configuration of the preview is controlled by a [builder](https://storybook.js.org/docs/builders.md) config, but you also may want to run some code for every story or directly control the rendered HTML to help your stories render correctly.

## Running code for every story

Code executed in the preview file (`.storybook/preview.ts|tsx`) runs for every story in your Storybook. This is useful for setting up global styles, initializing libraries, or anything else required to render your components.

Here's an example of how you might use the preview file to initialize a library that must run before your components render:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

initialize();

const preview: Preview = {
  // ...
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using, e.g. nextjs, nextjs-vite, react-vite, etc.

initialize();

const preview = definePreview({
  // ...
});

export default preview;
```

For example, with Vue, you can extend Storybook's application and register your library (e.g., [Fontawesome](https://github.com/FortAwesome/vue-fontawesome)). Or with Angular, add the package ([localize](https://angular.io/api/localize)) into your `polyfills.ts` and import it:

## Adding to \<head>

If you need to add extra elements to the `head` of the preview iframe, for instance, to load static stylesheets, font files, or similar, you can create a file called [`.storybook/preview-head.html`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) and add tags like this:

```html
// .storybook/preview-head.html

<link rel="preload" href="/fonts/my-font.woff2" />

<script src="https://use.typekit.net/xxxyyy.js"></script>
<script>
  try {
    Typekit.load();
  } catch (e) {}
</script>
```

Storybook will inject these tags into the _preview iframe_ where your components render, not the Storybook application UI.

However, it's also possible to modify the preview head HTML programmatically using a preset defined in the `main.js` file. Read the [presets documentation](https://storybook.js.org/docs/addons/writing-presets.md#ui-configuration) for more information.

## Adding to \<body>

Sometimes, you may need to add different tags to the `<body>`. Helpful for adding some custom content roots.

You can accomplish this by creating a file called `preview-body.html` inside your `.storybook` directory and adding tags like this:

```html
// .storybook/preview-body.html
<div id="custom-root"></div>
```

If using relative sizing in your project (like `rem` or `em`), you may update the base `font-size` by adding a `style` tag to `preview-body.html`:

```html
// .storybook/preview-body.html
<style>
  html {
    font-size: 15px;
  }
</style>
```

Storybook will inject these tags into the _preview iframe_ where your components render, not the Storybook application UI.

Just like how you have the ability to customize the preview `head` HTML tag, you can also follow the same steps to customize the preview `body` with a preset. To obtain more information on how to do this, refer to the [presets documentation](https://storybook.js.org/docs/addons/writing-presets.md#ui-configuration).
