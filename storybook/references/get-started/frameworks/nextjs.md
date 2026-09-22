# Storybook for Next.js with Webpack

Storybook for Next.js (Webpack) is a [framework](https://storybook.js.org/docs/contribute/framework.md) that makes it easy to develop and test UI components in isolation for [Next.js](https://nextjs.org/) applications using [Webpack 5](https://webpack.js.org/).

**We recommend using [`@storybook/nextjs-vite`](https://storybook.js.org/docs/get-started/frameworks/nextjs-vite.md)** for most Next.js projects. The Vite-based framework is faster, more modern, and offers better support for testing features.

Use this Webpack-based framework (`@storybook/nextjs`) only if:

- Your project has custom Webpack configurations that are incompatible with Vite
- Your project has custom Babel configurations that require Webpack
- You need specific Webpack features not available in Vite

## Install

To install Storybook in an existing Next.js project, run this command in your project's root directory:

```shell
npm create storybook@latest
```

```shell
pnpm create storybook@latest
```

```shell
yarn create storybook
```

The command will prompt you to choose between this framework and [`@storybook/nextjs-vite`](https://storybook.js.org/docs/get-started/frameworks/nextjs-vite.md). We recommend the Vite-based framework ([learn why](https://storybook.js.org/docs/get-started/frameworks/nextjs-vite.md#choose-between-vite-and-webpack)).

You can then get started [writing stories](https://storybook.js.org/docs/get-started/whats-a-story.md), [running tests](https://storybook.js.org/docs/writing-tests.md) and [documenting your components](https://storybook.js.org/docs/writing-docs.md). For more control over the installation process, refer to the [installation guide](https://storybook.js.org/docs/get-started/install.md).

### Requirements

## Run Storybook

To run Storybook for a particular project, run the following:

```shell
npm run storybook
```

```shell
pnpm run storybook
```

```shell
yarn storybook
```

To build Storybook, run:

```shell
npm run build-storybook
```

```shell
pnpm run build-storybook
```

```shell
yarn build-storybook
```

You will find the output in the configured `outputDir` (default is `storybook-static`).

## Configure

Storybook for Next.js supports many Next.js features including:

- 🖼 [Image optimization](#nextjss-image-component)
- 🔤 [Font optimization](#nextjs-font-optimization)
- 🔀 [Routing and navigation](#nextjs-routing)
- 🌐 [`next/head`](#nextjs-head)
- ⤵️ [Absolute imports](#imports)
- 🎨 [Styling](#styling)
- 🎭 [Module mocking](#mocking-modules)
- ☁️ [React Server Component (experimental)](#react-server-components-rsc)

### Next.js's Image component

This framework allows you to use Next.js's [next/image](https://nextjs.org/docs/pages/api-reference/components/image) with no configuration.

#### Local images

[Local images](https://nextjs.org/docs/pages/building-your-application/optimizing/images#local-images) are supported.

```jsx title="index.jsx"

function Home() {
  return (
    <>
      <h1>My Homepage</h1>
      
      <p>Welcome to my homepage!</p>
    </>
  );
}
```

#### Remote images

[Remote images](https://nextjs.org/docs/pages/building-your-application/optimizing/images#remote-images) are also supported.

```jsx title="index.jsx"

export default function Home() {
  return (
    <>
      <h1>My Homepage</h1>
      
      <p>Welcome to my homepage!</p>
    </>
  );
}
```

### Next.js font optimization

[next/font](https://nextjs.org/docs/pages/building-your-application/optimizing/fonts) is partially supported in Storybook. The packages `next/font/google` and `next/font/local` are supported.

#### `next/font/google`

You don't have to do anything. `next/font/google` is supported out of the box.

#### `next/font/local`

For local fonts you have to define the [src](https://nextjs.org/docs/pages/building-your-application/optimizing/fonts#local-fonts) property.
The path is relative to the directory where the font loader function is called.

If the following component defines your localFont like this:

```js title="src/components/MyComponent.js"

const localRubikStorm = localFont({ src: './fonts/RubikStorm-Regular.ttf' });
```

##### `staticDir` mapping

You have to tell Storybook where the `fonts` directory is located, via the [`staticDirs` configuration](https://storybook.js.org/docs/api/main-config/main-config-static-dirs.md#with-configuration-objects). The `from` value is relative to the `.storybook` directory. The `to` value is relative to the execution context of Storybook. Very likely it is the root of your project.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const config: StorybookConfig = {
  // ...
  staticDirs: [
    {
      from: '../src/components/fonts',
      to: 'src/components/fonts',
    },
  ],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with nextjs or nextjs-vite

export default defineMain({
  // ...
  staticDirs: [
    {
      from: '../src/components/fonts',
      to: 'src/components/fonts',
    },
  ],
});
```

#### Not supported features of `next/font`

The following features are not supported (yet). Support for these features might be planned for the future:

- [Support font loaders configuration in next.config.js](https://nextjs.org/docs/pages/building-your-application/optimizing/fonts#local-fonts)
- [fallback](https://nextjs.org/docs/pages/api-reference/components/font#fallback) option
- [adjustFontFallback](https://nextjs.org/docs/pages/api-reference/components/font#adjustfontfallback) option
- [preload](https://nextjs.org/docs/pages/api-reference/components/font#preload) option gets ignored. Storybook handles Font loading its own way.
- [display](https://nextjs.org/docs/pages/api-reference/components/font#display) option gets ignored. All fonts are loaded with display set to "block" to make Storybook load the font properly.

#### Mocking fonts during testing

Occasionally fetching fonts from Google may fail as part of your Storybook build step. It is highly recommended to mock these requests, as those failures can cause your pipeline to fail as well. Next.js [supports mocking fonts](https://github.com/vercel/next.js/blob/725ddc7371f80cca273779d37f961c3e20356f95/packages/font/src/google/fetch-css-from-google-fonts.ts#L36) via a JavaScript module located where the env var `NEXT_FONT_GOOGLE_MOCKED_RESPONSES` references.

For example, using [GitHub Actions](https://www.chromatic.com/docs/github-actions):

```yaml title=".github/workflows/ci.yml"
- uses: chromaui/action@latest
  env:
    #👇 the location of mocked fonts to use
    NEXT_FONT_GOOGLE_MOCKED_RESPONSES: ${{ github.workspace }}/mocked-google-fonts.js
  with:
    projectToken: ${{ secrets.CHROMATIC_PROJECT_TOKEN }}
    token: ${{ secrets.GITHUB_TOKEN }}
```

Your mocked fonts will look something like this:

```js title="mocked-google-fonts.js"
//👇 Mocked responses of google fonts with the URL as the key
module.exports = {
  'https://fonts.googleapis.com/css?family=Inter:wght@400;500;600;800&display=block': `
    /* cyrillic-ext */
    @font-face {
      font-family: 'Inter';
      font-style: normal;
      font-weight: 400;
      font-display: block;
      src: url(https://fonts.gstatic.com/s/inter/v12/UcCO3FwrK3iLTeHuS_fvQtMwCp50KnMw2boKoduKmMEVuLyfAZJhiJ-Ek-_EeAmM.woff2) format('woff2');
      unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;
    }
    /* more font declarations go here */
    /* latin */
    @font-face {
      font-family: 'Inter';
      font-style: normal;
      font-weight: 400;
      font-display: block;
      src: url(https://fonts.gstatic.com/s/inter/v12/UcCO3FwrK3iLTeHuS_fvQtMwCp50KnMw2boKoduKmMEVuLyfAZ9hiJ-Ek-_EeA.woff2) format('woff2');
      unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }`,
};
```

### Next.js routing

[Next.js's router](https://nextjs.org/docs/pages/building-your-application/routing) is automatically stubbed for you so that when the router is interacted with, all of its interactions are automatically logged to the [Actions panel](https://storybook.js.org/docs/essentials/actions.md).

You should only use `next/router` in the `pages` directory. In the `app` directory, it is necessary to use `next/navigation`.

#### Overriding defaults

Per-story overrides can be done by adding a `nextjs.router` property onto the story [parameters](https://storybook.js.org/docs/writing-stories/parameters.md). The framework will shallowly merge whatever you put here into the router.

```ts
// RouterBasedComponent.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const meta = {
  component: RouterBasedComponent,
} satisfies Meta<typeof RouterBasedComponent>;

export default meta;
type Story = StoryObj<typeof meta>;

// Interact with the links to see the route change events in the Actions panel.
export const Example: Story = {
  parameters: {
    nextjs: {
      router: {
        pathname: '/profile/[id]',
        asPath: '/profile/1',
        query: {
          id: '1',
        },
      },
    },
  },
};
```

```ts
// RouterBasedComponent.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: RouterBasedComponent,
});

// Interact with the links to see the route change events in the Actions panel.
export const Example = meta.story({
  parameters: {
    nextjs: {
      router: {
        pathname: '/profile/[id]',
        asPath: '/profile/1',
        query: {
          id: '1',
        },
      },
    },
  },
});
```

These overrides can also be applied to [all stories for a component](https://storybook.js.org/docs/api/parameters.md#meta-parameters) or [all stories in your project](https://storybook.js.org/docs/api/parameters.md#project-parameters). Standard [parameter inheritance](https://storybook.js.org/docs/api/parameters.md#parameter-inheritance) rules apply.

#### Default router

The default values on the stubbed router are as follows (see [globals](https://storybook.js.org/docs/essentials/toolbars-and-globals.md#globals) for more details on how globals work).

```ts
// Default router
const defaultRouter = {
  // The locale should be configured globally: https://storybook.js.org/docs/essentials/toolbars-and-globals#globals
  locale: globals?.locale,
  asPath: '/',
  basePath: '/',
  isFallback: false,
  isLocaleDomain: false,
  isReady: true,
  isPreview: false,
  route: '/',
  pathname: '/',
  query: {},
};
```

Additionally, the [`router` object](https://nextjs.org/docs/pages/api-reference/functions/use-router#router-object) contains all of the original methods (such as `push()`, `replace()`, etc.) as mock functions that can be manipulated and asserted on using [regular mock APIs](https://vitest.dev/api/mock.html).

To override these defaults, you can use [parameters](https://storybook.js.org/docs/writing-stories/parameters.md) and [`beforeEach`](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-modules.md#setting-up-and-cleaning-up):

```ts
// .storybook/preview.tsx — CSF 3
// Replace your-framework with nextjs or nextjs-vite

export default {
  parameters: {
    nextjs: {
      // 👇 Override the default router properties
      router: {
        basePath: '/app/',
      },
    },
  },
  async beforeEach() {
    // 👇 Manipulate the default router method mocks
    getRouter().push.mockImplementation(() => {
      /* ... */
    });
  },
};
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with nextjs or nextjs-vite

// 👇 Must include the `.mock` portion of filename to have mocks typed correctly

const preview = definePreview({
  parameters: {
    nextjs: {
      // 👇 Override the default router properties
      router: {
        basePath: '/app/',
      },
    },
  },
  async beforeEach() {
    // 👇 Manipulate the default router method mocks
    getRouter().push.mockImplementation(() => {
      /* ... */
    });
  },
});

export default preview;
```

### Next.js navigation

Please note that [`next/navigation`](https://nextjs.org/docs/app/building-your-application/routing) can only be used in components/pages in the `app` directory.

#### Set `nextjs.appDirectory` to `true`

If your story imports components that use `next/navigation`, you need to set the parameter `nextjs.appDirectory` to `true` in for that component's stories:

```ts
// NavigationBasedComponent.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const meta = {
  component: NavigationBasedComponent,
  parameters: {
    nextjs: {
      appDirectory: true, // 👈 Set this
    },
  },
} satisfies Meta<typeof NavigationBasedComponent>;
export default meta;
```

```ts
// NavigationBasedComponent.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: NavigationBasedComponent,
  parameters: {
    nextjs: {
      appDirectory: true, // 👈 Set this
    },
  },
});
```

If your Next.js project uses the `app` directory for every page (in other words, it does not have a `pages` directory), you can set the parameter `nextjs.appDirectory` to `true` in the [`.storybook/preview.tsx`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) file to apply it to all stories.

```ts
// .storybook/preview.tsx — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const preview: Preview = {
  // ...
  parameters: {
    // ...
    nextjs: {
      appDirectory: true,
    },
  },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with nextjs or nextjs-vite

export default definePreview({
  // ...
  parameters: {
    // ...
    nextjs: {
      appDirectory: true,
    },
  },
});
```

#### Overriding defaults

Per-story overrides can be done by adding a `nextjs.navigation` property onto the story [parameters](https://storybook.js.org/docs/writing-stories/parameters.md). The framework will shallowly merge whatever you put here into the router.

```ts
// NavigationBasedComponent.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const meta = {
  component: NavigationBasedComponent,
  parameters: {
    nextjs: {
      appDirectory: true,
    },
  },
} satisfies Meta<typeof NavigationBasedComponent>;
export default meta;

type Story = StoryObj<typeof meta>;

// Interact with the links to see the route change events in the Actions panel.
export const Example: Story = {
  parameters: {
    nextjs: {
      navigation: {
        pathname: '/profile',
        query: {
          user: '1',
        },
      },
    },
  },
};
```

```ts
// NavigationBasedComponent.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: NavigationBasedComponent,
  parameters: {
    nextjs: {
      appDirectory: true,
    },
  },
});

// Interact with the links to see the route change events in the Actions panel.
export const Example = meta.story({
  parameters: {
    nextjs: {
      navigation: {
        pathname: '/profile',
        query: {
          user: '1',
        },
      },
    },
  },
});
```

These overrides can also be applied to [all stories for a component](https://storybook.js.org/docs/api/parameters.md#meta-parameters) or [all stories in your project](https://storybook.js.org/docs/api/parameters.md#project-parameters). Standard [parameter inheritance](https://storybook.js.org/docs/api/parameters.md#parameter-inheritance) rules apply.

#### `useSelectedLayoutSegment`, `useSelectedLayoutSegments`, and `useParams` hooks

The `useSelectedLayoutSegment`, `useSelectedLayoutSegments`, and `useParams` hooks are supported in Storybook. You have to set the `nextjs.navigation.segments` parameter to return the segments or the params you want to use.

```ts
// NavigationBasedComponent.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const meta = {
  component: NavigationBasedComponent,
  parameters: {
    nextjs: {
      appDirectory: true,
      navigation: {
        segments: ['dashboard', 'analytics'],
      },
    },
  },
} satisfies Meta<typeof NavigationBasedComponent>;
export default meta;
```

```ts
// NavigationBasedComponent.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: NavigationBasedComponent,
  parameters: {
    nextjs: {
      appDirectory: true,
      navigation: {
        segments: ['dashboard', 'analytics'],
      },
    },
  },
});
```

With the above configuration, the component rendered in the stories would receive the following values from the hooks:

```js title="NavigationBasedComponent.js"

export default function NavigationBasedComponent() {
  const segment = useSelectedLayoutSegment(); // dashboard
  const segments = useSelectedLayoutSegments(); // ["dashboard", "analytics"]
  const params = useParams(); // {}
  // ...
}
```

To use `useParams`, you have to use a segments array where each element is an array containing two strings. The first string is the param key and the second string is the param value.

```ts
// NavigationBasedComponent.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const meta = {
  component: NavigationBasedComponent,
  parameters: {
    nextjs: {
      appDirectory: true,
      navigation: {
        segments: [
          ['slug', 'hello'],
          ['framework', 'nextjs'],
        ],
      },
    },
  },
} satisfies Meta<typeof NavigationBasedComponent>;
export default meta;
```

```ts
// NavigationBasedComponent.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: NavigationBasedComponent,
  parameters: {
    nextjs: {
      appDirectory: true,
      navigation: {
        segments: [
          ['slug', 'hello'],
          ['framework', 'nextjs'],
        ],
      },
    },
  },
});
```

With the above configuration, the component rendered in the stories would receive the following values from the hooks:

```js title="ParamsBasedComponent.js"

export default function ParamsBasedComponent() {
  const segment = useSelectedLayoutSegment(); // hello
  const segments = useSelectedLayoutSegments(); // ["hello", "nextjs"]
  const params = useParams(); // { slug: "hello", framework: "nextjs" }
  ...
}
```

These overrides can also be applied to [a single story](https://storybook.js.org/docs/api/parameters.md#story-parameters) or [all stories in your project](https://storybook.js.org/docs/api/parameters.md#project-parameters). Standard [parameter inheritance](https://storybook.js.org/docs/api/parameters.md#parameter-inheritance) rules apply.

The default value of `nextjs.navigation.segments` is `[]` if not set.

#### Default navigation context

The default values on the stubbed navigation context are as follows:

```ts
// Default navigation context
const defaultNavigationContext = {
  pathname: '/',
  query: {},
};
```

Additionally, the [`router` object](https://nextjs.org/docs/app/api-reference/functions/use-router#userouter) contains all of the original methods (such as `push()`, `replace()`, etc.) as mock functions that can be manipulated and asserted on using [regular mock APIs](https://vitest.dev/api/mock.html).

To override these defaults, you can use [parameters](https://storybook.js.org/docs/writing-stories/parameters.md) and [`beforeEach`](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-modules.md#setting-up-and-cleaning-up):

```ts
// .storybook/preview.tsx — CSF 3
// Replace your-framework with nextjs or nextjs-vite

export default {
  parameters: {
    nextjs: {
      // 👇 Override the default navigation properties
      navigation: {
        pathname: '/app/',
      },
    },
  },
  async beforeEach() {
    // 👇 Manipulate the default navigation method mocks
    getRouter().push.mockImplementation(() => {
      /* ... */
    });
  },
};
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with nextjs or nextjs-vite

// 👇 Must include the `.mock` portion of filename to have mocks typed correctly

const preview = definePreview({
  parameters: {
    nextjs: {
      // 👇 Override the default navigation properties
      navigation: {
        pathname: '/app/',
      },
    },
  },
  async beforeEach() {
    // 👇 Manipulate the default navigation method mocks
    getRouter().push.mockImplementation(() => {
      /* ... */
    });
  },
});

export default preview;
```

### Next.js Head

[`next/head`](https://nextjs.org/docs/pages/api-reference/components/head) is supported out of the box. You can use it in your stories like you would in your Next.js application. Please keep in mind, that the Head `children` are placed into the head element of the iframe that Storybook uses to render your stories.

## Next.js styling

### Sass/Scss

[Global Sass/SCSS stylesheets](https://nextjs.org/docs/pages/building-your-application/styling/sass) are also supported without any additional configuration. Just import them into [the preview config file](https://storybook.js.org/docs/configure/index.md#configure-story-rendering).

```ts
// .storybook/preview.tsx

```

This will automatically include any of your [custom Sass configurations](https://nextjs.org/docs/pages/building-your-application/styling/sass#customizing-sass-options) in your Next.js config file.

```ts
// next.config.ts

const config: NextConfig = {
  // Any options here are included in Sass compilation for your stories
  sassOptions: {
    includePaths: [path.join(process.cwd(), 'styles')],
  },
};

export default config;
```

### CSS/Sass/Scss Modules

[CSS modules](https://nextjs.org/docs/pages/building-your-application/styling/css-modules) work as expected.

```ts
// src/components/Button.ts
// This import will work in Storybook

// Sass/Scss modules are also supported
// import styles from './Button.module.scss'
// import styles from './Button.module.sass'

export function Button() {
  return (
    <button type="button" className={styles.error}>
      Destroy
    </button>
  );
}
```

### Styled JSX

The built-in CSS-in-JS solution for Next.js is [styled-jsx](https://nextjs.org/docs/pages/building-your-application/styling/css-in-js), and this framework supports that out of the box, too, with zero config.

```ts
// src/components/HelloWorld.ts
// This will work in Storybook
function HelloWorld() {
  return (
    <div>
      Hello world
      <p>scoped!</p>
      <style jsx>{`
        p {
          color: blue;
        }
        div {
          background: red;
        }
        @media (max-width: 600px) {
          div {
            background: blue;
          }
        }
      `}</style>
      <style global jsx>{`
        body {
          background: black;
        }
      `}</style>
    </div>
  );
}

export default HelloWorld;
```

You can use your own Babel config, too. This is an example of how you can customize styled-jsx.

```jsonc
// .babelrc (or whatever config file you use)
{
  "presets": [
    [
      "next/babel",
      {
        "styled-jsx": {
          "plugins": ["@styled-jsx/plugin-sass"],
        },
      },
    ],
  ],
}
```

### Tailwind

Tailwind in Next.js [is supported via PostCSS](https://nextjs.org/docs/app/getting-started/css#tailwind-css). Storybook will automatically handle the PostCSS config for you, including any custom PostCSS configuration, so that you can import your global CSS directly into [the preview config file](https://storybook.js.org/docs/configure/index.md#configure-story-rendering):

```ts
// .storybook/preview.tsx

```

### PostCSS

Next.js lets you [customize PostCSS config](https://nextjs.org/docs/pages/building-your-application/configuring/post-css). Thus this framework will automatically handle your PostCSS config for you.

### Imports

#### Absolute imports

[Absolute imports](https://nextjs.org/docs/pages/building-your-application/configuring/absolute-imports-and-module-aliases#absolute-imports) from the root directory are supported.

```jsx title="index.tsx"
// All good!

// Also good!

export default function HomePage() {
  return (
    <>
      <h1 className={styles.title}>Hello World</h1>
      
    </>
  );
}
```

Also OK for global styles in `.storybook/preview.tsx`!

```js title=".storybook/preview.tsx"

// ...
```

Absolute imports **cannot** be mocked in stories/tests. See the [Mocking modules](#mocking-modules) section for more information.

#### Module aliases

[Module aliases](https://nextjs.org/docs/app/building-your-application/configuring/absolute-imports-and-module-aliases#module-aliases) are also supported.

```jsx title="index.tsx"
// All good!

// Also good!

export default function HomePage() {
  return (
    <>
      <h1 className={styles.title}>Hello World</h1>
      
    </>
  );
}
```

#### Subpath imports

As an alternative to [module aliases](#module-aliases), you can use [subpath imports](https://nodejs.org/api/packages.html#subpath-imports) to import modules. This follows Node package standards and has benefits when [mocking modules](#mocking-modules).

To configure subpath imports, you define the `imports` property in your project's `package.json` file. This property maps the subpath to the actual file path. The example below configures subpath imports for all modules in the project:

```json title="package.json"
{
  "imports": {
    "#*": ["./*", "./*.ts", "./*.tsx"]
  }
}
```

Because subpath imports replace module aliases, you can remove the path aliases from your TypeScript configuration.

Which can then be used like this:

```jsx title="index.tsx"

export default function HomePage() {
  return (
    <>
      <h1 className={styles.title}>Hello World</h1>
      
    </>
  );
}
```

### Mocking modules

Components often depend on modules that are imported into the component file. These can be from external packages or internal to your project. When rendering those components in Storybook or testing them, you may want to [mock those modules](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-modules.md) to control and assert their behavior.

#### Built-in mocked modules

This framework provides mocks for many of Next.js' internal modules:

1. [`@storybook/nextjs/cache.mock`](#storybooknextjscachemock)
2. [`@storybook/nextjs/headers.mock`](#storybooknextjsheadersmock)
3. [`@storybook/nextjs/navigation.mock`](#storybooknextjsnavigationmock)
4. [`@storybook/nextjs/router.mock`](#storybooknextjsroutermock)

#### Mocking other modules

To mock other modules, use [automocking](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-modules.md#automocking) or one of the [alternative methods](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-modules.md#alternative-methods) documented in the mocking modules guide.

### Runtime config

Next.js allows for [Runtime Configuration](https://nextjs.org/docs/pages/api-reference/next-config-js/runtime-configuration) which lets you import a handy `getConfig` function to get certain configuration defined in your `next.config.js` file at runtime.

In the context of Storybook with this framework, you can expect Next.js's [Runtime Configuration](https://nextjs.org/docs/pages/api-reference/next-config-js/runtime-configuration) feature to work just fine.

Note, because Storybook doesn't server render your components, your components will only see what they normally see on the client side (i.e. they won't see `serverRuntimeConfig` but will see `publicRuntimeConfig`).

For example, consider the following Next.js config:

```js title="next.config.js"
module.exports = {
  serverRuntimeConfig: {
    mySecret: 'secret',
    secondSecret: process.env.SECOND_SECRET, // Pass through env variables
  },
  publicRuntimeConfig: {
    staticFolder: '/static',
  },
};
```

Calls to `getConfig` would return the following object when called within Storybook:

```jsonc
// Runtime config
{
  "serverRuntimeConfig": {},
  "publicRuntimeConfig": {
    "staticFolder": "/static",
  },
}
```

### Custom Webpack config

Next.js comes with a lot of things for free out of the box like Sass support, but sometimes you add [custom Webpack config modifications to Next.js](https://nextjs.org/docs/pages/api-reference/next-config-js/webpack). This framework takes care of most of the Webpack modifications you would want to add. If Next.js supports a feature out of the box, then that feature will work out of the box in Storybook. If Next.js doesn't support something out of the box, but makes it easy to configure, then this framework will do the same for that thing for Storybook.

Any Webpack modifications desired for Storybook should be made in [`.storybook/main.js|ts`](https://storybook.js.org/docs/builders/webpack.md#override-the-default-configuration).

Note: Not all Webpack modifications are copy/paste-able between `next.config.js` and `.storybook/main.js|ts`. It is recommended to do your research on how to properly make your modification to Storybook's Webpack config and on how [Webpack works](https://webpack.js.org/concepts/).

Below is an example of how to add SVGR support to Storybook with this framework.

```ts
// .storybook/main.ts — CSF 3

const config: StorybookConfig = {
  // ...
  webpackFinal: async (config) => {
    config.module = config.module || {};
    config.module.rules = config.module.rules || [];

    // This modifies the existing image rule to exclude .svg files
    // since you want to handle those files with @svgr/webpack
    const imageRule = config.module.rules.find((rule) => rule?.['test']?.test('.svg'));
    if (imageRule) {
      imageRule['exclude'] = /\.svg$/;
    }

    // Configure .svg files to be loaded with @svgr/webpack
    config.module.rules.push({
      test: /\.svg$/,
      use: ['@svgr/webpack'],
    });

    return config;
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with nextjs or nextjs-vite

export default defineMain({
  // ...
  webpackFinal: async (config) => {
    config.module = config.module || {};
    config.module.rules = config.module.rules || [];

    // This modifies the existing image rule to exclude .svg files
    // since you want to handle those files with @svgr/webpack
    const imageRule = config.module.rules.find((rule) => rule?.['test']?.test('.svg'));
    if (imageRule) {
      imageRule['exclude'] = /\.svg$/;
    }

    // Configure .svg files to be loaded with @svgr/webpack
    config.module.rules.push({
      test: /\.svg$/,
      use: ['@svgr/webpack'],
    });

    return config;
  },
});
```

### Typescript

Storybook handles most [Typescript](https://www.typescriptlang.org/) configurations, but this framework adds additional support for Next.js's support for [Absolute Imports and Module path aliases](https://nextjs.org/docs/pages/building-your-application/configuring/absolute-imports-and-module-aliases). In short, it takes into account your `tsconfig.json`'s [baseUrl](https://www.typescriptlang.org/tsconfig#baseUrl) and [paths](https://www.typescriptlang.org/tsconfig#paths). Thus, a `tsconfig.json` like the one below would work out of the box.

```json title="tsconfig.json"
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/components/*": ["components/*"]
    }
  }
}
```

### React Server Components (RSC)

(⚠️ **Experimental**)

If your app uses [React Server Components (RSC)](https://nextjs.org/docs/app/building-your-application/rendering/server-components), Storybook can render them in stories in the browser.

To enable this set the `experimentalRSC` feature flag in your `.storybook/main.js|ts` config:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const config: StorybookConfig = {
  // ...
  features: {
    experimentalRSC: true,
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with nextjs or nextjs-vite

export default defineMain({
  // ...
  features: {
    experimentalRSC: true,
  },
});
```

Setting this flag automatically wraps your story in a [Suspense](https://react.dev/reference/react/Suspense) wrapper, which is able to render asynchronous components in NextJS's version of React.

If this wrapper causes problems in any of your existing stories, you can selectively disable it using the `react.rsc` [parameter](https://storybook.js.org/docs/writing-stories/parameters.md) at the global/component/story level:

```ts
// MyServerComponent.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const meta = {
  component: MyServerComponent,
  parameters: {
    react: { rsc: false },
  },
} satisfies Meta<typeof MyServerComponent>;
export default meta;
```

```ts
// MyServerComponent.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: MyServerComponent,
  parameters: {
    react: { rsc: false },
  },
});
```

Note that wrapping your server components in Suspense does not help if your server components access server-side resources like the file system or Node-specific libraries. To work around this, you'll need to mock out your data access layer using [Webpack aliases](https://webpack.js.org/configuration/resolve/#resolvealias) or an addon like [storybook-addon-module-mock](https://storybook.js.org/addons/storybook-addon-module-mock).

If your server components access data via the network, we recommend using the [MSW Storybook Addon](https://storybook.js.org/addons/msw-storybook-addon) to mock network requests.

In the future we will provide better mocking support in Storybook and support for [Server Actions](https://nextjs.org/docs/app/api-reference/functions/server-actions).

## Notes for Yarn v2 and v3 users

If you're using [Yarn](https://yarnpkg.com/) v2 or v3, you may run into issues where Storybook can't resolve `style-loader` or `css-loader`. For example, you might get errors like:

```
Module not found: Error: Can't resolve 'css-loader'
Module not found: Error: Can't resolve 'style-loader'
```

This is because those versions of Yarn have different package resolution rules than Yarn v1.x. If this is the case for you, please install the package directly.

## FAQ

### How do I manually install the Next.js framework?

First, install the framework:

```shell
npm install --save-dev @storybook/nextjs
```

```shell
pnpm add --save-dev @storybook/nextjs
```

```shell
yarn add --dev @storybook/nextjs
```

Then, update your `.storybook/main.js|ts` to change the framework property:

```diff
// .storybook/main.ts — CSF 3
- import type { StorybookConfig } from '@storybook/your-previous-framework';
+ import type { StorybookConfig } from '@storybook/nextjs';

const config: StorybookConfig = {
  // ...
-  framework: '@storybook/react-webpack5',
+  framework: '@storybook/nextjs',
};

export default config;
```

```diff
// .storybook/main.ts — CSF Next 🧪
- import { defineMain } from '@storybook/your-previous-framework/node';
+ import { defineMain } from '@storybook/nextjs/node';

export default defineMain({
  // ...
-  framework: '@storybook/react-webpack5',
+  framework: '@storybook/nextjs',
});
```

Finally, if you were using Storybook plugins to integrate with Next.js, those are no longer necessary when using this framework and can be removed:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

const config: StorybookConfig = {
  // ...
  addons: [
    // ...
    // 👇 These can both be removed
    // 'storybook-addon-next',
    // 'storybook-addon-next-router',
  ],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with nextjs or nextjs-vite

export default defineMain({
  // ...
  addons: [
    // ...
    // 👇 These can both be removed
    // 'storybook-addon-next',
    // 'storybook-addon-next-router',
  ],
});
```

### How do I migrate to the Next.js Vite framework?

Please refer to the [migration instructions for `@storybook/nextjs-vite`](https://storybook.js.org/docs/get-started/frameworks/nextjs-vite.md#how-do-i-migrate-from-the-nextjs-webpack-5-addon).

### Stories for pages/components which fetch data

Next.js pages can fetch data directly within server components in the `app` directory, which often include module imports that only run in a Node.js environment. This does not (currently) work within Storybook, because if you import from a Next.js page file containing those node module imports in your stories, your Storybook's Webpack will crash because those modules will not run in a browser. To get around this, you can extract the component in your page file into a separate file and import that pure component in your stories. Or, if that's not feasible for some reason, you can [polyfill those modules](https://webpack.js.org/configuration/node/) in your Storybook's [`webpackFinal` configuration](https://storybook.js.org/docs/builders/webpack.md#override-the-default-configuration).

**Before**

```jsx title="app/my-page/index.jsx"
async function getData() {
  const res = await fetch(...);
  // ...
}

// Using this component in your stories will break the Storybook build
export default async function Page() {
  const data = await getData();

  return // ...
}
```

**After**

```jsx title="app/my-page/index.jsx"
// Use this component in your stories

async function getData() {
  const res = await fetch(...);
  // ...
}

export default async function Page() {
  const data = await getData();

  return ;
}
```

### Statically imported images won't load

Make sure you are treating image imports the same way you treat them when using `next/image` in normal development.

Before using this framework, image imports would import the raw path to the image (e.g. `'static/media/stories/assets/logo.svg'`). Now image imports work the "Next.js way", meaning that you now get an object when importing an image. For example:

```jsonc
// Image import object
{
  "src": "static/media/stories/assets/logo.svg",
  "height": 48,
  "width": 48,
  "blurDataURL": "static/media/stories/assets/logo.svg",
}
```

Therefore, if something in Storybook isn't showing the image properly, make sure you expect the object to be returned from an import instead of only the asset path.

See [local images](https://nextjs.org/docs/pages/building-your-application/optimizing/images#local-images) for more detail on how Next.js treats static image imports.

### Module not found: Error: Can't resolve `package name`

You might get this if you're using Yarn v2 or v3. See [Notes for Yarn v2 and v3 users](#notes-for-yarn-v2-and-v3-users) for more details.

### Should I use the Vite or Webpack version?

We recommend using [`@storybook/nextjs-vite`](https://storybook.js.org/docs/get-started/frameworks/nextjs-vite.md) (Vite-based) for most projects because it offers faster builds, better test support, and a simpler configuration. However, if your project has custom Webpack configurations that are incompatible with Vite, use this framework instead.

### Error: You are importing avif images, but you don't have sharp installed. You have to install sharp in order to use image optimization features in Next.js.

`sharp` is a dependency of Next.js's image optimization feature. If you see this error, you need to install `sharp` in your project.

```bash
npm install sharp
```

```bash
yarn add sharp
```

```bash
pnpm add sharp
```

You can refer to the [Install `sharp` to Use Built-In Image Optimization](https://nextjs.org/docs/messages/install-sharp) in the Next.js documentation for more information.

## API

### Modules

The `@storybook/nextjs` package exports several modules that enable you to [mock](#mocking-modules) Next.js's internal behavior.

#### `@storybook/nextjs/export-mocks`

Type: `{ getPackageAliases: ({ useESM?: boolean }) => void }`

`getPackageAliases` is a helper for generating the aliases needed to set up [portable stories](#portable-stories).

```ts title="jest.config.ts"

// 👇 Import the utility function

const createJestConfig = nextJest({
  // Provide the path to your Next.js app to load next.config.js and .env files in your test environment
  dir: './',
});

const config: Config = {
  testEnvironment: 'jsdom',
  // ... rest of Jest config
  moduleNameMapper: {
    ...getPackageAliases(), // 👈 Add the utility as mapped module names
  },
};

export default createJestConfig(config);
```

#### `@storybook/nextjs/cache.mock`

Type: `typeof import('next/cache')`

This module exports mocked implementations of the `next/cache` module's exports. You can use it to create your own mock implementations or assert on mock calls in a story's [play function](https://storybook.js.org/docs/writing-stories/play-function.md).

```ts
// MyForm.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

// 👇 Must include the `.mock` portion of filename to have mocks typed correctly

const meta = {
  component: MyForm,
} satisfies Meta<typeof MyForm>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Submitted: Story = {
  async play({ canvas, userEvent }) {
    const submitButton = canvas.getByRole('button', { name: /submit/i });
    await userEvent.click(saveButton);
    // 👇 Use any mock assertions on the function
    await expect(revalidatePath).toHaveBeenCalledWith('/');
  },
};
```

```ts
// MyForm.stories.ts — CSF Next 🧪

/*
 * Replace your-framework with nextjs or nextjs-vite
 * 👇 Must include the `.mock` portion of filename to have mocks typed correctly
 */

const meta = preview.meta({
  component: MyForm,
});

export const Submitted = meta.story({
  async play({ canvas, userEvent }) {
    const submitButton = canvas.getByRole('button', { name: /submit/i });
    await userEvent.click(saveButton);
    // 👇 Use any mock assertions on the function
    await expect(revalidatePath).toHaveBeenCalledWith('/');
  },
});
```

#### `@storybook/nextjs/headers.mock`

Type: [`cookies`](https://nextjs.org/docs/app/api-reference/functions/cookies#cookiessetname-value-options), [`headers`](https://nextjs.org/docs/app/api-reference/functions/headers) and [`draftMode`](https://nextjs.org/docs/app/api-reference/functions/draft-mode) from Next.js

This module exports _writable_ mocked implementations of the `next/headers` module's exports. You can use it to set up cookies or headers that are read in your story, and to later assert that they have been called.

Next.js's default [`headers()`](https://nextjs.org/docs/app/api-reference/functions/headers) export is read-only, but this module exposes methods allowing you to write to the headers:

- **`headers().append(name: string, value: string)`**: Appends the value to the header if it exists already.
- **`headers().delete(name: string)`**: Deletes the header
- **`headers().set(name: string, value: string)`**: Sets the header to the value provided.

For cookies, you can use the existing API to write them. E.g., `cookies().set('firstName', 'Jane')`.

Because `headers()`, `cookies()` and their sub-functions are all mocks you can use any [mock utilities](https://vitest.dev/api/mock.html) in your stories, like `headers().getAll.mock.calls`.

```ts
// MyForm.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

// 👇 Must include the `.mock` portion of filename to have mocks typed correctly

const meta = {
  component: MyForm,
} satisfies Meta<typeof MyForm>;

export default meta;
type Story = StoryObj<typeof meta>;

export const LoggedInEurope: Story = {
  async beforeEach() {
    // 👇 Set mock cookies, headers and draft mode ahead of rendering
    cookies().set('username', 'Sol');
    headers().set('timezone', 'Central European Summer Time');
    draftMode.mockReturnValue({
      isEnabled: true,
      enable: fn(),
      disable: fn(),
    });
  },
  async play() {
    // 👇 Assert that your component called the mocks
    await expect(cookies().get).toHaveBeenCalledOnce();
    await expect(cookies().get).toHaveBeenCalledWith('username');
    await expect(headers().get).toHaveBeenCalledOnce();
    await expect(headers().get).toHaveBeenCalledWith('timezone');
    await expect(draftMode).toHaveBeenCalled();
  },
};
```

```ts
// MyForm.stories.ts — CSF Next 🧪

/*
 * Replace your-framework with nextjs or nextjs-vite
 * 👇 Must include the `.mock` portion of filename to have mocks typed correctly
 */

const meta = preview.meta({
  component: MyForm,
});

export const LoggedInEurope = meta.story({
  async beforeEach() {
    // 👇 Set mock cookies, headers and draft mode ahead of rendering
    cookies().set('username', 'Sol');
    headers().set('timezone', 'Central European Summer Time');
    draftMode.mockReturnValue({
      isEnabled: true,
      enable: fn(),
      disable: fn(),
    });
  },
  async play() {
    // 👇 Assert that your component called the mocks
    await expect(cookies().get).toHaveBeenCalledOnce();
    await expect(cookies().get).toHaveBeenCalledWith('username');
    await expect(headers().get).toHaveBeenCalledOnce();
    await expect(headers().get).toHaveBeenCalledWith('timezone');
    await expect(draftMode).toHaveBeenCalled();
  },
});
```

#### `@storybook/nextjs/navigation.mock`

Type: `typeof import('next/navigation') & getRouter: () => ReturnType<typeof import('next/navigation')['useRouter']>`

This module exports mocked implementations of the `next/navigation` module's exports. It also exports a `getRouter` function that returns a mocked version of [Next.js's `router` object from `useRouter`](https://nextjs.org/docs/app/api-reference/functions/use-router#userouter), allowing the properties to be manipulated and asserted on. You can use it mock implementations or assert on mock calls in a story's [play function](https://storybook.js.org/docs/writing-stories/play-function.md).

```ts
// MyForm.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

// 👇 Must include the `.mock` portion of filename to have mocks typed correctly

const meta = {
  component: MyForm,
  parameters: {
    nextjs: {
      // 👇 As in the Next.js application, next/navigation only works using App Router
      appDirectory: true,
    },
  },
} satisfies Meta<typeof MyForm>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Unauthenticated: Story = {
  async play() {
    // 👇 Assert that your component called redirect()
    await expect(redirect).toHaveBeenCalledWith('/login', 'replace');
  },
};

export const GoBack: Story = {
  async play({ canvas, userEvent }) {
    const backBtn = await canvas.findByText('Go back');

    await userEvent.click(backBtn);
    // 👇 Assert that your component called back()
    await expect(getRouter().back).toHaveBeenCalled();
  },
};
```

```ts
// MyForm.stories.ts — CSF Next 🧪

/*
 * Replace your-framework with nextjs or nextjs-vite
 * 👇 Must include the `.mock` portion of filename to have mocks typed correctly
 */

const meta = preview.meta({
  component: MyForm,
  parameters: {
    nextjs: {
      // 👇 As in the Next.js application, next/navigation only works using App Router
      appDirectory: true,
    },
  },
});

export const Unauthenticated = meta.story({
  async play() {
    // 👇 Assert that your component called redirect()
    await expect(redirect).toHaveBeenCalledWith('/login', 'replace');
  },
});

export const GoBack = meta.story({
  async play({ canvas, userEvent }) {
    const backBtn = await canvas.findByText('Go back');

    await userEvent.click(backBtn);
    // 👇 Assert that your component called back()
    await expect(getRouter().back).toHaveBeenCalled();
  },
});
```

#### `@storybook/nextjs/router.mock`

Type: `typeof import('next/router') & getRouter: () => ReturnType<typeof import('next/router')['useRouter']>`

This module exports mocked implementations of the `next/router` module's exports. It also exports a `getRouter` function that returns a mocked version of [Next.js's `router` object from `useRouter`](https://nextjs.org/docs/pages/api-reference/functions/use-router#router-object), allowing the properties to be manipulated and asserted on. You can use it mock implementations or assert on mock calls in a story's [play function](https://storybook.js.org/docs/writing-stories/play-function.md).

```ts
// MyForm.stories.ts — CSF 3
// Replace your-framework with nextjs or nextjs-vite

// 👇 Must include the `.mock` portion of filename to have mocks typed correctly

const meta = {
  component: MyForm,
} satisfies Meta<typeof MyForm>;

export default meta;
type Story = StoryObj<typeof meta>;

export const GoBack: Story = {
  async play({ canvas, userEvent }) {
    const backBtn = await canvas.findByText('Go back');

    await userEvent.click(backBtn);
    // 👇 Assert that your component called back()
    await expect(getRouter().back).toHaveBeenCalled();
  },
};
```

```ts
// MyForm.stories.ts — CSF Next 🧪

/*
 * Replace your-framework with nextjs or nextjs-vite
 * 👇 Must include the `.mock` portion of filename to have mocks typed correctly
 */

const meta = preview.meta({
  component: MyForm,
});

export const GoBack = meta.story({
  async play({ canvas, userEvent }) {
    const backBtn = await canvas.findByText('Go back');

    await userEvent.click(backBtn);
    // 👇 Assert that your component called back()
    await expect(getRouter().back).toHaveBeenCalled();
  },
});
```

### Options

You can pass an options object for additional configuration if needed:

```ts
// .storybook/main.ts — CSF 3

// Replace your-framework with nextjs or nextjs-vite

const config: StorybookConfig = {
  // ...
  framework: {
    name: '@storybook/your-framework',
    options: {
      nextConfigPath: path.resolve(process.cwd(), 'next.config.js'),
    },
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪

// Replace your-framework with nextjs or nextjs-vite

export default defineMain({
  // ...
  framework: {
    name: '@storybook/your-framework',
    options: {
      nextConfigPath: path.resolve(process.cwd(), 'next.config.js'),
    },
  },
});
```

The available options are:

#### `builder`

Type: `Record<string, any>`

Configure options for the [framework's builder](https://storybook.js.org/docs/api/main-config/main-config-framework.md#optionsbuilder). For Next.js, available options can be found in the [Webpack builder docs](https://storybook.js.org/docs/builders/webpack.md).

#### `nextConfigPath`

Type: `string`

The absolute path to the `next.config.js` file. This is necessary if you have a custom `next.config.js` file that is not in the root directory of your project.

### Parameters

This framework contributes the following [parameters](https://storybook.js.org/docs/writing-stories/parameters.md) to Storybook, under the `nextjs` namespace:

#### `image`

Type: `object`

Props to pass to every instance of `next/image`. See [next/image docs](https://nextjs.org/docs/pages/api-reference/components/image) for more details.

#### `appDirectory`

Type: `boolean`

Default: `false`

If your story imports components that use `next/navigation`, you need to set the parameter `nextjs.appDirectory` to `true`. Because this is a parameter, you can apply it to a [single story](https://storybook.js.org/docs/api/parameters.md#story-parameters), [all stories for a component](https://storybook.js.org/docs/api/parameters.md#meta-parameters), or [every story in your Storybook](https://storybook.js.org/docs/api/parameters.md#project-parameters). See [Next.js Navigation](#nextjs-navigation) for more details.

#### `navigation`

Type:

```ts
{
  asPath?: string;
  pathname?: string;
  query?: Record<string, string>;
  segments?: (string | [string, string])[];
}
```

Default value:

```js
{
  segments: [];
}
```

The router object that is passed to the `next/navigation` context. See [Next.js's navigation docs](https://nextjs.org/docs/app/building-your-application/routing) for more details.

#### `router`

Type:

```ts
{
  asPath?: string;
  pathname?: string;
  query?: Record<string, string>;
}
```

The router object that is passed to the `next/router` context. See [Next.js's router docs](https://nextjs.org/docs/pages/building-your-application/routing) for more details.
