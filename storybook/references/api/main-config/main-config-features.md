# features

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type:

```ts
{
  actions?: boolean;
  argTypeTargetsV7?: boolean;
  babelRemoveBugfixes?: boolean; // webpack only
  backgrounds?: boolean;
  changeDetection?: boolean;
  componentsManifest?: boolean;
  controls?: boolean;
  developmentModeForBuild?: boolean;
  experimentalCodeExamples?: boolean;
  experimentalDocgenServer?: boolean;
  experimentalReview?: boolean;
  experimentalTestSyntax?: boolean;
  highlight?: boolean;
  interactions?: boolean;
  legacyDecoratorFileOrder?: boolean;
  measure?: boolean;
  outline?: boolean;
  sidebarOnboardingChecklist?: boolean;
  menuOnboardingChecklist?: boolean;
  toolbars?: boolean;
  viewport?: boolean;
}
```

```ts
{
  actions?: boolean;
  argTypeTargetsV7?: boolean;
  babelRemoveBugfixes?: boolean; // webpack only
  backgrounds?: boolean;
  changeDetection?: boolean;
  controls?: boolean;
  developmentModeForBuild?: boolean;
  highlight?: boolean;
  interactions?: boolean;
  legacyDecoratorFileOrder?: boolean;
  measure?: boolean;
  outline?: boolean;
  sidebarOnboardingChecklist?: boolean;
  menuOnboardingChecklist?: boolean;
  toolbars?: boolean;
  viewport?: boolean;
}
```

Enables Storybook's additional features.

## `actions`

Type: `boolean`

Default: `true`

Enable the [Actions](https://storybook.js.org/docs/essentials/actions.md) feature.

## `argTypeTargetsV7`

(⚠️ **Experimental**)

Type: `boolean`

Default: `true`

Filter args with a "target" on the type from the render function.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    argTypeTargetsV7: true,
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    argTypeTargetsV7: true,
  },
});
```

## `babelRemoveBugfixes`

(⚠️ **Webpack builder only**)

Type: `boolean`

Disable the `bugfixes` option in `@babel/preset-env` for Webpack builder. This option was removed in Babel 8 and now causes Babel to throw an error. Set this to `true` if you use Babel 8 and Storybook fails to detect your Babel version.

## `backgrounds`

Type: `boolean`

Default: `true`

Enable the [Backgrounds](https://storybook.js.org/docs/essentials/backgrounds.md) feature.

## `changeDetection`

Type: `boolean`

Default: `true`

Enable [change detection](https://storybook.js.org/docs/configure/user-interface/change-detection.md). When enabled, Storybook monitors your git working tree and the builder's module graph to show which stories are new, modified, or related to code changes. Changed stories are displayed with status icons in the sidebar.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    changeDetection: false,
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    changeDetection: false,
  },
});
```

## `componentsManifest`

Type: `boolean`

Default: `false`

Generate [manifests](https://storybook.js.org/docs/ai/manifests.md), used by the [MCP server](https://storybook.js.org/docs/ai/mcp/overview.md).

When combined with [`experimentalDocgenServer`](#experimentaldocgenserver), manifests use a ref-based format with per-component JSON snapshots for faster MCP loading.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    componentsManifest: true,
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    componentsManifest: true,
  },
});
```

## `controls`

Type: `boolean`

Default: `true`

Enable the [Controls](https://storybook.js.org/docs/essentials/controls.md) feature.

## `developmentModeForBuild`

Type: `boolean`

Set `NODE_ENV` to `'development'` in built Storybooks for better testing and debugging capabilities.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    developmentModeForBuild: true,
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    developmentModeForBuild: true,
  },
});
```

## `experimentalCodeExamples`

(⚠️ **Experimental**)

Type: `boolean`

