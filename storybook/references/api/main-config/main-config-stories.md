# stories

(**Required**)

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type:

```ts
| (string | StoriesSpecifier)[]
| async (list: (string | StoriesSpecifier)[]) => (string | StoriesSpecifier)[]
```

Configures Storybook to load stories from the specified locations. The intention is for you to colocate a story file along with the component it documents:

```
•
└── components
    ├── Button.ts
    └── Button.stories.ts
```

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
});
```

If you want to use a different naming convention, you can alter the glob using the syntax supported by [picomatch](https://github.com/micromatch/picomatch#globbing-features).

Keep in mind that some addons may assume Storybook's default naming convention.

## With an array of globs

Storybook will load stories from your project as found by this array of globs (pattern matching strings).

Stories are loaded in the order they are defined in the array. This allows you to control the order in which stories are displayed in the sidebar:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: [
    '../src/**/*.mdx', // 👈 These will display first in the sidebar
    '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)', // 👈 Followed by these
  ],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: [
    '../src/**/*.mdx', // 👈 These will display first in the sidebar
    '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)', // 👈 Followed by these
  ],
});
```

## With a configuration object

Additionally, you can customize your Storybook configuration to load your stories based on a configuration object. This object is of the type `StoriesSpecifier`, defined below.

For example, if you wanted to load your stories from a `packages/components` directory, you could adjust your `stories` configuration field into the following:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: [
    {
      // 👇 Sets the directory containing your stories
      directory: '../packages/components',
      // 👇 Storybook will load all files that match this glob
      files: '*.stories.*',
      // 👇 Used when generating automatic titles for your stories
      titlePrefix: 'MyComponents',
    },
  ],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: [
    {
      // 👇 Sets the directory containing your stories
      directory: '../packages/components',
      // 👇 Storybook will load all files that match this glob
      files: '*.stories.*',
      // 👇 Used when generating automatic titles for your stories
      titlePrefix: 'MyComponents',
    },
  ],
});
```

When Storybook starts, it will look for any file containing the `stories` extension inside the `packages/components` directory and generate the titles for your stories.

### `StoriesSpecifier`

Type:

```ts
{
  directory: string;
  files?: string;
  titlePrefix?: string;
}
```

#### `StoriesSpecifier.directory`

(**Required**)

Type: `string`

Where to start looking for story files, relative to the root of your project.

#### `StoriesSpecifier.files`

Type: `string`

Default: `'**/*.@(mdx|stories.@(js|jsx|mjs|ts|tsx))'`

A glob, relative to `StoriesSpecifier.directory` (with no leading `./`), that matches the filenames to load.

#### `StoriesSpecifier.titlePrefix`

Type: `string`

Default: `''`

When [auto-titling](https://storybook.js.org/docs/configure/user-interface/sidebar-and-urls.md#csf-30-auto-titles), prefix used when generating the title for your stories.

## With a custom implementation

Storybook now statically analyzes the configuration file to improve performance. Loading stories with a custom implementation may de-optimize or break this ability.

You can also adjust your Storybook configuration and implement custom logic to load your stories. For example, suppose you were working on a project that includes a particular pattern that the conventional ways of loading stories could not solve. In that case, you could adjust your configuration as follows:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

async function findStories(): Promise<StoriesEntry[]> {
  // your custom logic returns a list of files
}

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: async (list: StoriesEntry[]) => [
    ...list,
    // 👇 Add your found stories to the existing list of story files
    ...(await findStories()),
  ],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

async function findStories(): Promise<StoriesEntry[]> {
  // your custom logic returns a list of files
}

export default defineMain({
  framework: '@storybook/your-framework',
  stories: async (list: StoriesEntry[]) => [
    ...list,
    // 👇 Add your found stories to the existing list of story files
    ...(await findStories()),
  ],
});
```
