# Upgrade Guide for v2.0

<Warning>You are viewing the documentation for Inertia.js v2. Inertia.js v3 has been released and is now the default version. Please visit the [upgrade guide](/docs/v3/getting-started/upgrade-guide) to get started.</Warning>

You can find the legacy docs for Inertia.js v1.0 at [inertiajs.com/docs/v1](/docs/v1).

## What's New

Inertia.js v2.0 is a huge step forward for Inertia! The core library has been completely rewritten to architecturally support asynchronous requests, enabling a whole set of new features, including:

<Columns cols={2}>
  <Card title="Polling" href="/docs/v2/data-props/polling" icon="clock">
    Keep data fresh by automatically polling the server at a specified interval.
  </Card>

  <Card title="Prefetching" href="/docs/v2/data-props/prefetching" icon="rocket">
    Speed up navigation by prefetching data for links when they become visible.
  </Card>

  <Card title="Deferred props" href="/docs/v2/data-props/deferred-props" icon="timer">
    Load non-essential data after the initial page load to improve performance.
  </Card>

  <Card title="Infinite scrolling" href="/docs/v2/data-props/merging-props" icon="refresh">
    Seamlessly load more data as the user scrolls down the page.
  </Card>

  <Card title="Lazy loading data on scroll" href="/docs/v2/data-props/load-when-visible" icon="mouse">
    Load data only when it becomes visible in the viewport.
  </Card>

  <Card title="History encryption" href="/docs/v2/security/history-encryption" icon="lock">
    Clear page data from browser history state when logging out of an application.
  </Card>
</Columns>

## Upgrade Dependencies

To upgrade to the Inertia.js v2.0, first use npm to install the client-side adapter of your choice:

<CodeGroup>
  ```bash Vue icon="vuejs" theme={null}
  npm install @inertiajs/vue3@^2.0
  ```

  ```bash React icon="react" theme={null}
  npm install @inertiajs/react@^2.0
  ```

  ```bash Svelte icon="s" theme={null}
  npm install @inertiajs/svelte@^2.0
  ```
</CodeGroup>

Next, upgrade the `inertiajs/inertia-laravel` package to use the `2.x` dev branch:

```bash theme={null}
composer require inertiajs/inertia-laravel:^2.0
```

## Breaking Changes

While a significant release, Inertia.js v2.0 doesn't introduce many breaking changes. Here's a list of all the breaking changes:

### Dropped Laravel 8 and 9 Support

The Laravel adapter now requires Laravel 10 and PHP 8.1 at a minimum.

### Dropped Vue 2 Support

The Vue 2 adapter has been removed. Vue 2 reached End of Life on December 3, 2023, so this felt like it was time.

### Router `replace` Method

The previously deprecated `router.replace` method has been re-instated, but its functionality has changed. It is now used to make [Client Side](/docs/v2/the-basics/manual-visits#client-side-visits) page visits. To make server-side visits that replace the current history entry in the browser, use the `replace` option:

```javascript theme={null}
router.get('/users', { search: 'John' }, { replace: true })
```

### Svelte Adapter

* Dropped support for Svelte 3 as it reached End of Life on June 20, 2023.
* The `remember` helper has been rename to `useRemember` to be consistent with other helpers.
* Updated `setup` callback in `app.js`. You need to pass `props` when initializing the `App` component. [See setup in app.js](/docs/v2/installation/client-side-setup#initialize-the-inertia-app)
* `setup` callback is now required in `ssr.js`. [See setup in ssr.js](/docs/v2/advanced/server-side-rendering#add-server-entry-point)

### Partial Reloads Are Now Async

Previously partial reloads in Inertia were synchronous, just like all Inertia requests. In v2.0, partial reloads are now asynchronous. Generally this is desirable, but if you were relying on these requests being synchronous, you may need to adjust your code.
