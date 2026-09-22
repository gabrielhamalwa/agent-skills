# ColorPalette

The `ColorPalette` block allows you to document all color-related items (e.g., swatches) used throughout your project.

![Screenshot of ColorPalette and ColorItem blocks](../../_assets/api/doc-block-colorpalette.png)

```mdx title="Colors.mdx"

  
  
  
  
  
  

```

## ColorPalette

```js

```

`ColorPalette` is configured with the following props:

### `children`

Type: `React.ReactNode`

`ColorPalette` expects only `ColorItem` children.

## ColorItem

```js

```

`ColorItem` is configured with the following props:

### `colors`

(**Required**)

Type: `string[] | { [key: string]: string }`

Provides the list of colors to be displayed. Accepts any valid CSS color format (hex, RGB, HSL, etc.). When an object is provided, the keys will be displayed above the values. Additionally, it supports gradients such as 'linear-gradient(to right, white, black)' or 'linear-gradient(65deg, white, black)', etc.

### `subtitle`

(**Required**)

Type: `string`

Provides an additional description of the color.

### `title`

(**Required**)

Type: `string`

Sets the name of the color to be displayed.
