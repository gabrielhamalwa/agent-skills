# MCP server API

Storybook's AI capabilities are in [preview](https://storybook.js.org/docs/releases/features.md#preview).
The API may change in future releases.
We welcome feedback and contributions to help improve this feature.

## `@storybook/addon-mcp` options

The MCP server addon accepts the following options to configure the tools provided by the MCP server. You can provide these options when registering the addon in your `main.js|ts` file:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using (e.g., react-vite, vue3-vite, angular, etc.)

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: [
    // ... your existing addons
    {
      name: '@storybook/addon-mcp',
      options: {
        toolsets: {
          dev: false,
        },
      },
    },
  ],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, angular-vite, vue3-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: [
    // ... your existing addons
    {
      name: '@storybook/addon-mcp',
      options: {
        toolsets: {
          dev: false,
        },
      },
    },
  ],
});
```

### `toolsets`

Type:

```ts
{
  dev?: boolean;
  docs?: boolean;
  test?: boolean;
}
```

Default:

```ts
{
  dev: true,
  docs: true,
  test: true,
}
```

Configuration object to toggle which toolsets are enabled in the MCP server. By default, all toolsets are enabled.

#### `dev`

Type: `boolean`

Default: `true`

The development toolset includes the [`stories-changed`](https://storybook.js.org/docs/ai/mcp/overview.md#stories-changed), [`get-storybook-story-instructions`](https://storybook.js.org/docs/ai/mcp/overview.md#get-storybook-story-instructions), [`stories-preview`](https://storybook.js.org/docs/ai/mcp/overview.md#stories-preview), [`stories-find-by-component`](https://storybook.js.org/docs/ai/mcp/overview.md#stories-find-by-component), and [`review-create`](https://storybook.js.org/docs/ai/mcp/overview.md#review-create) tools when their feature requirements are enabled.

#### `docs`

Type: `boolean`

Default: `true`

The docs toolset includes the [`docs-show`](https://storybook.js.org/docs/ai/mcp/overview.md#docs-show), [`docs-show-story`](https://storybook.js.org/docs/ai/mcp/overview.md#docs-show-story), and [`docs-list`](https://storybook.js.org/docs/ai/mcp/overview.md#docs-list) tools when a [components manifest](https://storybook.js.org/docs/ai/manifests.md) is generated for your framework.

#### `test`

Type: `boolean`

Default: `true`

The testing toolset includes the [`test-run`](https://storybook.js.org/docs/ai/mcp/overview.md#test-run) tool when `@storybook/addon-vitest` is installed and enabled.

**More AI resources**

- [Agentic setup](https://storybook.js.org/docs/ai/setup.md)
- [MCP server overview](https://storybook.js.org/docs/ai/mcp/overview.md)
- [Sharing your MCP server](https://storybook.js.org/docs/ai/mcp/sharing.md)
- [Best practices for using Storybook with AI](https://storybook.js.org/docs/ai/best-practices.md)
- [Manifests](https://storybook.js.org/docs/ai/manifests.md)
