# Storybook for SvelteKit

Storybook for SvelteKit is a [framework](https://storybook.js.org/docs/contribute/framework.md) that makes it easy to develop and test UI components in isolation for [SvelteKit](https://kit.svelte.dev/) applications.

## Install

To install Storybook in an existing SvelteKit project, run this command in your project's root directory:

```shell
npm create storybook@latest
```

```shell
pnpm create storybook@latest
```

```shell
yarn create storybook
```

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

This section covers SvelteKit support and configuration options.

### Supported features

All Svelte language features are supported out of the box, as the Storybook framework uses the Svelte compiler directly.
However, SvelteKit has some [Kit-specific modules](https://kit.svelte.dev/docs/modules) that aren't supported. Here's a breakdown of what will and will not work within Storybook:

| Module                                                                     | Status                 | Note                                                                                                                                    |
| -------------------------------------------------------------------------- | ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| [`$app/environment`](https://svelte.dev/docs/kit/$app-environment)         | ✅ Supported           | `version` is always empty in Storybook.                                                                                                 |
| [`$app/forms`](https://svelte.dev/docs/kit/$app-forms)                     | ⚠️ **Experimental**    | See [How to mock](#how-to-mock).                                                                                                        |
| [`$app/navigation`](https://svelte.dev/docs/kit/$app-navigation)           | ⚠️ **Experimental**    | See [How to mock](#how-to-mock).                                                                                                        |
| [`$app/paths`](https://svelte.dev/docs/kit/$app-paths)                     | ✅ Supported           | Requires SvelteKit 1.4.0 or newer.                                                                                                      |
| [`$app/state`](https://svelte.dev/docs/kit/$app-state)                     | ⚠️ **Experimental**    | Requires SvelteKit `v2.12` or newer. See [How to mock](#how-to-mock).                                                                   |
| [`$app/stores`](https://svelte.dev/docs/kit/$app-stores)                   | ⚠️ **Experimental**    | See [How to mock](#how-to-mock).                                                                                                        |
| [`$env/dynamic/public`](https://svelte.dev/docs/kit/$env-dynamic-public)   | 🚧 Partially supported | Only supported in development mode. Storybook is built as a static app with no server-side API, so it cannot dynamically serve content. |
| [`$env/static/public`](https://svelte.dev/docs/kit/$env-static-public)     | ✅ Supported           |                                                                                                                                         |
| [`$lib`](https://svelte.dev/docs/kit/$lib)                                 | ✅ Supported           |                                                                                                                                         |
| [`@sveltejs/kit/*`](https://svelte.dev/docs/kit/@sveltejs-kit)             | ✅ Supported           |                                                                                                                                         |
| [`$env/dynamic/private`](https://svelte.dev/docs/kit/$env-dynamic-private) | ⛔ Not supported       | This is a server-side feature, and Storybook renders all components on the client.                                                      |
| [`$env/static/private`](https://svelte.dev/docs/kit/$env-static-private)   | ⛔ Not supported       | This is a server-side feature, and Storybook renders all components on the client.                                                      |
| [`$service-worker`](https://svelte.dev/docs/kit/$service-worker)           | ⛔ Not supported       | This is a service worker feature, which does not apply to Storybook.                                                                    |

### How to mock

To mock a SvelteKit import you can define it within `parameters.sveltekit_experimental`:

The [available parameters](#parameters) are documented in the API section, below.

#### Mocking links

The default link-handling behavior (e.g., when clicking an `<a href="..." />` element) is to log an action to the [Actions panel](https://storybook.js.org/docs/essentials/actions.md).

You can override this by assigning an object to `parameters.sveltekit_experimental.hrefs`, where the keys are strings representing an href, and the values define your mock. For example:

See the [API reference](#hrefs) for more information.

## Writing native Svelte stories

Storybook provides a Svelte [addon](https://storybook.js.org/addons/@storybook/addon-svelte-csf) maintained by the community, enabling you to write stories for your Svelte components using the template syntax.

The community actively maintains the Svelte CSF addon but still lacks some features currently available in the official Storybook Svelte framework support. For more information, see the [addon's documentation](https://github.com/storybookjs/addon-svelte-csf).

### Setup

If you initialized your project with the Sveltekit framework, the addon has already been installed and configured for you. However, if you're [migrating](#automatic-migration) from a previous version, you'll need to take additional steps to enable this feature.

Run the following command to install the addon.

The CLI's [`add`](https://storybook.js.org/docs/api/cli-options.md#add) command automates the addon's installation and setup. To install it manually, see our [documentation](https://storybook.js.org/docs/addons/install-addons.md#manual-installation) on how to install addons.

Update your Storybook configuration file (i.e., `.storybook/main.js|ts`) to enable support for this format.

### Configure

By default, the Svelte [addon](https://storybook.js.org/addons/@storybook/addon-svelte-csf) addon offers zero-config support for Storybook's SvelteKit framework. However, you can extend your Storybook configuration file (i.e., `.storybook/main.js|ts`) and provide additional addon options. Listed below are the available options and examples of how to use them.

| Options          | Description                                                                                                        |
| ---------------- | ------------------------------------------------------------------------------------------------------------------ |
| `legacyTemplate` | Enables support for the `Template` component for backward compatibility. <br/> `options: { legacyTemplate: true }` |

Enabling the `legacyTemplate` option can introduce a performance overhead and should be used cautiously. For more information, refer to the [addon's documentation](https://github.com/storybookjs/addon-svelte-csf/blob/next/README.md#legacy-api).

### Upgrade to Svelte CSF addon v5

With the Svelte 5 release, Storybook's Svelte CSF addon has been updated to support the new features. This guide will help you migrate to the latest version of the addon. Below is an overview of the major changes in version 5.0 and the steps needed to upgrade your project.

#### Simplified story API

If you are using the `Meta` component or the `meta` named export to define the story's metadata (e.g., [parameters](https://storybook.js.org/docs/writing-stories/parameters.md)), you'll need to update your stories to use the new `defineMeta` function. This function returns an object with the required information, including a `Story` component that you must use to define your component stories.

#### Story templates

If you used the `Template` component to control how the component renders in the Storybook, this feature was replaced with built-in children support in the `Story` component, enabling you to compose components and define the UI structure directly in the story.

If you need support for the `Template` component, the addon provides a feature flag for backward compatibility. For more information, see the [configuration options](#configure).

#### Story slots to snippets

With Svelte's slot deprecation and the introduction of reusable [`snippets`](https://svelte.dev/docs/svelte/v5-migration-guide#Snippets-instead-of-slots), the addon also introduced support for this feature allowing you to extend the `Story` component and provide a custom snippet to provide dynamic content to your stories. `Story` accepts a `template` snippet, allowing you to create dynamic stories without losing reactivity.

```svelte title="MyComponent.stories.svelte"
<script>
  import { defineMeta } from '@storybook/addon-svelte-csf';

  import MyComponent from './MyComponent.svelte';

  const { Story } = defineMeta({
    component: MyComponent,
  });
</script>

  {#snippet template(args)}
    Reactive component
  {/snippet}

```

#### Tags support

If you enabled automatic documentation generation with the `autodocs` story property, you must replace it with [`tags`](https://storybook.js.org/docs/writing-stories/tags.md). This property allows you to categorize and filter stories based on specific criteria and generate documentation based on the tags applied to the stories.

## FAQ

### How do I manually install the SvelteKit framework?

First, install the framework:

Then, update your `.storybook/main.js|ts` to change the framework property:

Finally, these packages are now either obsolete or part of `@storybook/sveltekit`, so you no longer need to depend on them directly. You can remove them (`npm uninstall`, `yarn remove`, `pnpm remove`) from your project:

- `@storybook/svelte-vite`
- `storybook-builder-vite`
- `@storybook/builder-vite`

## API

### Parameters

This framework contributes the following [parameters](https://storybook.js.org/docs/writing-stories/parameters.md) to Storybook, under the `sveltekit_experimental` namespace:

#### `forms`

Type: `{ enhance: () => void }`

Provides mocks for the [`$app/forms`](https://svelte.dev/docs/kit/$app-forms) module.

##### `forms.enhance`

Type: `() => void`

A callback that will be called when a form with [`use:enhance`](https://kit.svelte.dev/docs/form-actions#progressive-enhancement-use-enhance) is submitted.

#### `hrefs`

Type: `Record<[path: string], (to: string, event: MouseEvent) => void | { callback: (to: string, event: MouseEvent) => void, asRegex?: boolean }>`

If you have an `<a />` tag inside your code with the `href` attribute that matches one or more of the links defined (treated as regex based if the `asRegex` property is `true`) the corresponding `callback` will be called. If no matching `hrefs` are defined, an action will be logged to the [Actions panel](https://storybook.js.org/docs/essentials/actions.md). See [Mocking links](#mocking-links) for an example.

#### `navigation`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-navigation)

Provides mocks for the [`$app/navigation`](https://svelte.dev/docs/kit/$app-navigation) module.

##### `navigation.goto`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-navigation#goto)

A callback that will be called whenever [`goto`](https://svelte.dev/docs/kit/$app-navigation#goto) is called. If no function is provided, an action will be logged to the [Actions panel](https://storybook.js.org/docs/essentials/actions.md).

##### `navigation.pushState`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-navigation#pushState)

A callback that will be called whenever [`pushState`](https://svelte.dev/docs/kit/$app-navigation#pushState) is called. If no function is provided, an action will be logged to the [Actions panel](https://storybook.js.org/docs/essentials/actions.md).

##### `navigation.replaceState`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-navigation#replaceState)

A callback that will be called whenever [`replaceState`](https://svelte.dev/docs/kit/$app-navigation#replaceState) is called. If no function is provided, an action will be logged to the [Actions panel](https://storybook.js.org/docs/essentials/actions.md).

##### `navigation.invalidate`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-navigation#invalidate)

A callback that will be called whenever [`invalidate`](https://svelte.dev/docs/kit/$app-navigation#invalidate) is called. If no function is provided, an action will be logged to the [Actions panel](https://storybook.js.org/docs/essentials/actions.md).

##### `navigation.invalidateAll`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-navigation#invalidateAll)

A callback that will be called whenever [`invalidateAll`](https://svelte.dev/docs/kit/$app-navigation#invalidateAll) is called. If no function is provided, an action will be logged to the [Actions panel](https://storybook.js.org/docs/essentials/actions.md).

##### `navigation.afterNavigate`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-navigation#afterNavigate)

An object that will be passed to the [`afterNavigate`](https://svelte.dev/docs/kit/$app-navigation#afterNavigate) function, which will be invoked when the `onMount` event fires.

#### `stores`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-stores)

Provides mocks for the [`$app/stores`](https://svelte.dev/docs/kit/$app-stores) module.

##### `stores.navigating`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-stores#navigating)

A partial version of the [`navigating`](https://svelte.dev/docs/kit/$app-stores#navigating) store.

##### `stores.page`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-stores#page)

A partial version of the [`page`](https://svelte.dev/docs/kit/$app-stores#page) store.

##### `stores.updated`

Type: boolean

A boolean representing the value of [`updated`](https://svelte.dev/docs/kit/$app-stores#updated) (you can also access `updated.check()` which will be a no-op).

#### `state`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-state)

Provides mocks for the [`$app/state`](https://svelte.dev/docs/kit/$app-state) module.

##### `state.navigating`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-state#navigating)

A partial version of the [`navigating`](https://svelte.dev/docs/kit/$app-state#navigating) store.

##### `state.page`

Type: See [SvelteKit docs](https://svelte.dev/docs/kit/$app-state#page)

A partial version of the [`page`](https://svelte.dev/docs/kit/$app-state#page) store.

##### `state.updated`

Type: `{ current: boolean }`

An object representing the current value of [`updated`](https://svelte.dev/docs/kit/$app-state#updated). You can also access `updated.check()`, which will be a no-op.

### Options

You can pass an options object for additional configuration if needed:

The available options are:

#### `builder`

Type: `Record<string, any>`

Configure options for the [framework's builder](https://storybook.js.org/docs/api/main-config/main-config-framework.md#optionsbuilder). For Sveltekit, available options can be found in the [Vite builder docs](https://storybook.js.org/docs/builders/vite.md).

#### `docgen`

Type: `boolean`

Default: `true`

Enables or disables automatic documentation generation for component properties. When disabled, Storybook will skip the docgen processing step during build, which can improve build performance.

#### When to disable docgen

Disabling docgen can improve build performance for large projects, but [argTypes won't be inferred automatically](https://storybook.js.org/docs/api/arg-types.md#automatic-argtype-inference), which will prevent features like [Controls](https://storybook.js.org/docs/essentials/controls.md) and [docs](https://storybook.js.org/docs/writing-docs/autodocs.md) from working as expected. To use those features, you will need to [define `argTypes` manually](https://storybook.js.org/docs/api/arg-types.md#manually-specifying-argtypes).
