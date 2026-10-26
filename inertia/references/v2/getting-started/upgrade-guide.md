# Upgrade Guide for v2.0

> [!WARNING]
>
> You are viewing the documentation for Inertia.js v2. Inertia.js v3 has been released and is now the default version. Please visit the [upgrade guide](https://inertiajs.com/docs/v3/getting-started/upgrade-guide.md) to get started.

You can find the legacy docs for Inertia.js v1.0 at [inertiajs.com/docs/v1](https://inertiajs.com/docs/v1).

## What's New

Inertia.js v2.0 is a huge step forward for Inertia! The core library has been completely rewritten to architecturally support asynchronous requests, enabling a whole set of new features, including:

> **[Polling](https://inertiajs.com/docs/v2/data-props/polling.md)**
>
> Keep data fresh by automatically polling the server at a specified interval.

> **[Prefetching](https://inertiajs.com/docs/v2/data-props/prefetching.md)**
>
> Speed up navigation by prefetching data for links when they become visible.

> **[Deferred props](https://inertiajs.com/docs/v2/data-props/deferred-props.md)**
>
> Load non-essential data after the initial page load to improve performance.

> **[Infinite scrolling](https://inertiajs.com/docs/v2/data-props/merging-props.md)**
>
> Seamlessly load more data as the user scrolls down the page.

> **[Lazy loading data on scroll](https://inertiajs.com/docs/v2/data-props/load-when-visible.md)**
>
> Load data only when it becomes visible in the viewport.

> **[History encryption](https://inertiajs.com/docs/v2/security/history-encryption.md)**
>
> Clear page data from browser history state when logging out of an application.

## Upgrade Dependencies

To upgrade to the Inertia.js v2.0, first use npm to install the client-side adapter of your choice:

```bash Vue icon="vuejs" theme={null}
npm install @inertiajs/vue3@^2.0
```

```bash React icon="react" theme={null}
npm install @inertiajs/react@^2.0
```

```bash Svelte icon="s" theme={null}
npm install @inertiajs/svelte@^2.0
```

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

The previously deprecated `router.replace` method has been re-instated, but its functionality has changed. It is now used to make [Client Side](https://inertiajs.com/docs/v2/the-basics/manual-visits.md#client-side-visits) page visits. To make server-side visits that replace the current history entry in the browser, use the `replace` option:

```javascript theme={null}
router.get('/users', { search: 'John' }, { replace: true })
```

### Svelte Adapter

* Dropped support for Svelte 3 as it reached End of Life on June 20, 2023.
* The `remember` helper has been rename to `useRemember` to be consistent with other helpers.
* Updated `setup` callback in `app.js`. You need to pass `props` when initializing the `App` component. [See setup in app.js](https://inertiajs.com/docs/v2/installation/client-side-setup.md#initialize-the-inertia-app)
* `setup` callback is now required in `ssr.js`. [See setup in ssr.js](https://inertiajs.com/docs/v2/advanced/server-side-rendering.md#add-server-entry-point)

### Partial Reloads Are Now Async

Previously partial reloads in Inertia were synchronous, just like all Inertia requests. In v2.0, partial reloads are now asynchronous. Generally this is desirable, but if you were relying on these requests being synchronous, you may need to adjust your code.
