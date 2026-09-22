# Mocking modules

Components often depend on other modules, such as other components, utility functions, or libraries. These can be from external packages or internal to your project. When rendering those components in Storybook or [testing](https://storybook.js.org/docs/writing-tests.md) them, you may want to mock those modules to control their behavior and isolate the component's functionality.

For example, this simple component depends on two modules, a local utility function to access the user's browser session and an external package to generate a unique ID:

```jsx title="AuthButton.jsx"

export function AuthButton() {
  const user = getUserFromSession();
  const id = uuidv4();

  return (
    <button
      onClick={() => {
        console.log(`User: ${user.name}, ID: ${id}`);
      }}
    >
      {user ? `Welcome, ${user.name}` : 'Sign in'}
    </button>
  );
}
```

The above example is written with React, but the same principles apply to other renderers like Vue, Svelte, or Web Components. The important part is the usage of the two module dependencies.

When writing stories or tests for this component, you may want to mock the `getUserFromSession` function to control the user data returned, or mock the `uuidv4` function to return a predictable ID. This allows you to test the component's behavior without relying on the actual implementations of these modules.

For maximum flexibility, Storybook provides three ways to mock modules for your stories. Let's walk through each of them, starting with the most straightforward approach.

## Automocking

Automocking is the most straightforward way to mock modules in Storybook, and we recommend it for all projects using the [Vite](https://storybook.js.org/docs/builders/vite.md) and [Webpack](https://storybook.js.org/docs/builders/webpack.md) builders (other builders must use one of the other techniques, below). This approach requires minimal configuration while allowing for flexible mocking of modules.

It works with two steps. First, register the modules you want to mock in your Storybook configuration. Then, control the behavior and make assertions about the mocked modules in your stories.

### Registering modules to mock

When automocking, you use the `sb.mock` utility function to register modules you want to mock. There are three ways to register modules: as spy-only, fully automocked, or with a mock file. Each method has its use cases and benefits.

There are some key details to keep in mind when using the `sb.mock` utility:

- You can register both local modules (e.g., `../lib/session.ts`) and packages in `node_modules` (e.g., `uuid`).
- You can only register mocked modules in your project-level configuration: `.storybook/preview.*`. This ensures consistent and performant mocking across all stories in your project. You can modify the behavior of these modules in your stories, but you cannot register them directly in the story files.
- When registering a mock for a local module, the path must:
  - Not use an alias or subpath import (e.g., `@/lib/session.ts` or `#lib/session`).
  - Be relative to the `.storybook/preview.*` file.
  - Include the file extension (e.g., `.ts` or `.js`).
- If you are using Typescript, you can wrap the module path in `import()` to ensure the module is correctly resolved and typed. For example, `sb.mock(import('../lib/session.ts'))`.
- If you are using the [Webpack builder](https://storybook.js.org/docs/builders/webpack.md), you can only automock `node_module` packages that have ESModules (ESM) entry points. If a module has both CommonJS (CJS) and ESM entry points, Webpack doesn't correctly resolve the ESM entry and it cannot be mocked. Webpack users can still mock CJS `node_module` packages by providing a [mock file](#mock-files).

#### Spy-only

For most cases, you should register a mocked module as spy-only, by setting the `spy` option to `true`. This leaves the original module's functionality intact, while still allowing you to modify the behavior if needed and make assertions in your tests.

For example, if you want to spy on the `getUserFromSession` function and the `uuidv4` function from the `uuid` package, you can call the `sb.mock` utility function in your `.storybook/preview.*` file:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, vue3-vite, sveltekit)

// 👇 Automatically spies on all exports from the `lib/session` local module
sb.mock(import('../lib/session.ts'), { spy: true });
// 👇 Automatically spies on all exports from the `uuid` package in `node_modules`
sb.mock(import('uuid'), { spy: true });

const preview: Preview = {
  // ...
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

// 👇 Automatically spies on all exports from the `lib/session` local module
sb.mock(import('../lib/session.ts'), { spy: true });
// 👇 Automatically spies on all exports from the `uuid` package in `node_modules`
sb.mock(import('uuid'), { spy: true });

export default definePreview({
  // ...
});
```

If you need to mock an external module that has a deeper import path (e.g. `lodash-es/add`), register the mock with that path.

You can then [control the behavior of these modules](#using-automocked-modules-in-stories) and make assertions about them in your stories, such as checking if a function was called or what arguments it was called with.

#### Fully automocked modules

For cases where you need to prevent the original module's functionality from executing, set the `spy` option to `false` (or omit it, because that is the default value). This will automatically replace all exports from the module with [Vitest mock functions](https://vitest.dev/api/mock.html), allowing you to control their behavior and make assertions while being certain that the original functionality never runs.

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, vue3-vite, sveltekit)

// 👇 Automatically replaces all exports from the `lib/session` local module with mock functions
sb.mock(import('../lib/session.ts'));
// 👇 Automatically replaces all exports from the `uuid` package in `node_modules` with mock functions
sb.mock(import('uuid'));

const preview: Preview = {
  // ...
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

// 👇 Automatically replaces all exports from the `lib/session` local module with mock functions
sb.mock(import('../lib/session.ts'));
// 👇 Automatically replaces all exports from the `uuid` package in `node_modules` with mock functions
sb.mock(import('uuid'));

export default definePreview({
  // ...
});
```

Fully automocked modules do not execute their exported functions, but the module is still evaluated, along with its dependencies. This means that if the module has side effects (e.g., modifying global state, logging to the console, etc.), those side effects will still occur. Similarly, a module written to run on the server will attempt to be evaluated in the browser. If you want to prevent the original module's code from running entirely, you should use a [mock file](#mock-files) instead.

You can then [control the behavior of these modules](#using-automocked-modules-in-stories) and make assertions about them in your stories, just like with the spy-only approach.

#### Mock files

If you want to mock a module with more complex behavior or reuse a mock's behavior across multiple stories, you can create a mock file. This file should be placed in a `__mocks__` directory next to the module you want to mock, and it should export the same named exports as the original module.

For example, to mock the `session` module in the `lib` directory, create a file named `session.js|ts` in the `lib/__mocks__` directory:

```js title="lib/__mocks__/session.js"
export function getUserFromSession() {
  return { name: 'Mocked User' };
}
```

For packages in your `node_modules`, create a `__mocks__` directory in the root of your project and create the mock file there. For example, to mock the `uuid` package, create a file named `uuid.js` in the `__mocks__` directory:

```js title="__mocks__/uuid.js"
export function v4() {
  return '1234-5678-90ab-cdef';
}
```

If you need to mock an external module that has a deeper import path (e.g. `lodash-es/add`), create a corresponding mock file (e.g. `__mocks__/lodash-es/add.js`) in the root of your project.

The root of your project is determined differently depending on your builder:

**Vite projects**

The root `__mocks__` directory should be placed in the [`root` directory](https://vite.dev/config/shared-options.html#root), as defined in your project's Vite configuration (typically `process.cwd()`) If that is unavailable, it defaults to the directory containing your `.storybook` directory.

**Webpack projects**

The root `__mocks__` directory should be placed in the [`context` directory](https://webpack.js.org/configuration/entry-context/#context), as defined in your project's Webpack configuration (typically `process.cwd()`). If that is unavailable, it defaults to the root of your repository.

Mock files must be written with JavaScript (not TypeScript) using ESModules (not CJS).

They must export the same named exports as the original module. If you want to mock a default export, you can use `export default` in the mock file.

You can then use the `sb.mock` utility to register these mock files in your `preview.*` file:

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, vue3-vite, sveltekit)

// 👇 Replaces imports of this module with imports to `../lib/__mocks__/session.ts`
sb.mock(import('../lib/session.ts'));
// 👇 Replaces imports of this module with imports to `../__mocks__/uuid.ts`
sb.mock(import('uuid'));

const preview: Preview = {
  // ...
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

// 👇 Replaces imports of this module with imports to `../lib/__mocks__/session.ts`
sb.mock(import('../lib/session.ts'));
// 👇 Replaces imports of this module with imports to `../__mocks__/uuid.ts`
sb.mock(import('uuid'));

export default definePreview({
  // ...
});
```

Note that the API for registering automatically mocked modules and mock files is the same. The only difference is that `sb.mock` will first look for a mock file in the appropriate directory before automatically mocking the module.

### Using automocked modules in stories

All registered automocked modules are used the same way within your stories. You can control the behavior, such as defining what it returns, and make assertions about the modules.

```ts
// AuthButton.stories.ts — CSF 3
// Replace your-framework with the name of your framework (e.g. react-vite, vue3-vite, etc.)

const meta = {
  component: AuthButton,
  // 👇 This will run before each story is rendered
  beforeEach: async () => {
    // 👇 Force known, consistent behavior for mocked modules
    mocked(uuidv4).mockReturnValue('1234-5678-90ab-cdef');
    mocked(getUserFromSession).mockReturnValue({ name: 'John Doe' });
  },
} satisfies Meta<typeof AuthButton>;
export default meta;

type Story = StoryObj<typeof meta>;

export const LogIn: Story = {
  play: async ({ canvas, userEvent }) => {
    const button = canvas.getByRole('button', { name: 'Sign in' });
    userEvent.click(button);

    // Assert that the getUserFromSession function was called
    expect(getUserFromSession).toHaveBeenCalled();
  },
};
```

```ts
// AuthButton.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: AuthButton,
  // 👇 This will run before each story is rendered
  beforeEach: async () => {
    // 👇 Force known, consistent behavior for mocked modules
    mocked(uuidv4).mockReturnValue('1234-5678-90ab-cdef');
    mocked(getUserFromSession).mockReturnValue({ name: 'John Doe' });
  },
});

export const LogIn = meta.story({
  play: async ({ canvas, userEvent }) => {
    const button = canvas.getByRole('button', { name: 'Sign in' });
    userEvent.click(button);

    // Assert that the getUserFromSession function was called
    expect(getUserFromSession).toHaveBeenCalled();
  },
});
```

Mocked functions created with the `sb.mock` utility are full [Vitest mock functions](https://vitest.dev/api/mock.html), which means you can use all the methods available on them. Some of the most useful methods include:

| Method                                                                           | Description                                           |
| -------------------------------------------------------------------------------- | ----------------------------------------------------- |
| [`mockReturnValue(value)`](https://vitest.dev/api/mock.html#mockreturnvalue)     | Sets the return value of the mocked function.         |
| [`mockResolvedValue(value)`](https://vitest.dev/api/mock.html#mockresolvedvalue) | Sets the value the mocked async function resolves to. |
| [`mockImplementation(fn)`](https://vitest.dev/api/mock.html#mockimplementation)  | Sets a custom implementation for the mocked function. |

If you are [writing your stories in TypeScript](https://storybook.js.org/docs/writing-stories/typescript.md), you can use the `mocked` utility from `storybook/test` to ensure that the mocked functions are correctly typed in your stories. This utility is a type-safe wrapper around the Vitest `vi.mocked` function.

### How it works

Storybook's automocking is built on Vitest's mocking engine. The behavior adjusts depending on whether you're in development mode or build mode:

**Dev Mode**

In dev mode, mocking relies on Vite's module graph invalidation. When a mock is added, changed, or removed (either in `.storybook/preview.*` or the `__mocks__` directory), the plugin intelligently invalidates all affected modules and triggers a hot reload. This provides a fast and interactive development experience.

**Dev and build mode**

- Build-time analysis: A new Vite plugin, viteMockPlugin, scans `.storybook/preview.*` for all `sb.mock()` calls during the build process.
- Mock Processing:
  - `__mocks__` redirects: If a corresponding file is found in the top-level `__mocks__` directory, that file is loaded and transformed by Vite.
  - Automocking & spies: If no `__mocks__` file is found, the original module's code is transformed at build-time to replace its exports with mocks or spies.
- No runtime overhead: Because all mocking decisions and transformations happen at build time, there is no performance penalty or complex interception logic needed in the final built application. The mocked modules are directly bundled in place of the originals.

#### Comparison to Vitest mocking

While this feature uses Vitest's mocking engine, the implementation within Storybook has some key differences:

- Scope: Mocks are global and defined only in `.storybook/preview.*`. Unlike Vitest, you cannot call `sb.mock()` inside individual story files.
- Static by Design: All mocking decisions are finalized at build time. This makes the system robust and performant but less dynamic than Vitest's test-by-test mocking capabilities. There is no `sb.unmock()` or equivalent, as the module graph is fixed in a production build.
- Runtime Mocking: While the module swap is static, you can still control the behavior of the mocked functions at runtime within a play function or `beforeEach` hook (e.g., `mocked(myFunction).mockReturnValue('new value')`).
- No Factory Functions: The `sb.mock()` API does not accept a factory function as its second argument (e.g., `sb.mock('path', () => ({...}))`). This is because all mocking decisions are resolved at build time, whereas factories are executed at runtime.

## Alternative methods

If [automocking](#automocking) is not suitable for your project, there are two alternative methods to mock modules in Storybook: [subpath imports](#subpath-imports) and [builder aliases](#builder-aliases). These methods require a bit more setup but provide similar functionality to automocking, allowing you to control the behavior of modules in your stories.

### Subpath imports

You can use [subpath imports](https://nodejs.org/api/packages.html#subpath-imports), a Node feature, to mock modules. Subpath imports allow you to define custom paths for modules in your project, which can be used to replace the original module with a mock file. They work with both the [Vite](https://storybook.js.org/docs/builders/vite.md) and [Webpack](https://storybook.js.org/docs/builders/webpack.md) builders.

#### Mock files

To mock a module, create a file with the same name and in the same directory as the module you want to mock. For example, to mock a module named `session`, create a file next to it named `session.mock.js|ts`, with a few characteristics:

- It must import the original module using a relative import.
  - Using a subpath or alias import would result in it importing itself.
- It should re-export all exports from the original module.
- It should use the `fn` utility to mock any necessary functionality from the original module.
- It should use the [`mockName`](https://vitest.dev/api/mock.html#mockname) method to ensure the name is preserved when minified
- It should not introduce side effects that could affect other tests or components. Mock files should be isolated and only affect the module they are mocking.

Here's an example of a mock file for a module named `session`:

```ts
// lib/session.mock.ts

export * from './session';
export const getUserFromSession = fn(actual.getUserFromSession).mockName('getUserFromSession');
```

When you use the `fn` utility to mock a module, you create full [Vitest mock functions](https://vitest.dev/api/mock.html). See [below](#using-mocked-modules-in-stories) for examples of how you can use a mocked module in your stories.

**Mock files for external modules**

You can't directly mock an external module like [`uuid`](https://github.com/uuidjs/uuid) or `node:fs`. Instead, you must wrap it in your own module, which you can mock like any other internal one. For example, with `uuid`, you could do the following:

```ts title="lib/uuid.ts"

export const uuidv4 = v4;
```

And create a mock for the wrapper:

```ts title="lib/uuid.mock.ts"

export const uuidv4 = fn(actual.uuidv4).mockName('uuidv4');
```

#### Configuration

To configure subpath imports, you define the `imports` property in your project's `package.json` file. This property maps the subpath to the actual file path. The example below configures subpath imports for four internal modules:

```jsonc
// package.json
{
  "imports": {
    "#api": {
      // storybook condition applies to Storybook
      "storybook": "./api.mock.ts",
      "default": "./api.ts",
    },
    "#app/actions": {
      "storybook": "./app/actions.mock.ts",
      "default": "./app/actions.ts",
    },
    "#lib/session": {
      "storybook": "./lib/session.mock.ts",
      "default": "./lib/session.ts",
    },
    "#lib/db": {
      // test condition applies to test environments *and* Storybook
      "test": "./lib/db.mock.ts",
      "default": "./lib/db.ts",
    },
    "#*": ["./*", "./*.ts", "./*.tsx"],
  },
}
```

There are three aspects to this configuration worth noting:

First, **each subpath must begin with `#`**, to differentiate it from a regular module path. The `#*` entry is a catch-all that maps all subpaths to the root directory.

Second, the order of the keys is important. The `default` key should come last.

Third, note the **`storybook`, `test`, and `default` keys** in each module's entry. The `storybook` value is used to import the mock file when loaded in Storybook, while the `default` value is used to import the original module when loaded in your project. The `test` condition is also used within Storybook, which allows you to use the same configuration in Storybook and your other tests.

With the package configuration in place, you can then update your component file to use the subpath import:

```ts title="AuthButton.ts"
// ➖ Remove this line
// import { getUserFromSession } from '../../lib/session';
// ➕ Add this line

// ...rest of the file
```

Subpath imports will only be correctly resolved and typed when the [`moduleResolution` property](https://www.typescriptlang.org/tsconfig/#moduleResolution) is set to `'Bundler'`, `'NodeNext'`, or `'Node16'` in your TypeScript configuration.

If you are currently using `'node'`, that is intended for projects using a Node.js version older than v10. Projects written with modern code likely do not need to use `'node'`.

Storybook recommends the [TSConfig Cheat Sheet](https://www.totaltypescript.com/tsconfig-cheat-sheet) for guidance on setting up your TypeScript configuration.

#### Using subpath imports in stories

When you use the `fn` utility to mock a module, you create full [Vitest mock functions](https://vitest.dev/api/mock.html), which have many methods available. Some of the most useful methods include:

| Method                                                                           | Description                                           |
| -------------------------------------------------------------------------------- | ----------------------------------------------------- |
| [`mockReturnValue(value)`](https://vitest.dev/api/mock.html#mockreturnvalue)     | Sets the return value of the mocked function.         |
| [`mockResolvedValue(value)`](https://vitest.dev/api/mock.html#mockresolvedvalue) | Sets the value the mocked async function resolves to. |
| [`mockImplementation(fn)`](https://vitest.dev/api/mock.html#mockimplementation)  | Sets a custom implementation for the mocked function. |

Here, we define `beforeEach` on a story (which will run before the story is rendered) to set a mocked return value for the `getUserFromSession` function used by the Page component:

```ts
// Page.stories.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

// 👇 Automocked module resolves to '../lib/__mocks__/session'

const meta = {
  component: Page,
} satisfies Meta<typeof Page>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Basic: Story = {
  async beforeEach() {
    // 👇 Set the return value for the getUserFromSession function
    mocked(getUserFromSession).mockReturnValue({ id: '1', name: 'Alice' });
  },
};
```

```ts
// Page.stories.ts — CSF Next 🧪

// 👇 Automocked module resolves to '../lib/__mocks__/session'

const meta = preview.meta({
  component: Page,
});

export const Basic = meta.story({
  async beforeEach() {
    // 👇 Set the return value for the getUserFromSession function
    mocked(getUserFromSession).mockReturnValue({ id: '1', name: 'Alice' });
  },
});
```

If you are [writing your stories in TypeScript](https://storybook.js.org/docs/writing-stories/typescript.md), you must import your mock modules using the full mocked file name to have the functions correctly typed in your stories. You do **not** need to do this in your component files. That's what the [subpath import](#subpath-imports) or [builder alias](#builder-aliases) is for.

#### Spying on mocked modules

The `fn` utility also spies on the original module's functions, which you can use to assert their behavior in your tests. For example, you can use [interaction tests](https://storybook.js.org/docs/writing-tests/interaction-testing.md) to verify that a function was called with specific arguments.

For example, this story checks that the `saveNote` function was called when the user clicks the save button:

```ts
// NoteUI.stories.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

// 👇 Automocked module resolves to '../app/__mocks__/actions'

const meta = { component: NoteUI } satisfies Meta<typeof NoteUI>;
export default meta;

type Story = StoryObj<typeof meta>;

const notes = createNotes();

export const SaveFlow: Story = {
  name: 'Save Flow ▶',
  args: {
    isEditing: true,
    note: notes[0],
  },
  play: async ({ canvas, userEvent }) => {
    const saveButton = canvas.getByRole('menuitem', { name: /done/i });
    await userEvent.click(saveButton);
    // 👇 This is the mock function, so you can assert its behavior
    await expect(saveNote).toHaveBeenCalled();
  },
};
```

```ts
// NoteUI.stories.ts — CSF Next 🧪

// 👇 Automocked module resolves to '../app/__mocks__/actions'

const meta = preview.meta({ component: NoteUI });

const notes = createNotes();

export const SaveFlow = meta.story({
  name: 'Save Flow ▶',
  args: {
    isEditing: true,
    note: notes[0],
  },
  play: async ({ canvas, userEvent }) => {
    const saveButton = canvas.getByRole('menuitem', { name: /done/i });
    await userEvent.click(saveButton);
    // 👇 This is the mock function, so you can assert its behavior
    await expect(saveNote).toHaveBeenCalled();
  },
});
```

### Builder aliases

If your project is unable to use [automocking](#automocking) or [subpath imports](#subpath-imports), you can configure your Storybook builder to alias the module to the [mock file](#mock-files-1). This will instruct the builder to replace the module with the mock file when bundling your Storybook stories.

```ts
// .storybook/main.ts — Vite (CSF 3)
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs-vite, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  viteFinal: async (config) => {
    if (config.resolve) {
      config.resolve.alias = {
        ...config.resolve?.alias,
        // 👇 External module
        lodash: import.meta.resolve('./lodash.mock'),
        // 👇 Internal modules
        '@/api': import.meta.resolve('./api.mock.ts'),
        '@/app/actions': import.meta.resolve('./app/actions.mock.ts'),
        '@/lib/session': import.meta.resolve('./lib/session.mock.ts'),
        '@/lib/db': import.meta.resolve('./lib/db.mock.ts'),
      };
    }

    return config;
  },
};

export default config;
```

```ts
// .storybook/main.ts — Webpack (CSF 3)
// Replace your-framework with the framework you are using (e.g., nextjs, react-webpack5)

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config) => {
    if (config.resolve) {
      config.resolve.alias = {
        ...config.resolve.alias,
        // 👇 External module
        lodash: import.meta.resolve('./lodash.mock'),
        // 👇 Internal modules
        '@/api$': import.meta.resolve('./api.mock.ts'),
        '@/app/actions$': import.meta.resolve('./app/actions.mock.ts'),
        '@/lib/session$': import.meta.resolve('./lib/session.mock.ts'),
        '@/lib/db$': import.meta.resolve('./lib/db.mock.ts'),
      };
    }

    return config;
  },
};

export default config;
```

```ts
// .storybook/main.ts — Vite (CSF Next 🧪)
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  viteFinal: async (config) => {
    if (config.resolve) {
      config.resolve.alias = {
        ...config.resolve?.alias,
        // 👇 External module
        lodash: import.meta.resolve('./lodash.mock'),
        // 👇 Internal modules
        '@/api': import.meta.resolve('./api.mock.ts'),
        '@/app/actions': import.meta.resolve('./app/actions.mock.ts'),
        '@/lib/session': import.meta.resolve('./lib/session.mock.ts'),
        '@/lib/db': import.meta.resolve('./lib/db.mock.ts'),
      };
    }

    return config;
  },
});
```

```ts
// .storybook/main.ts — Webpack (CSF Next 🧪)
// Replace your-framework with the framework you are using (e.g., nextjs, react-webpack5)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  webpackFinal: async (config) => {
    if (config.resolve) {
      config.resolve.alias = {
        ...config.resolve.alias,
        // 👇 External module
        lodash: import.meta.resolve('./lodash.mock'),
        // 👇 Internal modules
        '@/api$': import.meta.resolve('./api.mock.ts'),
        '@/app/actions$': import.meta.resolve('./app/actions.mock.ts'),
        '@/lib/session$': import.meta.resolve('./lib/session.mock.ts'),
        '@/lib/db$': import.meta.resolve('./lib/db.mock.ts'),
      };
    }

    return config;
  },
});
```

Usage of the aliased module in stories is similar to when [using subpath imports in stories](#using-subpath-imports-in-stories), but you import the module using the alias instead of the subpath.

---

## Common scenarios

### Setting up and cleaning up

Before the story renders, you can use the asynchronous `beforeEach` function to perform any setup you need (e.g., configure the mock behavior). This function can be defined at the story, component (which will run for all stories in the file), or project (defined in `.storybook/preview.*`, which will run for all stories in the project).

You can also return a cleanup function from `beforeEach` which will be called after your story unmounts. This is useful for tasks like unsubscribing observers, etc.

It is _not_ necessary to restore `fn()` mocks with the cleanup function, as Storybook will already do that automatically before rendering a story. See the [`parameters.test.restoreMocks` API](https://storybook.js.org/docs/api/parameters.md#restoremocks) for more information.

Here's an example of using the [`mockdate`](https://github.com/boblauer/MockDate) package to mock the [`Date`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date) and reset it when the story unmounts.

```ts
// Page.stories.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: Page,
  // 👇 Set the value of Date for every story in the file
  async beforeEach() {
    MockDate.set('2024-02-14');

    // 👇 Reset the Date after each story
    return () => {
      MockDate.reset();
    };
  },
} satisfies Meta<typeof Page>;
export default meta;

type Story = StoryObj<typeof meta>;

export const Basic: Story = {
  async play({ canvas }) {
    // ... This will run with the mocked Date
  },
};
```

```ts
// Page.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: Page,
  // 👇 Set the value of Date for every story in the file
  async beforeEach() {
    MockDate.set('2024-02-14');

    // 👇 Reset the Date after each story
    return () => {
      MockDate.reset();
    };
  },
});

export const Basic = meta.story({
  async play({ canvas }) {
    // ... This will run with the mocked Date
  },
});
```

---

## Troubleshooting

### Receiving an `exports is not defined` error

Webpack projects may encounter an `exports is not defined` error when using [automocking](#automocking). This is usually caused by attempting to mock a module with CommonJS (CJS) entry points. Automocking with Webpack only works with modules that have ESModules (ESM) entry points exclusively, so you must use a [mock file](#mock-files) to mock CJS modules.

### Mocking conflicts with other testing tools

If you've already set up mocking with other testing tools (e.g., [Jest](https://jestjs.io/)), you may encounter conflicts when using Storybook's mocking system. These conflicts can cause unexpected behavior, errors, or incorrect mocks when both tools try to mock the same module. This is a known issue when sharing mock files or configurations between Storybook and other testing tools. To address this situation, we recommend that you verify which tool is responsible for mocking a particular module and make sure the configurations do not overlap to avoid any conflicts.
