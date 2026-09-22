# Addon API

Storybook's API allows developers to interact programmatically with Storybook. With the API, developers can build and deploy custom addons and other tools that enhance Storybook's functionality.

## Core Addon API

Our API is exposed via two distinct packages, each one with a different purpose:

- `storybook/manager-api` used to interact with the Storybook manager UI or access the Storybook API.
- `storybook/preview-api` used to control and configure the addon's behavior.

```js
// my-addon/src/manager.js|ts

```

### addons.add()

The `add` method allows you to register the type of UI component associated with the addon (e.g., panels, toolbars, tabs). For a minimum viable Storybook addon, you should provide the following arguments:

- `type`: The type of UI component to register.
- `title`: The title to feature in the Addon Panel.
- `render`: The function that renders the addon's UI component.

```js
// my-addon/src/manager.js|ts

const ADDON_ID = 'myaddon';
const PANEL_ID = `${ADDON_ID}/panel`;

addons.register(ADDON_ID, (api) => {
  addons.add(PANEL_ID, {
    type: types.PANEL,
    title: 'My Addon',
    render: ({ active }) => (
      
        <div> Storybook addon panel </div>
      
    ),
  });
});
```

The render function is called with `active`. The `active` value will be true when the panel is focused on the UI.

### addons.register()

