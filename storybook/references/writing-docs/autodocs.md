# Automatic documentation and Storybook

Storybook Autodocs is a powerful tool that can help you quickly generate comprehensive documentation for your UI components. By leveraging Autodocs, you're transforming your stories into living documentation which can be further extended with [MDX](https://storybook.js.org/docs/writing-docs/mdx.md) and [Doc Blocks](https://storybook.js.org/docs/writing-docs/doc-blocks.md) to provide a clear and concise understanding of your components' functionality.

Storybook infers the relevant metadata (e.g., [`args`](https://storybook.js.org/docs/writing-stories/args.md), [`argTypes`](https://storybook.js.org/docs/api/arg-types.md), [`parameters`](https://storybook.js.org/docs/writing-stories/parameters.md)) and automatically generates a documentation page with this information positioned at the root-level of your component tree in the sidebar.

![Storybook autodocs](../_assets/writing-docs/autodocs.png)

## Set up automated documentation

Autodocs is configured through [tags](https://storybook.js.org/docs/writing-stories/tags.md). If a [CSF](https://storybook.js.org/docs/api/csf.md) file contains at least one story tagged with `autodocs`, then a documentation page will be generated for that component.

To enable automatic documentation for all stories in a project, add it to `tags` in your `.storybook/preview.jsx|tsx` file:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  //👇 Enables auto-generated documentation for all stories
  tags: ['autodocs'],
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  addons: [addonDocs()],
  //👇 Enables auto-generated documentation for all stories
  tags: ['autodocs'],
});
```

You can also enable it at the component (or story) level:

```ts
// Button.stories.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
  //👇 Enables auto-generated documentation for this component and includes all stories in this file
  tags: ['autodocs'],
} satisfies Meta<typeof Button>;
export default meta;
```

```ts
// Button.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: Button,
  //👇 Enables auto-generated documentation for this component and includes all stories in this file
  tags: ['autodocs'],
});
```

You can disable auto docs for a particular component by [removing the tag](https://storybook.js.org/docs/writing-stories/tags.md#removing-tags):

```ts
// Page.stories.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Page,
  // 👇 Disable auto-generated documentation for this component
  tags: ['!autodocs'],
} satisfies Meta<typeof Page>;
export default meta;
```

```ts
// Page.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: Page,
  // 👇 Disable auto-generated documentation for this component
  tags: ['!autodocs'],
});
```

Similarly, you can exclude a particular story from the auto docs page, by removing the tag:

```ts
// Button.stories.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Button,
  //👇 Enables auto-generated documentation for this component and includes all stories in this file
  tags: ['autodocs'],
} satisfies Meta<typeof Button>;
export default meta;

type Story = StoryObj<typeof meta>;

export const UndocumentedStory: Story = {
  // 👇 Removes this story from auto-generated documentation
  tags: ['!autodocs'],
};
```

```ts
// Button.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: Button,
  //👇 Enables auto-generated documentation for this component and includes all stories in this file
  tags: ['autodocs'],
});

export const UndocumentedStory = meta.story({
  // 👇 Removes this story from auto-generated documentation
  tags: ['!autodocs'],
});
```

### Configure

In addition to enabling the feature with `tags`, you can extend your Storybook configuration file (i.e., `.storybook/main.js|ts|cjs`) and provide additional options to control how documentation gets created. Listed below are the available options and examples of how to use them.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: ['@storybook/addon-docs'],
  docs: {
    //👇 See the table below for the list of supported options
    defaultName: 'Documentation',
    docsMode: true,
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
  addons: ['@storybook/addon-docs'],
  docs: {
    //👇 See the table below for the list of supported options
    defaultName: 'Documentation',
    docsMode: true,
  },
});
```

