# Storybook Composition

Composition allows you to browse components from any Storybook accessible via URL inside your local Storybook. You can compose any [Storybook published online](https://storybook.js.org/docs/sharing/publish-storybook.md) or running locally no matter the view layer, tech stack, or dependencies.

![Storybook reference external](../_assets/sharing/reference-external-storybooks-composition.png)

You’ll see the composed Storybook’s stories in the sidebar alongside your own. This unlocks common workflows that teams often struggle with:

- 👩‍💻 UI developers can quickly reference prior art without switching between Storybooks.
- 🎨 Design systems can expand adoption by composing themselves into their users’ Storybooks.
- 🛠 Frontend platform can audit how components are used across projects.
- 📚 View multiple Storybooks with different tech stacks in one place

![Storybook composition](../_assets/sharing/combine-storybooks.png)

## Compose published Storybooks

In your [`.storybook/main.js|ts`](https://storybook.js.org/docs/configure/index.md#configure-story-rendering) file add a `refs` field with information about the reference Storybook. Pass in a URL to a statically built Storybook.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  refs: {
    'design-system': {
      title: 'Storybook Design System',
      url: 'https://master--5ccbc373887ca40020446347.chromatic.com/',
      expanded: false, // Optional, true by default,
      sourceUrl: 'https://github.com/storybookjs/storybook', // Optional
    },
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
  refs: {
    'design-system': {
      title: 'Storybook Design System',
      url: 'https://master--5ccbc373887ca40020446347.chromatic.com/',
      expanded: false, // Optional, true by default,
      sourceUrl: 'https://github.com/storybookjs/storybook', // Optional
    },
  },
});
```

Addons in composed Storybooks will not work as they normally do in a non-composed Storybook.

## Compose local Storybooks

You can also compose multiple Storybooks that are running locally. For instance, if you have a React Storybook and an Angular Storybook running on different ports, you can update your configuration file (i.e., `.storybook/main.js|ts`) and reference them as follows:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  refs: {
    react: {
      title: 'React',
      url: 'http://localhost:7007',
    },
    angular: {
      title: 'Angular',
      url: 'http://localhost:7008',
    },
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
  refs: {
    react: {
      title: 'React',
      url: 'http://localhost:7007',
    },
    angular: {
      title: 'Angular',
      url: 'http://localhost:7008',
    },
  },
});
```

Adding this configuration will combine React and Angular Storybooks into your current one. You’ll see the changes being applied automatically when either of these changes. Enabling you to develop both frameworks in sync.

## Compose Storybooks per environment

You can also compose Storybooks based on the current development environment (e.g., development, staging, production). For instance, if the project you're working on already has a published Storybook but also includes a version with cutting-edge features not yet released, you can adjust the composition based on that. For example:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  // 👇 Retrieve the current environment from the configType argument
  refs: (config, { configType }) => {
    if (configType === 'DEVELOPMENT') {
      return {
        react: {
          title: 'Composed React Storybook running in development mode',
          url: 'http://localhost:7007',
        },
        angular: {
          title: 'Composed Angular Storybook running in development mode',
          url: 'http://localhost:7008',
        },
      };
    }
    return {
      react: {
        title: 'Composed React Storybook running in production',
        url: 'https://your-production-react-storybook-url',
      },
      angular: {
        title: 'Composed Angular Storybook running in production',
        url: 'https://your-production-angular-storybook-url',
      },
    };
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
  // 👇 Retrieve the current environment from the configType argument
  refs: (config, { configType }) => {
    if (configType === 'DEVELOPMENT') {
      return {
        react: {
          title: 'Composed React Storybook running in development mode',
          url: 'http://localhost:7007',
        },
        angular: {
          title: 'Composed Angular Storybook running in development mode',
          url: 'http://localhost:7008',
        },
      };
    }
    return {
      react: {
        title: 'Composed React Storybook running in production',
        url: 'https://your-production-react-storybook-url',
      },
      angular: {
        title: 'Composed Angular Storybook running in production',
        url: 'https://your-production-angular-storybook-url',
      },
    };
  },
});
```

Similar to other fields available in Storybook’s configuration file, the `refs` field can also be a function that accepts a `config` parameter containing Storybook’s configuration object. See the [API reference](https://storybook.js.org/docs/api/main-config/main-config-refs.md) for more information.

## Troubleshooting

### Storybook composition is not working with my project

If you're working with an outdated Storybook version or have a project-specific requirement that prevents you from updating your Storybook to the latest version, you can rely on the Storybook CLI to generate the `index.json` file when you deploy your Storybook. For example:

```shell
npx storybook@7.5.3 extract
```

```shell
pnpm dlx storybook@7.5.3 extract
```

```shell
yarn dlx storybook@7.5.3 extract
```

The usage of a specific version of the CLI is intended as the `extract` command is not available in Storybook 8.0 or higher. It also requires you to provide additional configuration to generate the `index.json` file accurately. See the [previous documentation](https://storybook.js.org/docs/7/sharing/storybook-composition.md) for more information.
