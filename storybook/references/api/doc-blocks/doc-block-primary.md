# Primary

The `Primary` block displays the primary (first defined in the stories file) story, in a [`Story`](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md) block. It is typically rendered immediately under the title in a docs entry.

![Screenshot of Primary block](../../_assets/api/doc-block-primary.png)

```mdx title="ButtonDocs.mdx"

```

## Primary

```js

```

`Primary` is configured with the following props:

### `of`

Type: CSF file exports

Specifies which CSF file is used to find the first story, which is then rendered by this block. Pass the full set of exports from the CSF file (not the default export!).
