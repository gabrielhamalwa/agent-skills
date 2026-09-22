# Client-Side Setup

<Warning>You are viewing the documentation for Inertia.js v2. Inertia.js v3 has been released and is now the default version. Please visit the [upgrade guide](/docs/v3/getting-started/upgrade-guide) to get started.</Warning>

Once you have your [server-side framework configured](/docs/v2/installation/server-side-setup), you then need to setup your client-side framework. Inertia currently provides support for React, Vue, and Svelte.

<Card icon="laravel" title="Laravel Starter Kits" href="https://laravel.com/docs/starter-kits" arrow="true" cta="Start building">
  Laravel's starter kits provide out-of-the-box scaffolding for new Inertia applications.

  These starter kits are the absolute fastest way to start building a new Inertia project using Laravel and Vue or React. However, if you would like to manually install Inertia into your application, please consult the documentation below.
</Card>

## Prerequisites

Before installing Inertia, you need your client-side framework and its corresponding [Vite plugin](https://laravel.com/docs/vite#vue) installed and configured. You may skip this section if your application already has these set up.

<CodeGroup>
  ```bash Vue icon="vuejs" theme={null}
  npm install vue @vitejs/plugin-vue
  ```

  ```bash React icon="react" theme={null}
  npm install react react-dom @vitejs/plugin-react
  ```

  ```bash Svelte icon="s" theme={null}
  npm install svelte @sveltejs/vite-plugin-svelte
  ```
</CodeGroup>

Then, add the framework plugin to your `vite.config.js` file.

<CodeGroup>
  ```js Vue icon="vuejs" theme={null}
  import { defineConfig } from 'vite'
  import laravel from 'laravel-vite-plugin'
  import vue from '@vitejs/plugin-vue'

  export default defineConfig({
      plugins: [
          laravel({
              input: ['resources/js/app.js'],
              refresh: true,
          }),
          vue(),
      ],
  })
  ```

  ```js React icon="react" theme={null}
  import { defineConfig } from 'vite'
  import laravel from 'laravel-vite-plugin'
  import react from '@vitejs/plugin-react'

  export default defineConfig({
      plugins: [
          laravel({
              input: ['resources/js/app.jsx'],
              refresh: true,
          }),
          react(),
      ],
  })
  ```

  ```js Svelte icon="s" theme={null}
  import { defineConfig } from 'vite'
  import laravel from 'laravel-vite-plugin'
  import { svelte } from '@sveltejs/vite-plugin-svelte'

  export default defineConfig({
      plugins: [
          laravel({
              input: ['resources/js/app.js'],
              refresh: true,
          }),
          svelte(),
      ],
  })
  ```
</CodeGroup>

For more information on configuring these plugins, consult Laravel's [Vite documentation](https://laravel.com/docs/vite#vue).

## Installation

<Steps>
  <Step title="Install dependencies">
    Install the Inertia client-side adapter corresponding to your framework of choice.

    <CodeGroup>
      ```bash Vue icon="vuejs" theme={null}
      npm install @inertiajs/vue3
      ```

      ```bash React icon="react" theme={null}
      npm install @inertiajs/react
      ```

      ```bash Svelte icon="s" theme={null}
      npm install @inertiajs/svelte
      ```
    </CodeGroup>
  </Step>

  <Step title="Initialize the Inertia app">
    Next, update your main JavaScript file to boot your Inertia app. To accomplish this, we'll initialize the client-side framework with the base Inertia component.

    <CodeGroup>
      ```js Vue icon="vuejs" theme={null}
      import { createApp, h } from 'vue'
      import { createInertiaApp } from '@inertiajs/vue3'

      createInertiaApp({
          resolve: name => {
              const pages = import.meta.glob('./Pages/**/*.vue', { eager: true })
              return pages[`./Pages/${name}.vue`]
          },
          setup({ el, App, props, plugin }) {
              createApp({ render: () => h(App, props) })
                  .use(plugin)
                  .mount(el)
          },
      })
      ```

      ```jsx React icon="react" theme={null}
      import { createInertiaApp } from '@inertiajs/react'
      import { createRoot } from 'react-dom/client'

      createInertiaApp({
          resolve: name => {
              const pages = import.meta.glob('./Pages/**/*.jsx', { eager: true })
              return pages[`./Pages/${name}.jsx`]
          },
          setup({ el, App, props }) {
              createRoot(el).render(<App {...props} />)
          },
      })
      ```

      ```js Svelte icon="s" theme={null}
      import { createInertiaApp } from '@inertiajs/svelte'
      import { mount } from 'svelte'

      createInertiaApp({
          resolve: name => {
              const pages = import.meta.glob('./Pages/**/*.svelte', { eager: true })
              return pages[`./Pages/${name}.svelte`]
          },
          setup({ el, App, props }) {
              mount(App, { target: el, props })
          },
      })
      ```
    </CodeGroup>

    The `setup` callback receives everything necessary to initialize the client-side framework, including the root Inertia `App` component.
  </Step>
</Steps>

## Configuring Defaults

You may pass a `defaults` object to `createInertiaApp()` to configure default settings for various features. You don't have to pass a default for every key, just the ones you want to tweak.

```js theme={null}
createInertiaApp({
    // ...
    defaults: {
        form: {
            recentlySuccessfulDuration: 5000,
        },
        prefetch: {
            cacheFor: "1m",
            hoverDelay: 150,
        },
        visitOptions: (href, options) => {
            return {
                headers: {
                    ...options.headers,
                    "X-Custom-Header": "value",
                },
            };
        },
    },
});
```

The `visitOptions` callback receives the target URL and the current visit options, and should return an object with any options you want to override. For more details on the available configuration options, see the [forms](/docs/v2/the-basics/forms#form-errors), [prefetching](/docs/v2/data-props/prefetching), and [manual visits](/docs/v2/the-basics/manual-visits#global-visit-options) documentation.

### Updating Configuration at Runtime

You may also update configuration values at runtime using the exported `config` instance. This is particularly useful when you need to adjust settings based on user preferences or application state.

<CodeGroup>
  ```js Vue icon="vuejs" theme={null}
  import { config } from '@inertiajs/vue3'

  // Set a single value using dot notation...
  config.set('form.recentlySuccessfulDuration', 1000)
  config.set('prefetch.cacheFor', '5m')

  // Set multiple values at once...
  config.set({
      'form.recentlySuccessfulDuration': 1000,
      'prefetch.cacheFor': '5m',
  })
  ```

  ```js React icon="react" theme={null}
  import { config } from '@inertiajs/react'

  // Set a single value using dot notation...
  config.set('form.recentlySuccessfulDuration', 1000)
  config.set('prefetch.cacheFor', '5m')

  // Set multiple values at once...
  config.set({
      'form.recentlySuccessfulDuration': 1000,
      'prefetch.cacheFor': '5m',
  })

  // Get a configuration value...
  const duration = config.get('form.recentlySuccessfulDuration')
  ```

  ```js Svelte icon="s" theme={null}
  import { config } from '@inertiajs/svelte'

  // Set a single value using dot notation...
  config.set('form.recentlySuccessfulDuration', 1000)
  config.set('prefetch.cacheFor', '5m')

  // Set multiple values at once...
  config.set({
      'form.recentlySuccessfulDuration': 1000,
      'prefetch.cacheFor': '5m',
  })

  // Get a configuration value...
  const duration = config.get('form.recentlySuccessfulDuration')
  ```
</CodeGroup>

## Resolving Components

The `resolve` callback tells Inertia how to load a page component. It receives a page name (string), and returns a page component module. How you implement this callback depends on which bundler (Vite or Webpack) you're using.

<CodeGroup>
  ```js Vue icon="vuejs" theme={null}
  // Vite
  resolve: name => {
      const pages = import.meta.glob('./Pages/**/*.vue', { eager: true })
      return pages[`./Pages/${name}.vue`]
  },

  // Webpack
  resolve: name => require(`./Pages/${name}`),
  ```

  ```js React icon="react" theme={null}
  // Vite
  resolve: name => {
      const pages = import.meta.glob('./Pages/**/*.jsx', { eager: true })
      return pages[`./Pages/${name}.jsx`]
  },

  // Webpack
  resolve: name => require(`./Pages/${name}`),
  ```

  ```js Svelte icon="s" theme={null}
  // Vite
  resolve: name => {
      const pages = import.meta.glob('./Pages/**/*.svelte', { eager: true })
      return pages[`./Pages/${name}.svelte`]
  },

  // Webpack
  resolve: name => require(`./Pages/${name}.svelte`),
  ```
</CodeGroup>

By default we recommend eager loading your components, which will result in a single JavaScript bundle. However, if you'd like to lazy-load your components, see the [code splitting](/docs/v2/advanced/code-splitting) documentation.

The `laravel-vite-plugin` package also provides a [`resolvePageComponent`](https://laravel.com/docs/vite#inertia) helper that may be used to resolve page components.

<CodeGroup>
  ```js Vue icon="vuejs" theme={null}
  import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers'

  resolve: name => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
  ```

  ```js React icon="react" theme={null}
  import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers'

  resolve: name => resolvePageComponent(`./Pages/${name}.jsx`, import.meta.glob('./Pages/**/*.jsx')),
  ```

  ```js Svelte icon="s" theme={null}
  import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers'

  resolve: name => resolvePageComponent(`./Pages/${name}.svelte`, import.meta.glob('./Pages/**/*.svelte')),
  ```
</CodeGroup>

## Defining a Root Element

By default, Inertia assumes that your application's root template has a root element with an `id` of `app`. If your application's root element has a different `id`, you can provide it using the `id` property.

```js theme={null}
createInertiaApp({
    id: 'my-app',
    // ...
})
```

If you change the `id` of the root element, be sure to update it [server-side](/docs/v2/installation/server-side-setup#root-template) as well.

## Script Element for Page Data

By default, Inertia stores the initial page data in a `data-page` attribute on the root element. You may configure Inertia to use a `<script type="application/json">` element instead, which is slightly faster and easier to inspect in your browser's dev tools.

```js theme={null}
createInertiaApp({
    // ...
    defaults: {
        future: {
            useScriptElementForInitialPage: true,
        },
    },
})
```

Be sure to also update your [SSR entry point](/docs/v2/advanced/server-side-rendering#add-server-entry-point) if you're using server-side rendering. Laravel users should also set the `inertia.use_script_element_for_initial_page` config value to `true` so the `@inertia` Blade directive outputs a script element.
