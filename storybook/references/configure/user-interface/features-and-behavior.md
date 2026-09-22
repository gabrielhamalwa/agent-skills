# Features and behavior

To control the layout of Storybook’s UI you can use `addons.setConfig` in your `.storybook/manager.js`:

```ts
// .storybook/manager.ts

addons.setConfig({
  navSize: 300,
  bottomPanelHeight: 300,
  rightPanelWidth: 300,
  panelPosition: 'bottom',
  enableShortcuts: true,
  showToolbar: true,
  theme: undefined,
  selectedPanel: undefined,
  initialActive: 'sidebar',
  layoutCustomisations: {
    showSidebar(state: State, defaultValue: boolean) {
      return state.storyId === 'landing' ? false : defaultValue;
    },
    showToolbar(state: State, defaultValue: boolean) {
      return state.viewMode === 'docs' ? false : defaultValue;
    },
  },
  sidebar: {
    showRoots: false,
    collapsedRoots: ['other'],
  },
  toolbar: {
    title: { hidden: false },
    zoom: { hidden: false },
    eject: { hidden: false },
    copy: { hidden: false },
    fullscreen: { hidden: false },
  },
});
```

The following table details how to use the API values:

| Name                     | Type            | Description                                             | Example Value                                                                                  |
| ------------------------ | --------------- | ------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| **navSize**              | Number (pixels) | The size of the sidebar that shows a list of stories    | `300`                                                                                          |
| **bottomPanelHeight**    | Number (pixels) | The size of the addon panel when in the bottom position | `200`                                                                                          |
| **rightPanelWidth**      | Number (pixels) | The size of the addon panel when in the right position  | `200`                                                                                          |
| **panelPosition**        | String          | Where to show the addon panel                           | `'bottom'` or `'right'`                                                                        |
| **enableShortcuts**      | Boolean         | Enable/disable shortcuts                                | `true`                                                                                         |
| **showToolbar**          | Boolean         | Show/hide tool bar                                      | `true`                                                                                         |
| **theme**                | Object          | Storybook Theme, see next section                       | `undefined`                                                                                    |
| **selectedPanel**        | String          | Id to select an addon panel                             | `'storybook/actions/panel'`                                                                    |
| **initialActive**        | String          | Select the default active tab on Mobile                 | `'sidebar'` or `'canvas'` or `'addons'`                                                        |
| **layoutCustomisations** | Object          | Layout customisation options, see below                 | `{ showSidebar: ({ viewMode }, defaultValue) => viewMode === 'docs' ? false : defaultValue` }` |
| **sidebar**              | Object          | Sidebar options, see below                              | `{ showRoots: false }`                                                                         |
| **toolbar**              | Object          | Modify the tools in the toolbar using the addon id      | `{ fullscreen: { hidden: false } } `                                                           |

The following options are configurable under the `sidebar` namespace:

| Name               | Type     | Description                                                   | Example Value                                         |
| ------------------ | -------- | ------------------------------------------------------------- | ----------------------------------------------------- |
| **showRoots**      | Boolean  | Display the top-level nodes as a "root" in the sidebar        | `false`                                               |
| **collapsedRoots** | Array    | Set of root node IDs to visually collapse by default          | `['misc', 'other']`                                   |
| **renderLabel**    | Function | Create a custom label for tree nodes; must return a ReactNode | `(item, api) => <abbr title="...">{item.name}</abbr>` |

The following options are configurable under the `toolbar` namespace:

| Name     | Type   | Description                                                          | Example Value       |
| -------- | ------ | -------------------------------------------------------------------- | ------------------- |
| **[id]** | String | Toggle visibility for a specific toolbar item (e.g. `title`, `zoom`) | `{ hidden: false }` |

The following options are configurable under the `layoutCustomisations` namespace:

| Name            | Type     | Description                       | Example Value                                                                 |
| --------------- | -------- | --------------------------------- | ----------------------------------------------------------------------------- |
| **showSidebar** | Function | Toggle visibility for the sidebar | `({ storyId }, defaultValue) => storyId === 'landing' ? false : defaultValue` |
| **showToolbar** | Function | Toggle visibility for the toolbar | `({ viewMode }, defaultValue) => viewMode === 'docs' ? false : defaultValue`  |

The `showSidebar` and `showToolbar` functions let you hide parts of the UI that are essential to Storybook's functionality. If misused, they can make navigation impossible. When hiding the sidebar, ensure the displayed page provides an alternative means of navigation.

## Customize the UI

Storybook's UI is highly customizable. Its API and configuration options, available via the `showSidebar`, `showPanel` and `showToolbar` functions, allow you to control how the sidebar, addon panel and toolbar elements are displayed. Each function will enable you to include some default behavior and can be overridden to customize the UI to your needs.

### Override sidebar visibility

The sidebar, present on the left of the screen, contains the search function and navigation menu. Users may show or hide it with a keyboard shortcut. If you want to force the sidebar to be visible or hidden in certain places, you can define a `showSidebar` function in `layoutCustomisations`. Below are the available parameters passed to this function and an overview of how to use them.

| Name                     | Type    | Description                                                       | Example Value                                         |
| ------------------------ | ------- | ----------------------------------------------------------------- | ----------------------------------------------------- |
| **path**                 | String  | Path to the page being displayed                                  | `'/story/components-button--default'`                 |
| **viewMode**             | String  | Whether the current page is a story or docs                       | `'docs'` or `'story'`                                 |
| **singleStory**          | Boolean | Whether the current page is the only story for a component        | `true` or `false`                                     |
| **storyId**              | String  | The id of the current story or docs page                          | `'blocks-unstyled--docs'`                             |
| **index**                | Object  | The index containing statically analysed metadata for every story | `{ 'blocks-unstyled--docs': { tags: ['autodocs'] } }` |
| **layout**               | Object  | The current layout state                                          | _see below_                                           |
| **layout.isFullscreen**  | Boolean | Whether the preview canvas is in fullscreen mode                  | `true` or `false`                                     |
| **layout.panelPosition** | String  | Whether the panel is shown below or on the side of the preview    | `'bottom'` or `'right'`                               |
| **layout.showNav**       | Boolean | The setting for whether the end user wants to see the sidebar     | `true` or `false`                                     |
| **layout.showPanel**     | Boolean | The setting for whether the end user wants to see the panel       | `true` or `false`                                     |
| **layout.showToolbar**   | Boolean | The setting for whether the end user wants to see the toolbar     | `true` or `false`                                     |

```ts
// ./storybook/manager.ts

