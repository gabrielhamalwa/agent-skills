# Styling and CSS

There are many ways to include CSS in a web application, and correspondingly there are many ways to include CSS in Storybook. Usually, it is best to try and replicate what your application does with styling in Storybook’s configuration.

## CSS

Storybook supports importing CSS files in a few different ways. Storybook will inject these tags into the preview iframe where your components render, not the Storybook Manager UI. The best way to import CSS depends on your project's configuration and your preferences.

### Import bundled CSS (recommended)

All Storybooks are pre-configured to recognize imports for CSS files. To add global CSS for all your stories, import it in [`.storybook/preview.ts|tsx`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering). These files will be subject to HMR, so you can see your changes without restarting your Storybook server.

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  parameters: {},
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  parameters: {},
});
```

If your component files import their CSS files, this will work too. However, if you're using CSS processor tools like Sass or Postcss, you may need some more configuration.

### Include static CSS

If you have a global CSS file that you want to include in all your stories, you can import it in [`.storybook/preview-head.html`](https://storybook.js.org/docs/configure/story-rendering.md#adding-to-head).
However, these files will not be subject to HMR, so you'll need to restart your Storybook server to see your changes.

```html
// .storybook/preview-head.html

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
  href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
  rel="stylesheet"
/>

<link rel="stylesheet" href="path/to/your/styles.css" />
```

## CSS modules

### Vite

Vite comes with CSS modules support out-of-the-box. If you have customized the CSS modules configuration in your `vite.config.js` this will automatically be applied to your Storybook as well. Read more about [Vite's CSS modules support](https://vitejs.dev/guide/features.html#css-modules).

### Webpack

Storybook recreates your Next.js configuration, so you can use CSS modules in your stories without any extra configuration.

If you're using Webpack and want to use CSS modules, you'll need some extra configuration. We recommend installing [`@storybook/addon-styling-webpack`](https://storybook.js.org/addons/@storybook/addon-styling-webpack/) to help you configure these tools.

## PostCSS

### Vite

Vite comes with PostCSS support out-of-the-box. If you have customized the PostCSS configuration in your `vite.config.js` this will automatically be applied to your Storybook as well. Read more about [Vite's PostCSS support](https://vitejs.dev/guide/features.html#postcss).

### Webpack

Storybook recreates your Next.js configuration, so you can use PostCSS in your stories without any extra configuration.

If you're using Webpack and want to use PostCSS, you'll need some extra configuration. We recommend installing [`@storybook/addon-styling-webpack`](https://storybook.js.org/addons/@storybook/addon-styling-webpack/) to help you configure these tools.

## CSS pre-processors

### Vite

Vite comes with Sass, Less, and Stylus support out-of-the-box. Read more about [Vite's CSS Pre-processor support](https://vitejs.dev/guide/features.html#css-pre-processors).

### Webpack

Storybook recreates your Next.js configuration, so you can use Sass in your stories without any extra configuration.

If you're using Webpack and want to use Sass or Less, you'll need some extra configuration. We recommend installing [`@storybook/addon-styling-webpack`](https://storybook.js.org/addons/@storybook/addon-styling-webpack/) to help you configure these tools. Or if you'd prefer, you can customize [Storybook's webpack configuration yourself](https://storybook.js.org/docs/builders/webpack.md#override-the-default-configuration) to include the appropriate loader(s).

## CSS-in-JS

CSS-in-JS libraries are designed to use basic JavaScript, and they often work in Storybook without any extra configuration. Some libraries expect components to render in a specific rendering “context” (for example, to provide themes), which can be accomplished with `@storybook/addon-themes`'s [`withThemeFromJSXProvider` decorator](https://github.com/storybookjs/storybook/blob/next/code/addons/themes/docs/api.md#withthemefromjsxprovider).

## Adding webfonts

### `.storybook/preview-head.html`

If you need webfonts to be available, you may need to add some code to the [`.storybook/preview-head.html`](https://storybook.js.org/docs/configure/story-rendering.md#adding-to-head) file. We recommend including any assets with your Storybook if possible, in which case you likely want to configure the [static file location](https://storybook.js.org/docs/configure/integration/images-and-assets.md#serving-static-files-via-storybook-configuration).

### `.storybook/preview.ts|tsx`

If you're using something like [`fontsource`](https://fontsource.org/) for your fonts, you can import the needed css files in your [`.storybook/preview.ts|tsx`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) file.