| Option                                                               | Description                                                                                                                    |
| -------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| [`defaultName`](https://storybook.js.org/docs/api/main-config/main-config-docs.md#defaultname) | Renames the auto-generated documentation page<br /> Default: `docs: { defaultName: 'Docs' }`                                   |
| [`docsMode`](https://storybook.js.org/docs/api/main-config/main-config-docs.md#docsmode)       | Toggles the documentation mode, which only shows documentation pages in the sidebar<br /> Default: `docs: { docsMode: false }` |

### Write a custom template

To replace the default documentation template used by Storybook, you can extend your UI configuration file (i.e., `.storybook/preview.jsx|tsx`) and introduce a `docs` [parameter](https://storybook.js.org/docs/writing-docs/doc-blocks.md#customizing-the-automatic-docs-page). This parameter accepts a `page` function that returns a React component, which you can use to generate the required template. For example:

```tsx
// .storybook/preview.ts|tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

  Title,
  Subtitle,
  Description,
  Primary,
  Controls,
  Stories,
} from '@storybook/addon-docs/blocks';

const preview: Preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    docs: {
      page: () => (
        <>
          
          
          
          
          
          
        </>
      ),
    },
  },
};

export default preview;
```

```tsx
// .storybook/preview.tsx — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

  Controls,
  Description,
  Primary,
  Stories,
  Subtitle,
  Title,
} from '@storybook/addon-docs/blocks';

export default definePreview({
  addons: [addonDocs()],
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    docs: {
      page: () => (
        <>
          
          
          
          
          
          
        </>
      ),
    },
  },
});
```

Internally, Storybook uses a similar implementation to generate the default template. See the Doc Blocks [API reference](https://storybook.js.org/docs/writing-docs/doc-blocks.md#available-blocks) to learn more about how Doc Blocks work.

Going over the code snippet in more detail. When Storybook starts up, it will override the default template with the custom one composed of the following:

1. A header with the component's metadata retrieved by the [`Title`](https://storybook.js.org/docs/api/doc-blocks/doc-block-title.md), [`Subtitle`](https://storybook.js.org/docs/api/doc-blocks/doc-block-subtitle.md), and [`Description`](https://storybook.js.org/docs/api/doc-blocks/doc-block-description.md) Doc Blocks.
2. The first story defined in the file via the [`Primary`](https://storybook.js.org/docs/api/doc-blocks/doc-block-primary.md) Doc Block with a handy set of UI controls to zoom in and out of the component.
3. An interactive table with all the relevant [`args`](https://storybook.js.org/docs/writing-stories/args.md) and [`argTypes`](https://storybook.js.org/docs/api/arg-types.md) defined in the story via the [`Controls`](https://storybook.js.org/docs/api/doc-blocks/doc-block-controls.md) Doc Block.
4. An overview of the remaining stories via the [`Stories`](https://storybook.js.org/docs/api/doc-blocks/doc-block-stories.md) Doc Block.

#### With MDX

You can also use MDX to generate the documentation template. This is useful in non-React projects where JSX-handling is not configured. Normally, when you create an MDX file in your project, it is treated as normal documentation. To indicate that an MDX file is a documentation template, supply the `isTemplate` property to its [`Meta`](https://storybook.js.org/docs/api/doc-blocks/doc-block-meta.md) Doc Block. For example:

```mdx
// DocumentationTemplate.mdx

# Default implementation

## Inputs

The component accepts the following inputs (props):

---

## Additional variations

Listed below are additional variations of the component.

```

Then you can use it in your `.storybook/preview.jsx|tsx` or an individual story file by importing it:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview = {
  parameters: {
    docs: {
      page: DocumentationTemplate,
    },
  },
} satisfies Preview;

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  addons: [addonDocs()],
  parameters: {
    docs: {
      page: DocumentationTemplate,
    },
  },
});
```

If you only need to override the documentation page for a single component, we recommend creating an MDX file and referencing it directly via the `` Doc Block.

### Generate a table of contents

Storybook's auto-generated documentation pages can be quite long and difficult to navigate. To help with this, you can enable the table of contents feature to provide a quick overview of the documentation page and allow users to jump to a specific section. To enable it, extend your Storybook UI configuration file (i.e., `.storybook/preview.jsx|tsx`) and provide a `docs` [parameter](https://storybook.js.org/docs/writing-stories/parameters.md#global-parameters) with a `toc` property.

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  parameters: {
    docs: {
      toc: true, // 👈 Enables the table of contents
    },
  },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  addons: [addonDocs()],
  parameters: {
    docs: {
      toc: true, // 👈 Enables the table of contents
    },
  },
});
```

### Configure the table of contents

By default, the table of contents on the documentation page will only show the `h3` headings that are automatically generated. However, if you want to customize the table of contents, you can add more parameters to the `toc` property. The following options and examples of how to use them are available.

| Option                | Description                                                                                                                                                                                                      |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `contentsSelector`    | Defines the container's CSS selector for search for the headings <br /> `toc: { contentsSelector: '.sbdocs-content' }`                                                                                           |
| `disable`             | Hides the table of contents for the documentation pages <br /> `toc: { disable: true }`                                                                                                                          |
| `headingSelector`     | Defines the list of headings to feature in the table of contents <br /> `toc: { headingSelector: 'h1, h2, h3' }`                                                                                                 |
| `ignoreSelector`      | Configures the table of contents to ignore specific headings or stories. By default, the table of contents will ignore all content placed within Story blocks <br /> `toc: { ignoreSelector: '.docs-story h2' }` |
| `title`               | Defines a title caption for the table of contents. <br />Accepts one of: `string`, `null`, React element <br /> `toc: { title: 'Table of Contents' }`                                                            |
| `unsafeTocbotOptions` | Provides additional [`TocBot`](https://tscanlin.github.io/tocbot/) configuration options <br /> `toc: { unsafeTocbotOptions: { orderedList: true } }`                                                            |

The `contentsSelector`, `headingSelector`, and `ignoreSelector` properties allow additional customization. For more information on using them, see the [`Tocbot` documentation](https://tscanlin.github.io/tocbot/).

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  parameters: {
    docs: {
      toc: {
        contentsSelector: '.sbdocs-content',
        headingSelector: 'h1, h2, h3',
        ignoreSelector: '#primary',
        title: 'Table of Contents',
        disable: false,
        unsafeTocbotOptions: {
          orderedList: false,
        },
      },
    },
  },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  addons: [addonDocs()],
  parameters: {
    docs: {
      toc: {
        contentsSelector: '.sbdocs-content',
        headingSelector: 'h1, h2, h3',
        ignoreSelector: '#primary',
        title: 'Table of Contents',
        disable: false,
        unsafeTocbotOptions: {
          orderedList: false,
        },
      },
    },
  },
});
```

#### Component-level configuration

If you want to customize the table of contents for a specific story, you can include a `toc` property in the story's meta (or default export) and provide the required [configuration](#configure-the-table-of-contents). For example, if you need to hide the table of contents for a specific story, adjust your story as follows:

```ts
// MyComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: MyComponent,
  tags: ['autodocs'],
  parameters: {
    docs: {
      toc: {
        disable: true, // 👈 Disables the table of contents
      },
    },
  },
} satisfies Meta<typeof MyComponent>;

export default meta;
```

```ts
// MyComponent.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: MyComponent,
  tags: ['autodocs'],
  parameters: {
    docs: {
      toc: {
        disable: true, // 👈 Disables the table of contents
      },
    },
  },
});
```

### Customize component documentation

Creating automated documentation with Storybook's Autodocs provides you with the starting point to build a sustainable documentation pattern. Nevertheless, it may not be suited for every case, and you may want to extend it and provide additional information. We recommend combining [MDX](https://storybook.js.org/docs/writing-docs/mdx.md) alongside Storybook's [Doc Blocks](https://storybook.js.org/docs/writing-docs/doc-blocks.md) for such cases to author your documentation.

## Advanced configuration

### Documenting multiple components

Sometimes it's helpful to document multiple components together. For example, a component library’s ButtonGroup and Button components might not make sense without one another.

Autodocs allows you to document your "main" component, defined by the `component` property, as well as one or more `subcomponents` related to it.

```tsx
// List.stories.ts|tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  component: List,
  subcomponents: { ListItem }, //👈 Adds the ListItem component as a subcomponent
} satisfies Meta<typeof List>;
export default meta;

type Story = StoryObj<typeof meta>;

export const Empty: Story = {};

export const OneItem: Story = {
  render: (args) => (
    
      
    
  ),
};
```

```tsx
// List.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: List,
  subcomponents: { ListItem }, //👈 Adds the ListItem component as a subcomponent
});