Prefer [`experimentalDocgenServer`](#experimentaldocgenserver), which supersedes this flag and provides the same static snippet behavior along with faster, more accurate docgen.

Enable the new code example generation method for React components (as seen in the story previews in an [autodocs](https://storybook.js.org/docs/writing-docs/autodocs.md) page).

Unlike the current implementation, this method reads the actual stories source file, which is faster to generate, more readable, and more accurate. However, they are not dynamic: they won't update if you change values in the Controls table.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    experimentalCodeExamples: true,
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    experimentalCodeExamples: true,
  },
});
```

## `experimentalDocgenServer`

(⚠️ **Experimental**)

Type: `boolean`

Default: `false`, except on [`@storybook/angular-vite`](https://storybook.js.org/docs/get-started/frameworks/angular-vite.md#component-documentation), which turns it on from its own configuration.

Enable server-side docgen. Storybook extracts component metadata on the dev server using the TypeScript Language Service instead of injecting docgen into the preview bundle. This provides faster startup, more accurate [Controls](https://storybook.js.org/docs/essentials/controls.md) and ArgTypes tables in [autodocs](https://storybook.js.org/docs/writing-docs/autodocs.md), and improved static code snippets in docs and the Code panel. [Manifests](https://storybook.js.org/docs/ai/manifests.md) and the [MCP server](https://storybook.js.org/docs/ai/mcp/overview.md) use an optimized, ref-based format that loads faster for AI agents.

Snippets are static: they won't update if you change values in the Controls table.

Support is rolling out per framework, and we [welcome feedback on the RFC](https://github.com/storybookjs/storybook/discussions/35333).

When enabled, you do not need [`experimentalCodeExamples`](#experimentalcodeexamples) because snippet generation is handled by the server-side story-docs service.

Opt in with the configuration below.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    experimentalDocgenServer: true,
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    experimentalDocgenServer: true,
  },
});
```

## `experimentalReview`

(⚠️ **Experimental**)

Type: `boolean`

Default: `false`

Enable the [experimental agentic review](https://storybook.js.org/docs/ai/agentic-review.md) feature, which allows you to review the work an AI agent has done in your Storybook.

Builds on [`changeDetection`](#changedetection), which must also be enabled (it is, by default).

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    experimentalReview: true,
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    experimentalReview: true,
  },
});
```

## `experimentalTestSyntax`

(⚠️ **Experimental**)

Type: `boolean`

Enable the [experimental `.test` method with the CSF Next format](https://storybook.js.org/docs/api/csf/csf-next.md#storytest).

```ts
// .storybook/main.js|ts (CSF Next 🧪)
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    experimentalTestSyntax: true,
  },
});
```

## `highlight`

Type: `boolean`

Default: `true`

Enable the [Highlight](https://storybook.js.org/docs/essentials/highlight.md) feature.

## `interactions`

Type: `boolean`

Default: `true`

Enable the [Interactions](https://storybook.js.org/docs/writing-tests/interaction-testing.md#debugging-interaction-tests) feature.

## `legacyDecoratorFileOrder`

Type: `boolean`

Apply decorators from preview.js before decorators from addons or frameworks. [More information](https://github.com/storybookjs/storybook/blob/next/MIGRATION.md#changed-decorator-order-between-previewjs-and-addonsframeworks).

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    legacyDecoratorFileOrder: true,
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  features: {
    legacyDecoratorFileOrder: true,
  },
});
```

## `measure`

Type: `boolean`

Default: `true`

Enable the [Measure](https://storybook.js.org/docs/essentials/measure-and-outline.md#measure) feature.

## `menuOnboardingChecklist`

Type: `boolean`

Default: `true`

Enable a link to the onboarding guide in the menu.

## `outline`

Type: `boolean`

Default: `true`

Enable the [Outline](https://storybook.js.org/docs/essentials/measure-and-outline.md#outline) feature.

## `sidebarOnboardingChecklist`

Type: `boolean`

Default: `true`

Enable the onboarding checklist sidebar widget.

## `viewport`

Type: `boolean`

Default: `true`

Enable the [Viewport](https://storybook.js.org/docs/essentials/viewport.md) feature.
