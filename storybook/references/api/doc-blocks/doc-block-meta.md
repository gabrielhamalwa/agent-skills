# Meta

The `Meta` block is used to [attach](#attached-vs-unattached) a custom MDX docs page alongside a component’s list of stories. It doesn’t render any content, but serves two purposes in an MDX file:

- Attaches the MDX file to a component and its stories, or
- Controls the location of the unattached docs entry in the sidebar.

```mdx title="ButtonDocs.mdx"

```

The Meta block doesn’t render anything visible.

## Meta

```js

```

`Meta` is configured with the following props:

### `isTemplate`

Type: `boolean`

Determines whether the MDX file serves as an [automatic docs template](https://storybook.js.org/docs/writing-docs/autodocs.md#with-mdx). When true, the MDX file is not indexed as it normally would be.

### `name`

Type: `string`

Sets the name of the [attached](#attached-vs-unattached) doc entry. You can attach more than one MDX file to the same component in the sidebar by setting different names for each file's `Meta`.

```mdx title="Component.mdx"

```

### `of`

Type: CSF file exports

Specifies which CSF file is [attached](#attached-vs-unattached) to this MDX file. Pass the **full set of exports** from the CSF file (not the default export!).

```mdx title="ButtonDocs.mdx"

```

Attaching an MDX file to a component’s stories with the `of` prop serves two purposes:

1. Ensures the MDX content appears in the sidebar inside the component’s story list. By default, it will be named whatever the `docs.defaultName` (which defaults to `"Docs"`) option is set to in `main.js`. But this can be overridden with the [`name` prop](#name).
2. Attaches the component and its stories to the MDX file, allowing you to use other doc blocks in “attached” mode (for instance to use the `Stories` block).

The `of` prop is optional. If you don’t want to attach a specific CSF file to this MDX file, you can either use the `title` prop to control the location, or emit `Meta` entirely, and let [autotitle](https://storybook.js.org/docs/configure/user-interface/sidebar-and-urls.md#csf-30-auto-titles) decide where it goes.

### `title`

Type: `string`

Sets the title of an [unattached](#attached-vs-unattached) MDX file.

```mdx title="Introduction.mdx"

```

If you want to change the sorting of the docs entry with the component’s stories, use [Story Sorting](https://storybook.js.org/docs/writing-stories/naming-components-and-hierarchy.md#sorting-stories), or add specific MDX files to your `stories` field in `main.js` in order.

## Attached vs. unattached

In Storybook, a docs entry (MDX file) is "attached" when it is associated with a stories file, via `Meta`'s [`of` prop](#of). Attached docs entries display next to the stories list under the component in the sidebar.

"Unattached" docs entries are not associated with a stories file and can be displayed anywhere in the sidebar via `Meta`'s [`title` prop](#title).
