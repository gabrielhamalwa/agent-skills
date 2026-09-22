# Doc blocks

Storybook offers several doc blocks to help document your components and other aspects of your project.

There are two common ways to use doc blocks in Storybook, within MDX and as part of the docs page template.

## Within MDX

The blocks are most commonly used within Storybook's [MDX documentation](https://storybook.js.org/docs/writing-docs/mdx.md):

![Screenshot of mdx content](../_assets/writing-docs/mdx-example.png)

```mdx title="ButtonDocs.mdx"

# Button

A button is ...

## Props

## Stories

### Primary

A button can be of primary importance.

A button can be of secondary importance.

```

## Customizing the automatic docs page

The blocks are also used to define the page template for [automatics docs](https://storybook.js.org/docs/writing-docs/autodocs.md). For example, here's the default template:

![Screenshot of automatic docs template](../_assets/writing-docs/autodocs-default-template.png)

```jsx

  Title,
  Subtitle,
  Description,
  Primary,
  Controls,
  Stories,
} from '@storybook/addon-docs/blocks';

export const autoDocsTemplate = () => (
  <>
    
    
    
    
    
    
  </>
);
```

If you [override the default page template](https://storybook.js.org/docs/writing-docs/autodocs.md#write-a-custom-template), you can similarly use Doc Blocks to build the perfect documentation page for your project.

Note that some doc blocks render other blocks. For example, the `` block expands to:

```mdx title="Button.mdx"
## Stories

  ### Story name
  
  
  

```

As a result, for example, customizing the [`Source`](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md) block via parameters (see next section) will also affect the Source blocks rendered as part of [`Canvas`](https://storybook.js.org/docs/api/doc-blocks/doc-block-canvas.md) blocks.

## Customizing doc blocks

In both use cases (MDX and automatic docs), many of the doc blocks can be customized via [parameters](https://storybook.js.org/docs/writing-stories/parameters.md).

For example, you can filter out the `style` prop from all [`Controls`](https://storybook.js.org/docs/api/doc-blocks/doc-block-controls.md) tables through your Storybook:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  parameters: {
    docs: {
      controls: { exclude: ['style'] },
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
      controls: { exclude: ['style'] },
    },
  },
});
```

Parameters can also be defined at the [component](https://storybook.js.org/docs/writing-stories/parameters.md#component-parameters) (or meta) level or the [story](https://storybook.js.org/docs/writing-stories/parameters.md#story-parameters) level, allowing you to customize Doc Blocks exactly as you need, where you need.

The blocks that accept customization via parameters are marked in the list of available blocks below.

When using a doc block in MDX, it can also be customized with its props:

```md
<Controls exclude={['style']}>
```

## Available blocks

Each block has a dedicated API reference page detailing usage, available options, and technical details.

### [ArgTypes](https://storybook.js.org/docs/api/doc-blocks/doc-block-argtypes.md)

Accepts parameters in the namespace `parameters.docs.argTypes`.

The `ArgTypes` block can be used to show a static table of [arg types](https://storybook.js.org/docs/api/arg-types.md) for a given component as a way to document its interface.

![Screenshot of ArgTypes block](../_assets/api/doc-block-argtypes.png)

### [Canvas](https://storybook.js.org/docs/api/doc-blocks/doc-block-canvas.md)

Accepts parameters in the namespace `parameters.docs.canvas`.

The `Canvas` block is a wrapper around a [`Story`](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md), featuring a toolbar that allows you to interact with its content while automatically providing the required [`Source`](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md) snippets.

![Screenshot of Canvas block](../_assets/api/doc-block-canvas.png)

### [ColorPalette](https://storybook.js.org/docs/api/doc-blocks/doc-block-colorpalette.md)

The `ColorPalette` block allows you to document all color-related items (e.g., swatches) used throughout your project.

![Screenshot of ColorPalette and ColorItem blocks](../_assets/api/doc-block-colorpalette.png)

### [Controls](https://storybook.js.org/docs/api/doc-blocks/doc-block-controls.md)

Accepts parameters in the namespace `parameters.docs.controls`.

The `Controls` block can be used to show a dynamic table of args for a given story, as a way to document its interface, and to allow you to change the args for a (separately) rendered story (via the [`Story`](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md) or [`Canvas`](https://storybook.js.org/docs/api/doc-blocks/doc-block-canvas.md) blocks).

![Screenshot of Controls block](../_assets/api/doc-block-controls.png)

### [Description](https://storybook.js.org/docs/api/doc-blocks/doc-block-description.md)

The `Description` block displays the description for a component, story, or meta obtained from their respective JSDoc comments.

![Screenshot of Description block](../_assets/api/doc-block-title-subtitle-description.png)

### [IconGallery](https://storybook.js.org/docs/api/doc-blocks/doc-block-icongallery.md)

The `IconGallery` block lets you quickly document all icons associated with your project, displayed in a neat grid.

![Screenshot of IconGallery and IconItem blocks](../_assets/api/doc-block-icongallery.png)

### [Markdown](https://storybook.js.org/docs/api/doc-blocks/doc-block-markdown.md)

The `Markdown` block allows you to import and include plain markdown in your MDX files.

![Screenshot of Markdown block](../_assets/api/doc-block-markdown.png)

### [Meta](https://storybook.js.org/docs/api/doc-blocks/doc-block-meta.md)

The `Meta` block is used to [attach](#attached-vs-unattached) a custom MDX docs page alongside a component’s list of stories. It doesn’t render any content but serves two purposes in an MDX file:

- Attaches the MDX file to a component and its stories, or
- Controls the location of the unattached docs entry in the sidebar.

### [Primary](https://storybook.js.org/docs/api/doc-blocks/doc-block-primary.md)

The `Primary` block displays the primary (first defined in the stories file) story in a [`Story`](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md) block. It is typically rendered immediately under the title in a docs entry.

![Screenshot of Primary block](../_assets/api/doc-block-primary.png)

### [Source](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md)

Accepts parameters in the namespace `parameters.docs.source`.

The `Source` block is used to render a snippet of source code directly.

![Screenshot of Source block](../_assets/api/doc-block-source.png)

### [Stories](https://storybook.js.org/docs/api/doc-blocks/doc-block-stories.md)

The `Stories` block renders the full collection of stories in a stories file.

![Screenshot of Stories block](../_assets/api/doc-block-stories.png)

### [Story](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md)

Accepts parameters in the namespace `parameters.docs.story`.

[Stories](https://storybook.js.org/docs/writing-stories.md) are Storybook's fundamental building blocks.

In Storybook Docs, you can render any of your stories from your CSF files in the context of an MDX file with all annotations (parameters, args, loaders, decorators, play function) applied using the `Story` block.

![Screenshot of Story block](../_assets/api/doc-block-story.png)

### [Subtitle](https://storybook.js.org/docs/api/doc-blocks/doc-block-subtitle.md)

The `Subtitle` block can serve as a secondary heading for your docs entry.

![Screenshot of Subtitle block](../_assets/api/doc-block-title-subtitle-description.png)

### [TableOfContents](https://storybook.js.org/docs/api/doc-blocks/doc-block-tableofcontents.md)

Accepts parameters in the namespace `parameters.docs.toc`.

The `TableOfContents` block renders a table of contents for the current documentation page, allowing users to quickly navigate between sections. It appears as a fixed sidebar on the right side of the page.

### [Title](https://storybook.js.org/docs/api/doc-blocks/doc-block-title.md)

The `Title` block serves as the primary heading for your docs entry. It is typically used to provide the component or page name.

![Screenshot of Title block](../_assets/api/doc-block-title-subtitle-description.png)

### [Typeset](https://storybook.js.org/docs/api/doc-blocks/doc-block-typeset.md)

The `Typeset` block helps document the fonts used throughout your project.

![Screenshot of Typeset block](../_assets/api/doc-block-typeset.png)

### [Unstyled](https://storybook.js.org/docs/api/doc-blocks/doc-block-unstyled.md)

The `Unstyled` block is a unique block that disables Storybook's default styling in MDX docs wherever it is added.

By default, most elements (like `h1`, `p`, etc.) in docs have a few default styles applied to ensure the docs look good. However, sometimes you might want some of your content not to have these styles applied. In those cases, wrap the content with the `Unstyled` block to remove the default styles.

![Screenshot of Unstyled block](../_assets/api/doc-block-unstyled.png)

## Make your own Doc Blocks

Storybook also provides a [`useOf` hook](https://storybook.js.org/docs/api/doc-blocks/doc-block-useof.md) to make it easier to create your own blocks that function like the built-in blocks.

## Troubleshooting

### Why can't I use the Doc Blocks inside my stories?

Storybook's Doc Blocks are highly customizable and helpful building blocks to assist you with building your custom documentation. Although most of them enable you to customize them with parameters or globally to create custom [documentation templates](#customizing-the-automatic-docs-page), they are primarily designed for MDX files. For example, if you try to add the `ColorPalette` block to your stories as follows, you'll get an error message when the story loads in Storybook.

```tsx
// MyComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: MyComponent,
} satisfies Meta<typeof MyComponent>;

export default meta;
type Story = StoryObj<typeof meta>;

const theme = {
  colors: {
    primaryDark: {
      value: '#1C1C1C',
    },
    primaryRegular: {
      value: '#363636',
    },
    primaryLight1: {
      value: '#4D4D4D',
    },
    primaryLight2: {
      value: '#878787',
    },
    primaryLight3: {
      value: '#D1D1D1',
    },
    primaryLight4: {
      value: '#EDEDED',
    },
  },
};

// ❌ Don't use the Doc Blocks inside your stories. It will break Storybook with a cryptic error.
export const Colors: Story = {
  render: () => (
    
      {Object.entries(theme.colors).map(([key, { value }]) => (
        
      ))}
    
  ),
};
```

```tsx
// MyComponent.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: MyComponent,
});

const theme = {
  colors: {
    primaryDark: {
      value: '#1C1C1C',
    },
    primaryRegular: {
      value: '#363636',
    },
    primaryLight1: {
      value: '#4D4D4D',
    },
    primaryLight2: {
      value: '#878787',
    },
    primaryLight3: {
      value: '#D1D1D1',
    },
    primaryLight4: {
      value: '#EDEDED',
    },
  },
};

// ❌ Don't use the Doc Blocks inside your stories. It will break Storybook with a cryptic error.
export const Colors = meta.story({
  render: () => (
    
      {Object.entries(theme.colors).map(([key, { value }]) => (
        
      ))}
    
  ),
});
```

**Learn more about Storybook documentation**

- [Autodocs](https://storybook.js.org/docs/writing-docs/autodocs.md) for creating documentation for your stories
- [MDX](https://storybook.js.org/docs/writing-docs/mdx.md) for customizing your documentation
- Doc Blocks for authoring your documentation
- [Publishing docs](https://storybook.js.org/docs/writing-docs/build-documentation.md) to automate the process of publishing your documentation