addons.setConfig({
  layoutCustomisations: {
    // Hide the sidebar on the landing page, which has its own nav links to other pages.
    showSidebar(state: State, defaultValue: boolean) {
      if (state.storyId === 'landing' && state.viewMode === 'docs') {
        return false;
      }

      return defaultValue;
    },
  },
});
```

If you're hiding the sidebar through `showSidebar`, ensure the displayed page provides an alternative means of navigation.

### Configure the addon panel

When viewing a story, Storybook displays the addon panel on the bottom or right of the UI. The panel shows UIs for available addons (e.g., the [interactions panel](https://storybook.js.org/docs/writing-tests/interaction-testing.md#debugging-interaction-tests), [accessibility tests panel](https://storybook.js.org/docs/writing-tests/accessibility-testing.md) or [controls panel](https://storybook.js.org/docs/essentials/controls.md)). If you want to customize when the addon panel appears, you can use the `showPanel` function. Listed below are the available options and an overview of how to use them.

| Name                     | Type    | Description                                                       | Example Value                                         |
| ------------------------ | ------- | ----------------------------------------------------------------- | ----------------------------------------------------- |
| **path**                 | String  | Path to the page being displayed                                  | `'/story/components-button--default'`                 |
| **viewMode**             | String  | Whether the current page is a story or docs                       | `'docs'` or `'story'`                                 |
| **singleStory**          | Boolean | Whether the current page is the only story for a component        | `true` or `false`                                     |
| **storyId**              | String  | The id of the current story or docs page                          | `'blocks-unstyled--docs'`                             |
| **index**                | Object  | The index containing statically analysed metadata for every story | `{ 'blocks-unstyled--docs': { tags: ['autodocs'] } }` |
| **layout**               | Object  | The current layout state                                          | _see below_                                           |
| **layout.isFullscreen**  | Boolean | Whether the preview canvas is in fullscreen mode                  | `true` or `false`                                     |
| **layout.panelPosition** | String  | Whether the panel is shown below or on the side of the preview    | `'bottom'` or `'right'`                               |
| **layout.showNav**       | Boolean | The setting for whether the end user wants to see the sidebar     | `true` or `false`                                     |
| **layout.showPanel**     | Boolean | The setting for whether the end user wants to see the panel       | `true` or `false`                                     |
| **layout.showToolbar**   | Boolean | The setting for whether the end user wants to see the toolbar     | `true` or `false`                                     |

```ts
// ./storybook/manager.ts

