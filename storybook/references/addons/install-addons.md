# Install addons

Storybook has [hundreds of reusable addons](https://storybook.js.org/integrations) packaged as NPM modules. Let's walk through how to extend Storybook by installing and registering addons.

## Automatic installation

Storybook includes a [`storybook add`](https://storybook.js.org/docs/api/cli-options.md#add) command to automate the setup of addons. Several community-led addons can be added using this command, except for preset addons. We encourage you to read the addon's documentation to learn more about its installation process.

Run the `storybook add` command using your chosen package manager, and the CLI will update your Storybook configuration to include the addon and install any necessary dependencies.

```shell
npx storybook@latest add @storybook/addon-a11y
```

```shell
pnpm dlx storybook@latest add @storybook/addon-a11y
```

```shell
yarn dlx storybook@latest add @storybook/addon-a11y
```

If you're attempting to install multiple addons at once, it will only install the first addon that was specified. This is a known limitation of the current implementation and will be addressed in a future release.

### Manual installation

Storybook addons are always added through the [`addons`](https://storybook.js.org/docs/api/main-config/main-config-addons.md) configuration array in [`.storybook/main.js|ts`](https://storybook.js.org/docs/configure.md). The following example shows how to manually add the [Accessibility addon](https://storybook.js.org/addons/@storybook/addon-a11y) to Storybook.

Run the following command with your package manager of choice to install the addon.

```shell
npm install @storybook/addon-a11y --save-dev
```

```shell
pnpm add --save-dev @storybook/addon-a11y
```

```shell
yarn add --dev @storybook/addon-a11y
```

Next, update `.storybook/main.js|ts` to the following:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using (e.g., react-vite, vue3-vite, angular, etc.)

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: [
    // Other Storybook addons
    '@storybook/addon-a11y', //👈 The a11y addon goes here
  ],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: [
    // Other Storybook addons
    '@storybook/addon-a11y', //👈 The a11y addon goes here
  ],
});
```

When you run Storybook, the accessibility testing addon will be enabled.

![Storybook addon installed and registered](../_assets/addons/storybook-addon-installed-registered.png)

### Removing addons

To remove an addon from Storybook, you can choose to manually uninstall it and remove it from the configuration file (i.e., [`.storybook/main.js|ts`](https://storybook.js.org/docs/configure.md)) or opt-in to do it automatically via the CLI with the [`remove`](https://storybook.js.org/docs/api/cli-options.md#remove) command. For example, to remove the [Accessibility addon](https://storybook.js.org/addons/@storybook/addon-a11y) from Storybook with the CLI, run the following command:

```shell
npx storybook@latest remove @storybook/addon-a11y
```

```shell
pnpm dlx storybook@latest remove @storybook/addon-a11y
```

```shell
yarn dlx storybook@latest remove @storybook/addon-a11y
```
