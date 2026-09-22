# Stories

The `Stories` block renders the full collection of stories in a stories file.

![Screenshot of Stories block](../../_assets/api/doc-block-stories.png)

```mdx title="ButtonDocs.mdx"

```

## Stories

```js

```

`Stories` is configured with the following props:

### `includePrimary`

Type: `boolean`

Default: `true`

Determines if the collection of stories includes the primary (first) story.

Set `includePrimary={false}` to omit the primary story from the rendered collection. If the primary story is the only story in the file, the `Stories` block will render nothing.

### `title`

Type: `string`

Default: `'Stories'`

Sets the heading content preceding the collection of stories.
