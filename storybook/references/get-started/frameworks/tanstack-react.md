# Storybook for TanStack React

Storybook for TanStack React is Storybook's [framework](https://storybook.js.org/docs/contribute/framework.md) integration for [TanStack Router](https://tanstack.com/router) and [TanStack Start](https://tanstack.com/start/latest) applications built with [React](https://react.dev/) and [Vite](https://vitejs.dev/).

It builds on [`@storybook/react-vite`](https://storybook.js.org/docs/get-started/frameworks/react-vite.md) to add router-aware story rendering, automatic router mocking, and mocked TanStack Start server functions. Components that depend on routing or server functions can render inside Storybook without booting your full app runtime.

## Install

To install Storybook in an existing TanStack Router or TanStack Start project, run this command in your project's root directory:

```shell
npm create storybook@latest
```

```shell
pnpm create storybook@latest
```

```shell
yarn create storybook
```

You can then get started [writing stories](https://storybook.js.org/docs/get-started/whats-a-story.md), [running tests](https://storybook.js.org/docs/writing-tests.md), and [documenting your components](https://storybook.js.org/docs/writing-docs.md). For more control over the installation process, refer to the [installation guide](https://storybook.js.org/docs/get-started/install.md).

### Requirements

This integration expects a TanStack Router application with `@tanstack/react-router` available in your project. If your app uses TanStack Start APIs such as server functions, keep the matching TanStack Start packages installed as well.

## Run Storybook

To run Storybook for a particular project, run the following:

```shell
npm run storybook
```

```shell
pnpm run storybook
```

```shell
yarn storybook
```

To build Storybook, run:

```shell
npm run build-storybook
```

```shell
pnpm run build-storybook
```

```shell
yarn build-storybook
```

You will find the output in the configured `outputDir` (default is `storybook-static`).

## Configure

Storybook for TanStack React uses Vite through [`@storybook/builder-vite`](https://storybook.js.org/docs/builders/vite.md) and automatically wraps each story in a [memory-backed TanStack Router](https://tanstack.com/router/latest/docs/guide/history-types#memory-routing). This gives you a working router context in Storybook without having to boot your full application shell.

Out of the box, it supports these workflows:

- Supply a TanStack Route to render it as the story component
- Set the initial route, params, and query string per story
- Override `loader`, `beforeLoad`, and more on the story route without modifying the original route object via `routeOverrides`
- Automatically mock `@tanstack/react-router` so navigation hooks work in stories and navigation attempts can be observed
- Automatically stub TanStack Start server and runtime entry points so components using server functions can render in Storybook

### Routing

#### Rendering a Route

Supply a TanStack Route object via `parameters.tanstack.router.route`. Storybook extracts the route's React component from the route and keeps the route available for typed router configuration.

```ts
// Page.stories.ts — CSF 3

const meta = {
  parameters: {
    layout: 'fullscreen',
    tanstack: {
      router: {
        route: Route, // 👈 Supply the Route here
        // 👇 Rest of these properties are type-safe
        params: { id: '42' },
        query: { tab: 'details' },
      },
    },
  },
} satisfies Meta<typeof Route>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Default: Story = {};

export const WithCustomLoader: Story = {
  parameters: {
    tanstack: {
      router: {
        route: Route, // 👈 Supply the Route here
        // 👇 Rest of these properties are type-safe
        params: { id: '42' },
        routeOverrides: {
          '/items/$id': {
            loader: async () => ({
              item: { id: '42', name: 'Loaded inside Storybook' },
            }),
          },
        },
      },
    },
  },
};
```

```ts
// Page.stories.ts — CSF Next 🧪

const meta = preview.meta({
  parameters: {
    layout: 'fullscreen',
    tanstack: {
      router: {
        route: Route, // 👈 Supply the Route here
        // 👇 Rest of these properties are type-safe
        params: { id: '42' },
        query: { tab: 'details' },
      },
    },
  },
});

export const Default = meta.story();

export const WithCustomLoader = meta.story({
  parameters: {
    tanstack: {
      router: {
        route: Route, // 👈 Supply the Route here
        // 👇 Rest of these properties are type-safe
        params: { id: '42' },
        routeOverrides: {
          '/items/$id': {
            loader: async () => ({
              item: { id: '42', name: 'Loaded inside Storybook' },
            }),
          },
        },
      },
    },
  },
});
```

##### Handling dynamic params (e.g., `/$id`)

Supply `params` alongside `routeOverrides` under `parameters.tanstack.router`. The `params` object is interpolated into the URL, and `routeOverrides` lets you stub the loader without touching the original route.

```ts
// Showcase.stories.ts — CSF 3

const meta = {
  parameters: {
    tanstack: {
      router: {
        route: Route,
        params: { id: '42' },
        routeOverrides: {
          '/showcase/$id': {
            loader: () => ({ item: mockItem }),
          },
        },
      },
    },
  },
} satisfies Meta<typeof Route>;

export default meta;
```

```ts
// Showcase.stories.ts — CSF Next 🧪

const meta = preview.meta({
  parameters: {
    tanstack: {
      router: {
        route: Route,
        params: { id: '42' },
        routeOverrides: {
          '/showcase/$id': {
            loader: () => ({ item: mockItem }),
          },
        },
      },
    },
  },
});
```

For the full set of properties, see [`Parameters`](#parameters).

#### Rendering nested routes

When `route` is a file route connected to your app's route tree, Storybook automatically includes parent layout routes so the story renders inside the same nested hierarchy as the real app. You can also pass the `routeTree` export from `routeTree.gen.ts` directly.

Use `path` to navigate to the specific route, and `routeOverrides` to stub guards or loaders on ancestor routes so the story can render independently.

```ts
// SettingsProfile.stories.ts — CSF 3

// 👇 Route file is part of the app route tree

const meta = {
  parameters: {
    tanstack: {
      router: {
        // 👇 Storybook walks up the tree to root and duplicates the full route tree,
        //    so parent layouts (e.g. the authenticated shell) also render.
        route: Route,
        path: '/settings/profile',
        // 👇 Stub out any parent route guards so the story can render standalone.
        routeOverrides: {
          '/_authenticated': { beforeLoad: () => {} },
        },
      },
    },
  },
} satisfies Meta<typeof Route>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
```

```ts
// SettingsProfile.stories.ts — CSF Next 🧪

// 👇 Route file is part of the app route tree

const meta = preview.meta({
  parameters: {
    tanstack: {
      router: {
        // 👇 Storybook walks up the tree to root and duplicates the full route tree,
        //    so parent layouts (e.g. the authenticated shell) also render.
        route: Route,
        path: '/settings/profile',
        // 👇 Stub out any parent route guards so the story can render standalone.
        routeOverrides: {
          '/_authenticated': { beforeLoad: () => {} },
        },
      },
    },
  },
});

export const Default = meta.story();
```

#### Using router parameters with a non-Route component

If your story renders a regular React component instead of a route object, you can still provide routing context through `parameters.tanstack.router`.

```ts
// Page.stories.ts — CSF 3

const meta = {
  component: Page,
} satisfies Meta<typeof Page>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Default: Story = {
  parameters: {
    tanstack: {
      router: {
        route: {
          path: '/demo/form/address',
        },
        query: { view: 'list' },
      },
    },
  },
};
```

```ts
// Page.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: Page,
});

export const Default = meta.story({
  parameters: {
    tanstack: {
      router: {
        route: {
          path: '/demo/form/address',
        },
        query: { view: 'list' },
      },
    },
  },
});
```

This is useful when your component reads from hooks such as `useRouterState`, `useSearch`, `useParams`, or `useLoaderData`, but you do not want to make the route itself the story component.

#### Defining search params and URL fragments (hashes)

Use `query` for search params (e.g., `?tab=details&page=2`) and `path` for a URL fragment (e.g., `#section-name`) under `parameters.tanstack.router`:

```ts
// Page.stories.ts — CSF 3

const meta = {
  parameters: {
    tanstack: {
      router: {
        route: Route,
      },
    },
  },
} satisfies Meta<typeof Route>;

export default meta;
type Story = StoryObj<typeof meta>;

export const WithHash: Story = {
  parameters: {
    tanstack: {
      // 👇 Provide the URL fragment (hash) for the route
      router: { path: '/#section-name' },
    },
  },
};

export const WithSearch: Story = {
  parameters: {
    tanstack: {
      // 👇 Provide the query string for the route
      router: { query: { tab: 'details', page: '2' } },
    },
  },
};
```

```ts
// Page.stories.ts — CSF Next 🧪

const meta = preview.meta({
  parameters: {
    tanstack: {
      router: {
        route: Route,
      },
    },
  },
});

export const WithHash = meta.story({
  parameters: {
    tanstack: {
      // 👇 Provide the URL fragment (hash) for the route
      router: { path: '/#section-name' },
    },
  },
});

export const WithSearch = meta.story({
  parameters: {
    tanstack: {
      // 👇 Provide the query string for the route
      router: { query: { tab: 'details', page: '2' } },
    },
  },
});
```

#### Overriding route options per story

When a route has a [`loader`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#loader-method) or [`beforeLoad`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#beforeload-method) that calls real APIs, you can override those options per story without modifying the original route object. Pass `routeOverrides` under `parameters.tanstack.router`. Each key is a route ID and the value can override [`loader`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#loader-method), [`beforeLoad`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#beforeload-method), [`validateSearch`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#validatesearch-method), [`loaderDeps`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#loaderdeps-method), and [`context`](https://tanstack.com/router/latest/docs/guide/router-context).

Use `'__root__'` as the key to target the root route.

```ts
// UserCard.stories.ts — CSF 3

const meta = {
  title: 'Users/UserCard',
  parameters: {
    tanstack: {
      router: {
        route: Route,
        params: { userId: '42' },
        // 👇 Override the route's loader so the story doesn't call the real API.
        routeOverrides: {
          '/users/$userId': {
            loader: async () => ({ user: { id: '42', name: 'Ada Lovelace' } }),
          },
        },
      },
    },
  },
} satisfies Meta<typeof Route>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
```

```ts
// UserCard.stories.ts — CSF Next 🧪

const meta = preview.meta({
  title: 'Users/UserCard',
  parameters: {
    tanstack: {
      router: {
        route: Route,
        params: { userId: '42' },
        // 👇 Override the route's loader so the story doesn't call the real API.
        routeOverrides: {
          '/users/$userId': {
            loader: async () => ({ user: { id: '42', name: 'Ada Lovelace' } }),
          },
        },
      },
    },
  },
});

export const Default = meta.story();
```

### Mocking

#### Automatic TanStack Router and TanStack Start mocks

This framework automatically redirects `@tanstack/react-router` imports to a Storybook-compatible mock layer. That mock re-exports TanStack Router APIs, keeps hooks such as [`useNavigate()`](https://tanstack.com/router/latest/docs/api/router/useNavigateHook), [`useSearch()`](https://tanstack.com/router/latest/docs/api/router/useSearchHook), and [`useParams()`](https://tanstack.com/router/latest/docs/api/router/useParamsHook) available in stories, and wires navigation attempts into Storybook spies.

For TanStack Start apps, the integration also stubs TanStack Start server and runtime entry points. This is what allows components that depend on server functions or Start-specific runtime modules to render in Storybook without a running Start server.

In practice, this means you can usually render TanStack Start components directly, and `createServerFn()` handlers are replaced with mock functions that you can observe and override in stories and tests.

#### Mocking server functions in stories

If your component imports a TanStack Start server function, Storybook turns that [`createServerFn().handler(...)`](https://tanstack.com/start/latest/docs/framework/react/guide/server-functions) result into a mock function. That means you can override it per story with standard mock APIs.

For example, imagine your application code exports a server function like this:

```ts
// src/lib/updateProfile.ts

export const updateProfile = createServerFn({ method: 'POST' }).handler(
  async ({ data }: { data: { name: string } }) => {
    return { ok: true, name: data.name };
  },
);
```

In Storybook, you can override that function for each story:

```ts
// ProfileForm.stories.ts — CSF 3

const meta = {
  component: ProfileForm,
} satisfies Meta<typeof ProfileForm>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Success: Story = {
  beforeEach: async () => {
    mocked(updateProfile).mockResolvedValue({ ok: true, name: 'Ada Lovelace' });
  },
  play: async ({ canvas, userEvent }) => {
    await userEvent.type(canvas.getByLabelText('Name'), 'Ada Lovelace');
    await userEvent.click(canvas.getByRole('button', { name: 'Save profile' }));

    await expect(updateProfile).toHaveBeenCalled();
  },
};

export const Failure: Story = {
  beforeEach: async () => {
    mocked(updateProfile).mockRejectedValue(new Error('Could not save profile'));
  },
};
```

```ts
// ProfileForm.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: ProfileForm,
});

export const Success = meta.story({
  beforeEach: async () => {
    mocked(updateProfile).mockResolvedValue({ ok: true, name: 'Ada Lovelace' });
  },
  play: async ({ canvas, userEvent }) => {
    await userEvent.type(canvas.getByLabelText('Name'), 'Ada Lovelace');
    await userEvent.click(canvas.getByRole('button', { name: 'Save profile' }));

    await expect(updateProfile).toHaveBeenCalled();
  },
});

export const Failure = meta.story({
  beforeEach: async () => {
    mocked(updateProfile).mockRejectedValue(new Error('Could not save profile'));
  },
});
```

This is useful for documenting loading, success, and error states without changing your application code.

#### Handling server-only dependencies

TanStack Start apps often import server-only packages (e.g. database clients, auth libraries) at module scope inside route files. When Storybook loads the route tree, those imports can crash the browser. The integration handles this at three layers:

##### Framework-level mocks (automatic)

The preset already intercepts `@tanstack/react-start`, `@tanstack/react-start/server`, `@tanstack/start-storage-context`, and related TanStack modules. It also replaces `createServerFn()` handlers with mock functions. You do not need to do anything for these.

##### App-level server modules

When your routes import app-specific server code (e.g. `~/db/client`, `~/auth/index.server`), use Storybook's mocking with a `__mocks__` file to prevent the real module (and its Node.js dependencies) from loading in the browser.

**Step 1**: Register the mock in `.storybook/preview.ts`:

```ts
// .storybook/preview.ts — CSF 3

// Prevents postgres (Node-only) from loading in the browser
sb.mock(import('../src/db/client.ts'));

export default {};
```

```ts
// .storybook/preview.ts — CSF Next 🧪

// Prevents postgres (Node-only) from loading in the browser
sb.mock(import('../src/db/client.ts'));

export default definePreview({});
```

**Step 2**: Create `src/db/__mocks__/client.ts` next to the real module. Use only `import type` so no server packages are pulled in:

```ts
// src/db/__mocks__/client.ts

export const db = new Proxy({} as ReturnType<typeof drizzle<typeof schema>>, {
  get: () => () => Promise.resolve([]),
});
```

**Why a `__mocks__` file instead of automocking?**

[Storybook's automocking](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-modules.md#automocking) replaces _functions_ but still **evaluates the original module** and its imports. For modules that import `postgres`, `pg`, or other Node.js-only packages, the original module must never be evaluated, because it would crash the browser. A `__mocks__` file is the only approach that completely prevents evaluation of the original module and its dependency chain.

##### Identifying what to mock

Errors like `does not provide an export named 'default'` or `AsyncLocalStorage is not defined` mean a server-only module reached the browser.

The fix is to mock the **server module itself**, not the component or route that uses it. For example, if `Dashboard.tsx` imports `~/auth/session`, and `~/auth/session` imports `~/db/client`, and `~/db/client` imports `postgres` — mock `~/db/client`.
The Node.js dependency (`postgres`) is the smoking gun; mock the closest module to it that you control.

To find that module, walk the error stack trace from top to bottom and stop at the first import you wrote yourself. Then add a [`__mocks__` file](#app-level-server-modules) for it.

Two cases where you do _not_ need a mock:

- The module is from `@tanstack/*` — already handled by the framework preset. Make sure you are on the latest `@storybook/tanstack-react`.
- The module only imports `createServerFn` — already mocked. The error is coming from another import in the same file.

### TanStack Query

You can use this framework together with [TanStack Query](https://tanstack.com/query) to provide a working QueryClient in Storybook and seed query data per story.

#### Project setup

TanStack Query is not automatically set up. The recommended approach is to create a single [`QueryClient`](https://tanstack.com/query/latest/docs/reference/QueryClient) in your preview file, clear it between stories via [`beforeEach`](https://storybook.js.org/docs/writing-tests/interaction-testing.md#beforeeach), and share the same instance through both `parameters.tanstack.router.context` and a `QueryClientProvider` decorator.

```tsx
// .storybook/preview.tsx — CSF 3

// 👇 Create a new QueryClient
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: false,
      staleTime: Infinity,
    },
  },
});

const preview: Preview = {
  beforeEach: () => {
    // 👇 Clear the cache between stories so each story starts fresh
    queryClient.clear();
  },
  parameters: {
    tanstack: {
      router: {
        // 👇 Make queryClient available in stories' beforeEach via ctx.context.queryClient
        context: { queryClient },
      },
    },
  },
  decorators: [
    (Story) => (
      // 👇 Provide the QueryClient to all stories
      
        
      
    ),
  ],
};

export default preview;
```

```tsx
// .storybook/preview.tsx — CSF Next 🧪

// 👇 Create a new QueryClient
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: false,
      staleTime: Infinity,
    },
  },
});

export default definePreview({
  beforeEach: () => {
    // 👇 Clear the cache between stories so each story starts fresh
    queryClient.clear();
  },
  parameters: {
    tanstack: {
      router: {
        // 👇 Make queryClient available in stories' beforeEach via ctx.context.queryClient
        context: { queryClient },
      },
    },
  },
  decorators: [
    (Story) => (
      // 👇 Provide the QueryClient to all stories
      
        
      
    ),
  ],
});
```

This setup keeps the router context and React provider pointed at the same `QueryClient` no matter how Storybook renders the story: in the sidebar, in the Docs page, through portable stories, or in a test run. Clearing the cache before each story gives every story fresh query state while preserving one predictable integration point for loaders, route context, decorators, and story-level setup.

You can create a separate `QueryClient` for each story when you need stronger isolation, such as rendering several stories with the same query keys on one Docs page and keeping their cached responses independent. The tradeoff is that you must make the per-story client available to both the router context and the `QueryClientProvider` for that story. If those two places receive different clients, route loaders and components can read different caches, and story setup that calls `setQueryData` may not affect the component being rendered. Per-story clients also require explicit cleanup of timers, subscriptions, and cached data owned by each client.

#### Seeding query data per story

In individual stories, use [`beforeEach`](https://storybook.js.org/docs/writing-tests/interaction-testing.md#beforeeach) to call [`setQueryData`](https://tanstack.com/query/latest/docs/reference/QueryClient#queryclientsetquerydata) on the shared `QueryClient` before the component renders. Access it from `parameters.tanstack.router.context`:

```ts
// Navbar.stories.ts — CSF 3

const meta = {
  component: Navbar,
} satisfies Meta<typeof Navbar>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};

export const LoggedIn: Story = {
  beforeEach: async ({ parameters }) => {
    const qc: QueryClient = parameters.tanstack?.router?.context?.queryClient;
    qc?.setQueryData(['currentUser'], {
      id: 'user-1',
      name: 'Ada Lovelace',
    });
  },
};
```

```ts
// Navbar.stories.ts — CSF Next 🧪

const meta = preview.meta({
  component: Navbar,
});

export const Default = meta.story();

export const LoggedIn = meta.story({
  beforeEach: async ({ parameters }) => {
    const qc: QueryClient = parameters.tanstack?.router?.context?.queryClient;
    qc?.setQueryData(['currentUser'], {
      id: 'user-1',
      name: 'Ada Lovelace',
    });
  },
});
```

## FAQ

### How do I migrate from the `react-vite` framework?

#### Automatic migration

Storybook provides a migration tool for migrating to this framework from the React (Vite) framework, [`@storybook/react-vite`](https://storybook.js.org/docs/get-started/frameworks/react-vite.md). To migrate, run this command:

```bash
npx storybook automigrate react-vite-to-tanstack-react
```

This automigration tool performs the following actions:

1. Updates `package.json` files to replace `@storybook/react-vite` with `@storybook/tanstack-react`.
2. Updates `.storybook/main.js|ts` to change the framework property (works with both regular and CSF factories `defineMain` configs).
3. Scans and updates import statements that reference `@storybook/react-vite` in your story files and Storybook configuration files (including `@storybook/react-vite/node` used by CSF factories).
4. Detects manual TanStack Router decorators in `.storybook/preview.*`, the rest of `.storybook/`, and any `*.stories.*` file. When one is found, the CLI offers to copy a ready-to-paste AI prompt to your clipboard that walks an AI assistant through removing the now-redundant decorator.

`@storybook/tanstack-react` already wraps every story in a TanStack Router automatically, so any manual `RouterProvider` / `createRouter` / `createMemoryHistory` / `createRootRoute` decorator should be removed after running the automigration. For stories that need a specific route, use [`parameters.tanstack.router`](#rendering-a-route) instead.

#### Manual migration

First, install the framework:

```shell
npm install --save-dev @storybook/tanstack-react
```

```shell
pnpm add --save-dev @storybook/tanstack-react
```

```shell
yarn add --dev @storybook/tanstack-react
```

Then, update your `.storybook/main.js|ts` to change the framework property:

```diff
// .storybook/main.ts — CSF 3
- import type { StorybookConfig } from '@storybook/react-vite';
+ import type { StorybookConfig } from '@storybook/tanstack-react';

const config: StorybookConfig = {
  // ...
-  framework: '@storybook/react-vite',
+  framework: '@storybook/tanstack-react',
};

export default config;
```

```diff
// .storybook/main.ts — CSF Next 🧪
- import { defineMain } from '@storybook/react-vite/node';
+ import { defineMain } from '@storybook/tanstack-react/node';

export default defineMain({
  // ...
-  framework: '@storybook/react-vite',
+  framework: '@storybook/tanstack-react',
});
```

Then similarly update your `.storybook/preview.*` to import from `@storybook/tanstack-react`:

```diff
// .storybook/preview.tsx — CSF 3
- import type { Preview } from '@storybook/react-vite';
+ import type { Preview } from '@storybook/tanstack-react';

const preview: Preview = {
  //...
};

export default preview;
```

```diff
// .storybook/preview.tsx — CSF Next 🧪
- import { definePreview } from '@storybook/react-vite';
+ import { definePreview } from '@storybook/tanstack-react';

export default definePreview({
  //...
});
```

`@storybook/tanstack-react` already wraps every story in a TanStack Router automatically, so any manual `RouterProvider` / `createRouter` / `createMemoryHistory` / `createRootRoute` decorator should be removed after running the automigration. For stories that need a specific route, use [`parameters.tanstack.router`](#rendering-a-route) instead.

### When should I use `@storybook/tanstack-react` instead of `@storybook/react-vite`?

Use `@storybook/tanstack-react` when your components rely on TanStack Router or TanStack Start APIs and you want Storybook to provide router context, typed route parameters, automatic router mocking, and mocked TanStack Start server-function behavior.

Use [`@storybook/react-vite`](https://storybook.js.org/docs/get-started/frameworks/react-vite.md) when your app is a standard React and Vite project without TanStack Router.

### My styles are missing in Storybook

Import your application CSS in `.storybook/preview.*` so it is bundled with the preview:

```ts title=".storybook/preview.tsx"

```

For more information, see the [styling documentation](https://storybook.js.org/docs/configure/styling-and-css.md).

### How do I provide React context providers (e.g. theme, toast, auth) to all stories?

Add [project-level decorators](https://storybook.js.org/docs/writing-stories/decorators.md#global-decorators) to apply providers to all stories.

You can also add [component-level decorators](https://storybook.js.org/docs/writing-stories/decorators.md#component-decorators) to apply providers to all stories for a specific component, or [story-level decorators](https://storybook.js.org/docs/writing-stories/decorators.md#story-decorators) to apply providers to a single story.

### Does `@storybook/tanstack-react` support React Server Components?

No. `@storybook/tanstack-react` runs stories in the browser using a memory-backed router. [React Server Components](https://react.dev/reference/rsc/server-components) require a server runtime and are not supported. If your component is a Server Component, [extract the client-side parts into a Client Component](https://react.dev/reference/rsc/server-components#adding-interactivity-to-server-components) and write stories for that instead.

### Story fails to render with an error about modules not providing a default export

This usually means a server-only module is being imported in the browser. Check the error stack trace to find the module and add a Storybook mock for it as described in [Handling server-only dependencies](#handling-server-only-dependencies).

## API

### Modules

The package exports these additional modules:

#### `@storybook/tanstack-react/react-router`

[TanStack Router](https://tanstack.com/router/latest/docs)-compatible mock implementations used by the framework to provide router behavior in stories. Import from this module when you need direct access to the mock APIs (for example, to assert against navigation spies in tests).

#### `@storybook/tanstack-react/start`

[TanStack Start](https://tanstack.com/start/latest/docs)-compatible mock implementations, including a mocked [`createServerFn()`](https://tanstack.com/start/latest/docs/framework/react/guide/server-functions) implementation. Import from this module when a story or test needs to interact directly with the Start mock layer.

### Options

You can pass an options object for additional configuration if needed:

```ts
// .storybook/main.ts — CSF 3

const config: StorybookConfig = {
  framework: {
    name: '@storybook/tanstack-react',
    options: {
      builder: {
        // Vite builder options
      },
    },
  },
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪

export default defineMain({
  framework: {
    name: '@storybook/tanstack-react',
    options: {
      builder: {
        // Vite builder options
      },
    },
  },
});
```

The available options are:

#### `builder`

Type: `Record<string, any>`

Configure options for the [framework's builder](https://storybook.js.org/docs/api/main-config/main-config-framework.md#optionsbuilder). Available options can be found in the [Vite builder docs](https://storybook.js.org/docs/builders/vite.md).

### Parameters

This framework contributes the following [parameters](https://storybook.js.org/docs/writing-stories/parameters.md) to Storybook under the `tanstack.router` namespace:

When `route` is supplied as a plain object, it may also include TanStack route options such as [`head`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#head-method), [`search`](https://tanstack.com/router/latest/docs/guide/search-params#reading-search-params), and [`params.parse`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#paramsparse-method).

#### `context`

Type: `Record<string, unknown> | (({ storyContext }) => Record<string, unknown>)`

Router context values injected into the story router. Accepts a static object, or a factory function that receives the story context. The factory runs before the router's initial load and outside React rendering, so its values are available to route [`loader`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#loader-method) and [`beforeLoad`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#beforeload-method):

```ts
parameters: {
  tanstack: {
    router: {
      context: ({ storyContext }) => ({
        queryClient: storyContext.loaded.queryClient,
      }),
    },
  },
}
```

Because the factory cannot call React hooks, use [`useRouterContext`](#useroutercontext) when the value can only be read from a React provider rendered around the story.

#### `params`

Type: `ResolveParams<Path>`

Interpolates route params into the current path. When `route` is a typed file route, the type is constrained to the param names declared in that route's path (for example, `{ id: string }` for `/$id`).

#### `path`

Type: `string`

Sets the initial URL path for the story router.

#### `query`

Type: `Record<string, unknown>`

Appends search params to the initial URL.

#### `route`

Type: `AnyRoute | route options object`

Supplies a route instance directly or creates a temporary story route from route options. Storybook extracts the route's React component automatically from the route.

#### `routeOverrides`

Type: `Partial<Record<string, RouteOverrideOptions>>`

Per-route overrides keyed by route ID, applied to the story's route and root route. Use `'__root__'` to target the root route. Each entry can override `loader`, `beforeLoad`, `validateSearch`, `loaderDeps`, and `context`.

#### `useRouterContext`

Type: `({ storyContext }) => RouterContext`

Computes the router context during rendering, as a React hook. Use this when the value can only be read from a React provider rendered around the story (for example, a `QueryClient` obtained from `useQueryClient()`):

```ts
parameters: {
  tanstack: {
    router: {
      useRouterContext: () => ({
        queryClient: useQueryClient(),
      }),
    },
  },
}
```

  Because this is a hook, it runs during rendering — after the router's initial load has already
  completed. Its values reach rendered components, but not the initial
  [`loader`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#loader-method) or
  [`beforeLoad`](https://tanstack.com/router/latest/docs/api/router/RouteOptionsType#beforeload-method).
  When a route loader reads a value from router context, supply it through the [`context`](#context)
  factory instead, which runs before the initial load.