export const Empty = meta.story();

export const OneItem = meta.story({
  render: (args) => (
    
      
    
  ),
});
```

![Subcomponents in ArgTypes doc block](../_assets/writing-stories/doc-block-arg-types-subcomponents-for-list.png)

The main component and its subcomponents will show up in a tabbed version of the [`ArgTypes` doc block](https://storybook.js.org/docs/writing-docs/doc-blocks.md#argtypes). The tab titles will correspond to the keys of the `subcomponents` object.

If you want to organize your documentation differently for component groups, we recommend [using MDX](https://storybook.js.org/docs/writing-docs/mdx.md). It gives you complete control over how your components are displayed and supports any configuration.

### Customize the Docs Container

The Docs Container is the component that wraps up the documentation page. It's responsible for rendering the documentation page in Storybook's UI. You can customize it by creating your own component and updating your Storybook UI configuration file (i.e., `.storybook/preview.jsx|tsx`) to reference it.

```tsx
// .storybook/preview.ts|tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const ExampleContainer = ({ children, ...props }) => {
  return {children};
};

const preview: Preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    docs: {
      container: ExampleContainer,
    },
  },
};

export default preview;
```

```tsx
// .storybook/preview.tsx — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

const ExampleContainer = ({ children, ...props }) => {
  return {children};
};

