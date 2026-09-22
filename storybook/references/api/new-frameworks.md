# Frameworks

Storybook is architected to support diverse web frameworks, including React, Vue, Angular, Web Components, Svelte, and over a dozen others. This guide helps you get started on adding new framework support for Storybook.

## Scaffolding a new framework

The first thing to do is to scaffold your framework support in its own repo.

We recommend adopting the same project structure as the Storybook monorepo. That structure contains the framework package (`app/<framework>`) and an example app (`examples/<framework>-kitchen-sink`) as well as other associated documentation and configuration as needed.

It may seem like a little more hierarchy than what’s necessary. But because the structure mirrors the way Storybook’s monorepo is structured, you can reuse Storybook’s tooling. It also makes it easier to move the framework into the Storybook monorepo later if that is desirable.

We recommend using `@storybook/html` as a starter framework since it’s the simplest and contains no framework-specific peculiarities. There is a boilerplate to get you started [here](https://github.com/CodeByAlex/storybook-framework-boilerplate).

## Framework architecture

Supporting a new framework in Storybook typically consists of two main aspects:

1. Configuring the server. In Storybook, the server is the node process that runs when you run `storybook dev` or `storybook build`. Configuring the server typically means configuring babel and webpack in framework-specific ways.

2. Configuring the client. The client is the code that runs in the browser, and configuring it, means providing a framework-specific story rendering function.

## Configuring the server

Storybook has the concept of [presets](https://storybook.js.org/docs/addons/writing-presets.md), which are typically babel/webpack configurations for file loading. If your framework has its own file format (e.g., “.vue”), you might need to transform them into JavaScript files at load time. If you assume every user of your framework needs this, you should add it to the framework. So far, every framework added to Storybook has done it because Storybook’s core configuration is extremely minimal.

### Package structure

It's helpful to understand Storybook's package structure before adding a framework preset. Each framework typically exposes two executables in its `package.json`:

```json title="package.json"
{
  "bin": {
    "storybook": "./bin/index.js",
    "build-storybook": "./bin/build.js"
  }
}
```

These scripts pass an `options` object to `storybook/internal/server`, a library that abstracts all of Storybook’s framework-independent code.

For example, here’s the boilerplate to start the dev server with `storybook dev`:

```ts
// your-framework/src/server/index.ts

buildDev(options);
```

Thus the essence of adding framework presets is just filling in that options object.

### Server options

As described above, the server `options` object does the heavy lifting of configuring the server.

Let’s look at the `@storybook/vue`’s options definition:

```ts
// vue/src/server/options.ts

export default {
  packageJson: JSON.parse(readFileSync(pkg.up({ cwd: process.cwd() }))),
  framework: 'vue',
  frameworkPresets: [import.meta.resolve('./framework-preset-vue.js')],
};
```

The value of the `framework` option (i.e., ‘vue’) is something that gets passed to addons and allows them to do specific tasks related to your framework.

The essence of this file is the framework presets, and these are standard [Storybook presets](https://storybook.js.org/docs/addons/writing-presets.md) -- you can look at framework packages in the Storybook monorepo (e.g. [React](https://github.com/storybookjs/storybook/blob/next/code/frameworks/react-vite/src/preset.ts), [Vue](https://github.com/storybookjs/storybook/blob/next/code/frameworks/vue3-vite/src/preset.ts), [Web Components](https://github.com/storybookjs/storybook/blob/next/code/frameworks/web-components-vite/src/preset.ts)) to see examples of framework-specific customizations.

While developing your custom framework, not maintained by Storybook, you can specify the path to the location file with the `frameworkPath` key:

```ts
// my-framework/src/server/options.ts

export default {
  packageJson: JSON.parse(readFileSync(pkg.up({ cwd: process.cwd() }))),
  framework: 'my-framework',
  frameworkPath: '@my-framework/storybook',
  frameworkPresets: [import.meta.resolve('./framework-preset-my-framework.js')],
};
```

You can add a relative path to `frameworkPath`. Don't forget that they resolve from the Storybook configuration directory (i.e., `.storybook`) by default.

Make sure the `frameworkPath` ends up at the `dist/client/index.js` file within your framework app.

## Configuring the client

To configure the client, you must provide a framework-specific render function. Before diving into the details, it’s essential to understand how user-written stories relate to what renders on the screen.

### Renderable objects

Storybook stories are ES6 objects that return a “renderable object.”

Consider the following React story:

```js
// Button.stories.js|jsx

export default {
  component: Button,
};

export const Sample = {
  render: () => ,
};
```

In this case, the renderable object is the React element, ``.

In most other frameworks, the renderable object is actually a plain JavaScript object.

Consider the following hypothetical example:

```ts
// Button.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Sample: Story = {
  render: () => ({
    template: '<button :label=label />',
    data: {
      label: 'hello button',
    },
  }),
};
```

```ts
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: Button,
});

export const Sample = meta.story({
  render: () => ({
    template: '<button :label=label />',
    data: {
      label: 'hello button',
    },
  }),
});
```

The design of this “renderable object” is framework-specific and should ideally match the idioms of that framework.

### Render function

The framework's render function is the entity responsible for converting the renderable object into DOM nodes. It is typically of the form:

```js
// your-framework/src/client/preview/render.ts
const rootElement = document.getElementById('root');

export default function renderMain({ storyFn }: RenderMainArgs) {
  const storyObj = storyFn();
  const html = fn(storyObj);
  rootElement.innerHTML = html;
}
```

### Package structure

On the client side, the key file is [`src/client/preview.js`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering):

```ts
// your-framework/src/client/preview/index.ts

const api = start(render);

// the boilerplate code
```

The globals file typically sets up a single global variable that client-side code (such as addon-provided decorators) can refer to if needed to understand which framework it's running in:

```ts
// vue/src/client/preview/globals.ts

const { window: globalWindow } = global;

globalWindow.STORYBOOK_ENV = 'vue';
```

The `start` function abstracts all of Storybook’s framework-independent client-side (browser) code, and it takes the render function we defined above. For examples of render functions, see [React](https://github.com/storybookjs/storybook/blob/next/code/renderers/react/src/render.tsx), [Vue](https://github.com/storybookjs/storybook/blob/next/code/renderers/vue3/src/render.ts), [Angular](https://github.com/storybookjs/storybook/blob/next/code/frameworks/angular/src/client/render.ts), and [Web Components](https://github.com/storybookjs/storybook/blob/next/code/renderers/web-components/src/render.ts) in the Storybook monorepo.
