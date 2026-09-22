# Images, fonts, and assets

Components often rely on images, videos, fonts, and other assets to render as the user expects. There are many ways to use these assets in your story files.

## Import assets into stories

You can import any media assets by importing (or requiring) them. It works out of the box with our default config. But, if you are using a custom webpack config, you’ll need to add the [file loader](https://webpack.js.org/loaders/) to handle the required files.

Afterward, you can use any asset in your stories:

```tsx
// MyComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: MyComponent,
} satisfies Meta<typeof MyComponent>;

export default meta;
type Story = StoryObj<typeof meta>;

const image = {
  src: imageFile,
  alt: 'my image',
};

export const WithAnImage: Story = {
  render: () => <img src={image.src} alt={image.alt} />,
};
```

```tsx
// MyComponent.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: MyComponent,
});

const image = {
  src: imageFile,
  alt: 'my image',
};

export const WithAnImage = meta.story({
  render: () => <img src={image.src} alt={image.alt} />,
});
```

## Serving static files via Storybook Configuration

We recommend serving static files via Storybook to ensure that your components always have the assets they need to load. We recommend this technique for assets that your components often use, like logos, fonts, and icons.

Configure a directory (or a list of directories) where your assets live when starting Storybook. Use the `staticDirs` configuration element in your main Storybook configuration file (i.e., `.storybook/main.js|ts`) to specify the directories:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  staticDirs: ['../public', '../static'],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  staticDirs: ['../public', '../static'],
});
```

Here `../public` is your static directory. Now use it in a component or story like this.

```tsx
// MyComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: MyComponent,
} satisfies Meta<typeof MyComponent>;

export default meta;
type Story = StoryObj<typeof meta>;

// Assume image.png is located in the "public" directory.
export const WithAnImage: Story = {
  render: () => <img src="/image.png" alt="my image" />,
};
```

```tsx
// MyComponent.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: MyComponent,
});

// Assume image.png is located in the "public" directory.
export const WithAnImage = meta.story({
  render: () => <img src="/image.png" alt="my image" />,
});
```

You can also pass a list of directories separated by commas without spaces instead of a single directory.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  staticDirs: ['../public', '../static'],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  staticDirs: ['../public', '../static'],
});
```

Or even use a configuration object to define the directories:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  staticDirs: [{ from: '../my-custom-assets/images', to: '/assets' }],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  staticDirs: [{ from: '../my-custom-assets/images', to: '/assets' }],
});
```

When using Vite-based frameworks, additional directories may be copied to your build directory because of Vite's own [static asset handling](https://vite.dev/guide/assets#the-public-directory). You can set Vite's `publicDir` option to `false` to disable this behavior.

## Reference assets from a CDN

Upload your files to an online CDN and reference them. In this example, we’re using a placeholder image service.

```tsx
// MyComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: MyComponent,
} satisfies Meta<typeof MyComponent>;

export default meta;
type Story = StoryObj<typeof meta>;

export const WithAnImage: Story = {
  render: () => (
    <img src="https://storybook.js.org/images/placeholders/350x150.png" alt="My CDN placeholder" />
  ),
};
```

```tsx
// MyComponent.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: MyComponent,
});

export const WithAnImage = meta.story({
  render: () => (
    <img src="https://storybook.js.org/images/placeholders/350x150.png" alt="My CDN placeholder" />
  ),
});
```

## Absolute versus relative paths

Sometimes, you may want to deploy your Storybook into a subpath, like `https://example.com/storybook`.

In this case, you need to have all your images and media files with relative paths. Otherwise, the browser cannot locate those files.

If you load static content via importing, this is automatic, and you do not have to do anything.

Suppose you are serving assets in a [static directory](#serving-static-files-via-storybook-configuration) along with your Storybook. In that case, you need to use relative paths to load images or use the base element.

## Referencing Fonts in Stories

After configuring Storybook to serve assets from your static folder, you can reference those assets in Storybook. For example, you can reference and apply a custom font to your stories. To do this, create a [`preview-head.html`](https://storybook.js.org/docs/configure/story-rendering.md) file inside the configuration directory (i.e., `.storybook`) and add a `<link />` tag to reference your font.

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