Serves as the entry point for all addons. It allows you to register an addon and access the Storybook [API](#storybook-api). For example:

```js
// my-addon/src/manager.js|ts

// Register the addon with a unique name.
addons.register('my-organisation/my-addon', (api) => {});
```

Now you'll get an instance to our StorybookAPI. See the [api docs](#storybook-api) for Storybook API regarding using that.

### addons.getChannel()

Get an instance to the channel to communicate with the manager and the preview. You can find this in both the addon register code and your addon’s wrapper component (where used inside a story).

It has a NodeJS [EventEmitter](https://nodejs.org/api/events.html) compatible API. So, you can use it to emit events and listen to events.

```js
// my-addon/src/manager.js|ts

const ExampleToolbar = () => {
  const [globals, updateGlobals] = useGlobals();

  const isActive = globals['my-param-key'] || false;

  // Function that will update the global value and trigger a UI refresh.
  const refreshAndUpdateGlobal = () => {
    updateGlobals({
      ['my-param-key']: !isActive,
    });
    // Invokes Storybook's addon API method (with the FORCE_RE_RENDER) event to trigger a UI refresh
    addons.getChannel().emit(FORCE_RE_RENDER);
  };

  const toggleToolbarAddon = useCallback(() => refreshAndUpdateGlobal(), [isActive]);

  return (
    
      
    
  );
};
```

### makeDecorator

Use the `makeDecorator` API to create decorators in the style of the official addons. Like so:

```js
// my-addon/src/decorator.js|ts

export const withAddonDecorator = makeDecorator({
  name: 'withSomething',
  parameterName: 'CustomParameter',
  skipIfNoParametersOrOptions: true,
  wrapper: (getStory, context, { parameters }) => {
    /*
     * Write your custom logic here based on the parameters passed in Storybook's stories.
     * Although not advised, you can also alter the story output based on the parameters.
     */
    return getStory(context);
  },
});
```

If the story's parameters include `{ exampleParameter: { disable: true } }` (where `exampleParameter` is the `parameterName` of your addon), your decorator will not be called.

The `makeDecorator` API requires the following arguments:

- `name`: Unique name to identify the custom addon decorator.
- `parameterName`: Sets a unique parameter to be consumed by the addon.
- `skipIfNoParametersOrOptions`: (Optional) Doesn't run the decorator if the user hasn't options either via [decorators](https://storybook.js.org/docs/writing-stories/decorators.md) or [parameters](https://storybook.js.org/docs/writing-stories/parameters.md).
- `wrapper`: your decorator function. Takes the `getStory`, `context`, and both the `options` and `parameters` (as defined in `skipIfNoParametersOrOptions` above).

---

## Storybook API

Storybook's API allows you to access different functionalities of Storybook UI.

### api.selectStory()

The `selectStory` API method allows you to select a single story. It accepts the following two parameters; story kind name and an optional story name. For example:

```tsx
// Button.stories.ts|tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const meta = {
  /* 👇 The title prop is optional.
   * See https://storybook.js.org/docs/configure/#configure-story-loading
   * to learn how to generate automatic titles
   */
  title: 'Button',
  component: Button,
  //👇 Creates specific parameters for the story
  parameters: {
    myAddon: {
      data: 'This data is passed to the addon',
    },
  },
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

/*
 *👇 Render functions are a framework specific feature to allow you control on how the component renders.
 * See https://storybook.js.org/docs/api/csf
 * to learn how to use render functions.
 */
export const Basic: Story = {
  render: () => Hello,
};
```

```tsx
// Button.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  /* 👇 The title prop is optional.
   * See https://storybook.js.org/docs/configure/#configure-story-loading
   * to learn how to generate automatic titles
   */
  title: 'Button',
  component: Button,
  //👇 Creates specific parameters for the story
  parameters: {
    myAddon: {
      data: 'This data is passed to the addon',
    },
  },
});

/*
 *👇 Render functions are a framework specific feature to allow you control on how the component renders.
 * See https://storybook.js.org/docs/api/csf
 * to learn how to use render functions.
 */
export const Basic = meta.story({
  render: () => Hello,
});
```

This is how you can select the above story:

```js
// my-addon/src/manager.js|ts
addons.register('my-organisation/my-addon', (api) => {
  api.selectStory('Button', 'Default');
});
```

### api.selectInCurrentKind()

Similar to the `selectStory` API method, but it only accepts the story as the only parameter.

```js
// my-addon/src/manager.js|ts
addons.register('my-organisation/my-addon', (api) => {
  api.selectInCurrentKind('Default');
});
```

### api.setQueryParams()

This method allows you to set query string parameters. You can use that as temporary storage for addons. Here's how you define query params:

```js
// my-addon/src/manager.js|ts
addons.register('my-organisation/my-addon', (api) => {
  api.setQueryParams({
    exampleParameter: 'Sets the example parameter value',
    anotherParameter: 'Sets the another parameter value',
  });
});
```

Additionally, if you need to remove a query parameter, set it as `null` instead of removing them from the addon. For example:

```js
// my-addon/src/manager.js|ts
addons.register('my-organisation/my-addon', (api) => {
  api.setQueryParams({
    exampleParameter: null,
  });
});
```

### api.getQueryParam()

Allows retrieval of a query parameter enabled via the `setQueryParams` API method. For example:

```js
// my-addon/src/manager.js|ts
addons.register('my-organisation/my-addon', (api) => {
  api.getQueryParam('exampleParameter');
});
```

### api.getUrlState(overrideParams)

This method allows you to get the application URL state, including any overridden or custom parameter values. For example:

```js
// my-addon/src/manager.js|ts
addons.register('my-organisation/my-addon', (api) => {
  const href = api.getUrlState({
    selectedKind: 'kind',
    selectedStory: 'story',
  }).url;
});
```

### api.getStoryHrefs(storyId, options?)

Get the manager and preview URLs for a story. URLs are relative to the current Storybook, unless `base` is set, or in case of previewHref with `refId` set.

- `storyId` (required): The ID of the story to get the URLs for
- `options` (optional):
  - `base`: Return an absolute href based on the current origin or network address.
  - `inheritArgs`: Inherit args from the current URL. If `storyId` matches current story, `inheritArgs` defaults to true.
  - `inheritGlobals`: Inherit globals from the current URL. Defaults to true.
  - `queryParams`: Additional query params to append to the URL (`args` and `globals` are merged when inheriting).
  - `refId`: ID of the ref to get the URL for (for composed Storybooks)
  - `viewMode`: The view mode to use, defaults to 'story'.

```js
addons.register('my-organisation/my-addon', (api) => {
  // Get the manager and preview URLs for a story
  const { managerHref, previewHref } = api.getStoryHrefs('button--primary');

  // Get absolute URLs based on the current manager URL (origin)
  api.getStoryHrefs('button--primary', { base: 'origin' });

  // Get absolute URLs based on the dev server's local network IP address
  api.getStoryHrefs('button--primary', { base: 'network' });

  // Get clean URLs without args or globals
  api.getStoryHrefs('button--primary', { inheritArgs: false, inheritGlobals: false });

  // With args and globals (merged on top of inherited args/globals) as well as a custom query param
  // Note that args and globals should be serialized (see `buildArgsParam` from `storybook/internal/router`)
  api.getStoryHrefs('button--primary', {
    queryParams: { args: 'label:Label', globals: 'outline:!true', custom: 'value' },
  });

  // Link to a story from an external ref
  api.getStoryHrefs('button--primary', { refId: 'external-ref' });

  // Link to a docs page
  api.getStoryHrefs('button--docs', { viewMode: 'docs' });
});
```

### api.on(eventName, fn)

This method allows you to register a handler function called whenever the user navigates between stories.

```js
// my-addon/src/manager.js|ts
addons.register('my-organisation/my-addon', (api) => {
  // Logs the event data to the browser console whenever the event is emitted.
  api.on('custom-addon-event', (eventData) => console.log(eventData));
});
```

### api.openInEditor(payload)

Opens a file in the configured code editor. Useful for "Edit in IDE" functionality in addons.

- `payload.file`: The file path to open (required)
- `payload.line`: Optional line number to jump to
- `payload.column`: Optional column number to jump to

Returns a Promise that resolves with information about whether the operation was successful.

```js
addons.register('my-organisation/my-addon', (api) => {
  // Open a file in the editor
  api.openInEditor({
    file: './src/components/Button.tsx',
  });

  // Handle the api response
  api
    .openInEditor({
      file: './src/components/Button.tsx',
      line: 42,
      column: 15,
    })
    .then((response) => {
      if (response.error) {
        console.error('Failed to open file:', response.error);
      } else {
        console.log('File opened successfully');
      }
    });
});
```

### api.getCurrentStoryData()

Returns the current story's data, including its ID, kind, name, and parameters.

```js
addons.register('my-organisation/my-addon', (api) => {
  // Get data about the currently selected story
  const storyData = api.getCurrentStoryData();
  console.log('Current story:', storyData.id, storyData.title);
});
```

### api.toggleFullscreen(toggled?)

Toggles the fullscreen mode of the Storybook UI. Pass `true` to enable fullscreen, `false` to disable, or omit to toggle the current state.

```js
addons.register('my-organisation/my-addon', (api) => {
  // Toggle fullscreen mode
  api.toggleFullscreen();

  // Enable fullscreen
  api.toggleFullscreen(true);

  // Disable fullscreen
  api.toggleFullscreen(false);
});
```

### api.togglePanel(toggled?)

Toggles the visibility of the addon panel. Pass `true` to show the panel, `false` to hide, or omit to toggle the current state.

```js
addons.register('my-organisation/my-addon', (api) => {
  // Toggle panel visibility
  api.togglePanel();

  // Show the panel
  api.togglePanel(true);

  // Hide the panel
  api.togglePanel(false);
});
```

### api.addNotification(notification)

Displays a notification in the Storybook UI. The notification object should contain `id`, `content`, and optionally `duration` and `icon`.

```js

addons.register('my-organisation/my-addon', (api) => {
  // Add a simple notification
  api.addNotification({
    id: 'my-notification',
    content: {
      headline: 'Action completed',
      subHeadline: 'Your changes have been saved successfully',
    },
    duration: 5000, // 5 seconds
  });

  // Add a notification with an icon
  api.addNotification({
    id: 'success-notification',
    content: {
      headline: 'Success!',
      subHeadline: 'Operation completed successfully',
    },
    icon: ,
    duration: 3000,
  });
});
```

### addons.setConfig(config)

This method allows you to override the default Storybook UI configuration (e.g., set up a [theme](https://storybook.js.org/docs/configure/user-interface/theming.md) or hide UI elements):

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

| Name                  | Type            | Description                                             | Example Value                       |
| --------------------- | --------------- | ------------------------------------------------------- | ----------------------------------- |
| **navSize**           | Number (pixels) | The size of the sidebar that shows a list of stories    | `300`                               |
| **bottomPanelHeight** | Number (pixels) | The size of the addon panel when in the bottom position | `200`                               |
| **rightPanelWidth**   | Number (pixels) | The size of the addon panel when in the right position  | `200`                               |
| **panelPosition**     | String          | Where to show the addon panel                           | `'bottom'` or `'right'`             |
| **enableShortcuts**   | Boolean         | Enable/disable shortcuts                                | `true`                              |
| **showToolbar**       | Boolean         | Show/hide toolbar                                       | `true`                              |
| **theme**             | Object          | Storybook Theme, see next section                       | `undefined`                         |
| **selectedPanel**     | String          | Id to select an addon panel                             | `storybook/actions/panel`           |
| **initialActive**     | String          | Select the default active tab on Mobile                 | `sidebar` or `canvas` or `addons`   |
| **sidebar**           | Object          | Sidebar options, see below                              | `{ showRoots: false }`              |
| **toolbar**           | Object          | Modify the tools in the toolbar using the addon id      | `{ fullscreen: { hidden: false } }` |

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

---

## Storybook hooks

To help streamline addon development and reduce boilerplate code, the API exposes a set of hooks to access Storybook's internals. These hooks are an extension of the `storybook/manager-api` module.

### useStorybookState

It allows access to Storybook's internal state. Similar to the [`useglobals`](#useglobals) hook, we recommend optimizing your addon to rely on [`React.memo`](https://react.dev/reference/react/memo), or the following hooks; [`useMemo`](https://react.dev/reference/react/useMemo), [`useCallback`](https://react.dev/reference/react/useCallback) to prevent a high volume of re-render cycles.

```js
// my-addon/src/manager.js|ts

export const Panel = () => {
  const state = useStorybookState();
  return (
    
      {state.viewMode !== 'docs' ? (
        <h2>Do something with the documentation</h2>
      ) : (
        <h2>Show the panel when viewing the story</h2>
      )}
    
  );
};
```

### useStorybookApi

The `useStorybookApi` hook is a convenient helper to allow you full access to the [Storybook API](#storybook-api) methods.

```js
// my-addon/manager.js|ts

export const Panel = () => {
  const [globals, updateGlobals] = useGlobals();
  const api = useStorybookApi();

  const isActive = [true, 'true'].includes(globals[PARAM_KEY]);

  const toggleMyTool = useCallback(() => {
    updateGlobals({
      [PARAM_KEY]: !isActive,
    });
  }, [isActive]);

  useEffect(() => {
    api.setAddonShortcut('custom-toolbar-addon', {
      label: 'Enable my addon',
      defaultShortcut: ['G'],
      actionName: 'Toggle',
      showInMenu: false,
      action: toggleMyTool,
    });
  }, [api]);

  return (
    
      
    
  );
};
```

### useChannel

Allows setting subscriptions to events and getting the emitter to emit custom events to the channel.

The messages can be listened to on both the iframe and the manager.

```js
// my-addon/manager.js|ts

export const Panel = () => {
  // Creates a Storybook API channel and subscribes to the STORY_CHANGED event
  const emit = useChannel({
    STORY_CHANGED: (...args) => console.log(...args),
  });

  return (
    
       emit('my-event-type', { sampleData: 'example' })}>
        Emit a Storybook API event with custom data
      
    
  );
};
```

### useAddonState

The `useAddonState` is a useful hook for addons that require data persistence, either due to Storybook's UI lifecycle or for more complex addons involving multiple types (e.g., toolbars, panels).

```js
// my-addon/manager.js|ts

export const Panel = () => {
  const [state, setState] = useAddonState('addon-unique-identifier', 'initial state');

  return (
    
       setState('Example')}>
        Click to update Storybook's internal state
      
    
  );
};
export const Tool = () => {
  const [state, setState] = useAddonState('addon-unique-identifier', 'initial state');

  return (
     setState('Example')}
    >
      
    
  );
};
```

### useParameter

The `useParameter` retrieves the current story's parameters. If the parameter's value is not defined, it will automatically default to the second value defined.

```js
// my-addon/manager.js|ts

export const Panel = () => {
  // Connects to Storybook's API and retrieves the value of the custom parameter for the current story
  const value = useParameter('custom-parameter', 'initial value');

  return (
    
      {value === 'initial value' ? (
        <h2>The story doesn't contain custom parameters. Defaulting to the initial value.</h2>
      ) : (
        <h2>You've set {value} as the parameter.</h2>
      )}
    
  );
};
```

### useGlobals

Extremely useful hook for addons that rely on Storybook [Globals](https://storybook.js.org/docs/essentials/toolbars-and-globals.md). It allows you to obtain and update `global` values. We also recommend optimizing your addon to rely on [`React.memo`](https://react.dev/reference/react/memo), or the following hooks; [`useMemo`](https://react.dev/reference/react/useMemo), [`useCallback`](https://react.dev/reference/react/useCallback) to prevent a high volume of re-render cycles.

```js
// my-addon/manager.js|ts

export const Panel = () => {
  const [globals, updateGlobals] = useGlobals();

  const isActive = globals['my-param-key'] || false; // 👈 Sets visibility based on the global value.

  return (
    
       updateGlobals({ ['my-param-key']: !isActive })}>
        {isActive ? 'Hide the addon panel' : 'Show the panel'}
      
    
  );
};
```

### useArgs

Hook that allows you to retrieve or update a story's [`args`](https://storybook.js.org/docs/writing-stories/args.md).

```js
// my-addon/src/manager.js|ts

const [args, updateArgs, resetArgs] = useArgs();

// To update one or more args:
updateArgs({ key: 'value' });

// To reset one (or more) args:
resetArgs((argNames: ['key']));

// To reset all args
resetArgs();
```

**Learn more about the Storybook addon ecosystem**

- [Types of addons](https://storybook.js.org/docs/addons/addon-types.md) for other types of addons
- [Writing addons](https://storybook.js.org/docs/addons/writing-addons.md) for the basics of addon development
- [Presets](https://storybook.js.org/docs/addons/writing-presets.md) for preset development
- [Integration catalog](https://storybook.js.org/docs/addons/integration-catalog.md) for requirements and available recipes
- API reference to learn about the available APIs
