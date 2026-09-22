# Storybook for Svelte with Vite

Storybook for Svelte & Vite is a [framework](https://storybook.js.org/docs/contribute/framework.md) that makes it easy to develop and test UI components in isolation for applications using [Svelte](https://svelte.dev/) built with [Vite](https://vitejs.dev/).

## Install

To install Storybook in an existing Svelte project, run this command in your project's root directory:

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

## Writing native Svelte stories

Storybook provides a Svelte [addon](https://storybook.js.org/addons/@storybook/addon-svelte-csf) maintained by the community, enabling you to write stories for your Svelte components using the template syntax.

The community actively maintains the Svelte CSF addon but still lacks some features currently available in the official Storybook Svelte framework support. For more information, see the [addon's documentation](https://github.com/storybookjs/addon-svelte-csf).

### Setup

If you initialized your project with the Svelte framework, the addon has already been installed and configured for you. However, if you're [migrating](#automatic-migration) from a previous version, you'll need to take additional steps to enable this feature.

Run the following command to install the addon.

The CLI's [`add`](https://storybook.js.org/docs/api/cli-options.md#add) command automates the addon's installation and setup. To install it manually, see our [documentation](https://storybook.js.org/docs/addons/install-addons.md#manual-installation) on how to install addons.

Update your Storybook configuration file (i.e., `.storybook/main.js|ts`) to enable support for this format.

### Configure

By default, the Svelte [addon](https://storybook.js.org/addons/@storybook/addon-svelte-csf) offers zero-config support for Storybook's Svelte framework. However, you can extend your Storybook configuration file (i.e., `.storybook/main.js|ts`) and provide additional addon options. Listed below are the available options and examples of how to use them.

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

### How do I manually install the Svelte framework?

First, install the framework:

Then, update your `.storybook/main.js|ts` to change the framework property:

## API

### Options

You can pass an options object for additional configuration if needed:

The available options are:

#### `builder`

Type: `Record<string, any>`

Configure options for the [framework's builder](https://storybook.js.org/docs/api/main-config/main-config-framework.md#optionsbuilder). For this framework, available options can be found in the [Vite builder docs](https://storybook.js.org/docs/builders/vite.md).

#### `docgen`

Type: `boolean`

Default: `true`

Enables or disables automatic documentation generation for component properties. When disabled, Storybook will skip the docgen processing step during build, which can improve build performance.

#### When to disable docgen

Disabling docgen can improve build performance for large projects, but [argTypes won't be inferred automatically](https://storybook.js.org/docs/api/arg-types.md#automatic-argtype-inference), which will prevent features like [Controls](https://storybook.js.org/docs/essentials/controls.md) and [docs](https://storybook.js.org/docs/writing-docs/autodocs.md) from working as expected. To use those features, you will need to [define `argTypes` manually](https://storybook.js.org/docs/api/arg-types.md#manually-specifying-argtypes).