export default definePreview({
  addons: [addonDocs()],
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    docs: {
      container: ExampleContainer,
    },
  },
});
```

### Override the default theme

By default, Storybook provides two themes for the UI: `light` and `dark`. If you need to customize the theme used by the documentation to match the existing one, you can update your Storybook UI configuration file (i.e., `.storybook/preview.jsx|tsx`) and apply it.

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    docs: {
      theme: ensure(themes.dark), // The replacement theme to use
    },
  },
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  addons: [addonDocs()],
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    docs: {
      theme: ensure(themes.dark), // The replacement theme to use
    },
  },
});
```

### Working with custom MDX components

Out of the box, Storybook has a set of components that you can use to customize your documentation page. If you're working with a design system or component library and wish to add them to your documentation page, you can override the `MDXProvider` component inherited from `@mdx-js/react` with your own. However, there's a caveat to this, the component replacement will only have an impact if you're writing documentation using Markdown syntax (e.g., `#` for headings). Native HTML elements, such as `<h1>`, will not be replaced with your custom implementation.

```tsx
// .storybook/preview.ts|tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

export const MyDocsContainer = (props) => (
  
    
  
);

const preview: Preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    docs: {
      container: MyDocsContainer,
    },
  },
};

export default preview;
```

```tsx
// .storybook/preview.tsx — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export const MyDocsContainer = (props) => (
  
    
  
);

export default definePreview({
  addons: [addonDocs()],
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    docs: {
      container: MyDocsContainer,
    },
  },
});
```

