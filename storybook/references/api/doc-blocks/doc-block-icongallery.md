# IconGallery

The `IconGallery` block enables you to easily document React icon components associated with your project, displayed in a neat grid.

![Screenshot of IconGallery and IconItem blocks](../../_assets/api/doc-block-icongallery.png)

## Documenting icons

To document a set of icons, use the `IconGallery` block to display them in a grid. Each icon is wrapped in an `IconItem` block, enabling you to specify its properties, such as the name and the icon itself.

```mdx title="Iconography.mdx"

# Iconography

  
    
  
  
    
  
  
    
  
  
    
  
  
    
  
  
    
  
  
    
  
  
    
  
  
    
  
  
    
  

```

### Automate icon documentation

If you're working on a project that contains a large number of icons that you want to document, you can extend the `IconGallery` block, wrap `IconItem` in a loop, and iterate over the icons you want to document, including their properties. For example:

```mdx title="Iconography.mdx"

# Iconography

  {Object.keys(icons).map((icon) => (
    
      
    
  ))}

```

## IconGallery

```js

```

`IconGallery` is configured with the following props:

### `children`

Type: `React.ReactNode`

`IconGallery` expects only `IconItem` children.

## IconItem

```js

```

`IconItem` is configured with the following props:

### `name`

(**Required**)

Type: `string`

Sets the name of the icon.

### `children`

Type: `React.ReactNode`

Provides the icon to be displayed.
