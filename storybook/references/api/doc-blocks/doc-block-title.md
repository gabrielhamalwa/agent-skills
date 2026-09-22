# Title

The `Title` block serves as the primary heading for your docs entry. It is typically used to provide the component or page name.

![Screenshot of Title block](../../_assets/api/doc-block-title-subtitle-description.png)

```mdx title="ButtonDocs.mdx"

This is the title
```

## Title

```js

```

`Title` is configured with the following props:

### `children`

Type: `JSX.Element | string`

Provides the content. Falls back to value of `title` in an [attached](https://storybook.js.org/docs/api/doc-blocks/doc-block-meta.md#attached-vs-unattached) CSF file (or value derived from [autotitle](https://storybook.js.org/docs/configure/user-interface/sidebar-and-urls.md#csf-30-auto-titles)), trimmed to the last segment. For example, if the title value is `'path/to/components/Button'`, the default content is `'Button'`.

### `of`

Type: CSF file exports

Specifies which meta's title is displayed.