This is not a Storybook issue but a detail of how MDX works. From their [migration guide](https://mdxjs.com/migrating/v2/#update-mdx-content):

“We now ‘sandbox’ components, for lack of a better name. It means that when you pass a component for h1, it does get used for `# hi` but not for `<h1>hi</h1>`”

### Addon options

The docs addon accepts options to customize the behavior of the documentation page. You can add them to your Storybook UI configuration file (i.e., `.storybook/main.js|ts`), as part of registering the addon. The following options are available:

| Option             | Description                                                                                                                                                    |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `csfPluginOptions` | Provides additional configuration for Storybook's CSF plugin. Can be disabled with `null`.                                                                     |
| `mdxPluginOptions` | Provides additional configuration options and plugin configuration for [MDX documentation](https://storybook.js.org/docs/writing-docs/mdx.md#markdown-tables-arent-rendering-correctly). |

This example demonstrates how to apply these options.

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: [
    {
      name: '@storybook/addon-docs',
      options: {
        csfPluginOptions: null,
        mdxPluginOptions: {
          mdxCompileOptions: {
            remarkPlugins: [],
          },
        },
      },
    },
  ],
};

export default config;
```

```js
// .storybook/main.js — CSF 3
export default {
  // Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: [
    {
      name: '@storybook/addon-docs',
      options: {
        csfPluginOptions: null,
        mdxPluginOptions: {
          mdxCompileOptions: {
            remarkPlugins: [],
          },
        },
      },
    },
  ],
};
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  addons: [
    {
      name: '@storybook/addon-docs',
      options: {
        csfPluginOptions: null,
        mdxPluginOptions: {
          mdxCompileOptions: {
            remarkPlugins: [],
          },
        },
      },
    },
  ],
});
```

## Troubleshooting

### The table of contents doesn't render as expected

When using Autodocs's table of contents, you may encounter situations where it appears differently than expected. To help you resolve these problems, we have compiled a list of possible scenarios that may cause issues.

#### With simple documentation pages

If you have a documentation page with only one matching heading and create a table of contents for it, the table of contents will not be hidden by default. A potential solution for this issue would be to add a second heading or turn it off entirely.

#### With small screens

If the screen width is less than 1200px, the table of contents will be hidden by default. Currently, there's no built-in solution for this issue that doesn't impact the documentation page's style compatibility.

#### With MDX

If you're writing [unattached documentation](https://storybook.js.org/docs/writing-docs/mdx.md#writing-unattached-documentation) using MDX, you cannot customize the table of contents primarily due to the lack of support for defining parameters based on the current implementation. As a result, the table of contents will always revert to the default [configuration](#configure-the-table-of-contents) provided globally.

### The auto-generated documentation is not showing up in a monorepo setup

Out of the box, Storybook's Autodocs feature is built to generate documentation for your stories automatically. Nevertheless, if you're working with a monorepo setup (e.g., [`Yarn Workspaces`](https://yarnpkg.com/features/workspaces), [`pnpm Workspaces`](https://pnpm.io/workspaces)), you may run into issues where part of the documentation may not be generated for you. To help you troubleshoot those issues, we've prepared some recommendations that might help you.

Update your import statements to reference the component directly instead of the package's root. For example:

```ts
// MyComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

// ❌ Don't use the package's index file to import the component.
// import { MyComponent } from '@component-package';

// ✅ Use the component's export to import it directly.

const meta = {
  /* 👇 The title prop is optional.
   * See https://storybook.js.org/docs/configure/#configure-story-loading
   * to learn how to generate automatic titles
   */
  title: 'MyComponent',
  component: MyComponent,
} satisfies Meta<typeof MyComponent>;

export default meta;
```

```ts
// MyComponent.stories.ts|tsx — CSF Next 🧪

// ❌ Don't use the package's index file to import the component.
// import { MyComponent } from '@component-package';

// ✅ Use the component's export to import it directly.

const meta = preview.meta({
  /* 👇 The title prop is optional.
   * See https://storybook.js.org/docs/configure/#configure-story-loading
   * to learn how to generate automatic titles
   */
  title: 'MyComponent',
  component: MyComponent,
});
```

Additionally, if you're developing using TypeScript, you may need to update Storybook's configuration file (i.e., `.storybook/main.js|ts`) to include the following:

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  typescript: {
    // Overrides the default Typescript configuration to allow multi-package components to be documented via Autodocs.
    reactDocgen: 'react-docgen',
    check: false,
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
  typescript: {
    // Overrides the default Typescript configuration to allow multi-package components to be documented via Autodocs.
    reactDocgen: 'react-docgen',
    check: false,
  },
});
```

If you're still encountering issues, we recommend reaching out to the community using the default communication channels (e.g., [GitHub discussions](https://github.com/storybookjs/storybook/discussions/new?category=help)).

### The controls are not updating the story within the auto-generated documentation

If you turned off inline rendering for your stories via the [`inline`](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md#inline) configuration option, you would run into a situation where the associated controls are not updating the story within the documentation page. This is a known limitation of the current implementation and will be addressed in a future release.

**Learn more about Storybook documentation**

- Autodocs for creating documentation for your stories
- [MDX](https://storybook.js.org/docs/writing-docs/mdx.md) for customizing your documentation
- [Doc Blocks](https://storybook.js.org/docs/writing-docs/doc-blocks.md) for authoring your documentation
- [Publishing docs](https://storybook.js.org/docs/writing-docs/build-documentation.md) to automate the process of publishing your documentation
