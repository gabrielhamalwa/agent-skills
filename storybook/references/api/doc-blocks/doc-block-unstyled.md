# Unstyled

The `Unstyled` block is a special block that disables Storybook's default styling in MDX docs wherever it is added.

By default, most elements (like `h1`, `p`, etc.) in docs have a few default styles applied to ensure the docs look good. However, sometimes you might want some of your content to not have these styles applied. In those cases, wrap the content with the `Unstyled` block to remove the default styles.

```mdx title="ButtonDocs.mdx"

> This block quote will be styled

... and so will this paragraph.

  > This block quote will not be styled

... neither will this paragraph, nor the following component (which contains an \<h1\>):

```

Yields:

![Screenshot of Unstyled Doc Block](../../_assets/api/doc-block-unstyled.png)

The other blocks like [`Story`](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md) and [`Canvas`](https://storybook.js.org/docs/api/doc-blocks/doc-block-canvas.md) are already unstyled, so there’s no need to wrap those in the `Unstyled` block to ensure that Storybook’s styles don’t bleed into the stories. However, if you import your components directly in the MDX, you most likely want to wrap them in the Unstyled block.

Due to how CSS inheritance works it’s best to always add the Unstyled block to the root of your MDX, and not nested into other elements. The following example will cause some Storybook styles like `color` to be inherited into `CustomComponent` because they are applied to the root `div`:

```md
<div>
  
    
  
</div>
```

## Unstyled

```js

```

`Unstyled` is configured with the following props:

### `children`

Type: `React.ReactNode`

Provides the content to which you do _not_ want to apply default docs styles.