addons.setConfig({
  layoutCustomisations: {
    showPanel(state: State, defaultValue: boolean) {
      const tags = state.index?.[state.storyId]?.tags ?? [];

      // Hide the panel on stories designed to showcase multiple variants or usage examples.
      if (tags.includes('showcase') || tags.includes('kitchensink')) {
        return false;
      }

      return defaultValue;
    },
  },
});
```

### Configure the toolbar

By default, Storybook displays a toolbar at the top of the UI, allowing you to access menus from addons (e.g., [viewport](https://storybook.js.org/docs/essentials/viewport.md), [background](https://storybook.js.org/docs/essentials/backgrounds.md)), or custom defined [menus](https://storybook.js.org/docs/essentials/toolbars-and-globals.md#global-types-and-the-toolbar-annotation). However, if you want to customize the toolbar's behavior, you can use the `showToolbar` function. Listed below are the available options and an overview of how to use them.

| Name                     | Type    | Description                                                       | Example Value                                         |
| ------------------------ | ------- | ----------------------------------------------------------------- | ----------------------------------------------------- |
| **path**                 | String  | Path to the page being displayed                                  | `'/story/components-button--default'`                 |
| **viewMode**             | String  | Whether the current page is a story or docs                       | `'docs'` or `'story'`                                 |
| **singleStory**          | Boolean | Whether the current page is the only story for a component        | `true` or `false`                                     |
| **storyId**              | String  | The id of the current story or docs page                          | `'blocks-unstyled--docs'`                             |
| **index**                | Object  | The index containing statically analysed metadata for every story | `{ 'blocks-unstyled--docs': { tags: ['autodocs'] } }` |
| **layout**               | Object  | The current layout state                                          | _see below_                                           |
| **layout.isFullscreen**  | Boolean | Whether the preview canvas is in fullscreen mode                  | `true` or `false`                                     |
| **layout.panelPosition** | String  | Whether the panel is shown below or on the side of the preview    | `'bottom'` or `'right'`                               |
| **layout.showNav**       | Boolean | The setting for whether the end user wants to see the sidebar     | `true` or `false`                                     |
| **layout.showPanel**     | Boolean | The setting for whether the end user wants to see the panel       | `true` or `false`                                     |
| **layout.showToolbar**   | Boolean | The setting for whether the end user wants to see the toolbar     | `true` or `false`                                     |

```ts
// ./storybook/manager.ts

addons.setConfig({
  layoutCustomisations: {
    // Always hide the toolbar on docs pages, and respect user preferences elsewhere.
    showToolbar(state: State, defaultValue: boolean) {
      if (state.viewMode === 'docs') {
        return false;
      }

      return defaultValue;
    },
  },
});
```

## Change detection

Storybook can show status icons in the sidebar to highlight new and modified stories. See [change detection](https://storybook.js.org/docs/configure/user-interface/change-detection.md) for setup and details.

## Configuring through URL parameters

You can use URL parameters to configure some of the available features:

| Config option       | Query param  | Supported values                                                                             |
| ------------------- | ------------ | -------------------------------------------------------------------------------------------- |
| **enableShortcuts** | `shortcuts`  | `false`                                                                                      |
| --- (fullscreen)    | `full`       | `true`, `false`                                                                              |
| --- (show sidebar)  | `nav`        | `true`, `false`                                                                              |
| --- (show panel)    | `panel`      | `false`, `'right'`, `'bottom'`                                                               |
| **selectedPanel**   | `addonPanel` | Any panel ID                                                                                 |
| **showTabs**        | `tabs`       | `true`                                                                                       |
| ---                 | `instrument` | `false`, `true`                                                                              |
| ---                 | `statuses`   | Semicolon-separated status values: `new`, `modified`, `related` (prefix with `!` to exclude) |
