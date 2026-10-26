# Pages

> [!WARNING]
>
> This is documentation for Inertia.js v1, which is no longer actively maintained. Please refer to the [v3 docs](https://inertiajs.com/docs/v3/getting-started/index.md).

When building applications using Inertia, each page in your application typically has its own controller / route and a corresponding JavaScript component. This allows you to retrieve just the data necessary for that page - no API required.

In addition, all of the data needed for the page can be retrieved before the page is ever rendered by the browser, eliminating the need for displaying "loading" states when users visit your application.

## Creating Pages

Inertia pages are simply JavaScript components. If you have ever written a Vue, React, or Svelte component, you will feel right at home. As you can see in the example below, pages receive data from your application's controllers as props.

```vue Vue 2 icon="vuejs" theme={null}
<template>
    <Layout>
        <Head title="Welcome" />
        <h1>Welcome</h1>
        <p>Hello {{ user.name }}, welcome to your first Inertia app!</p>
    </Layout>
</template>

<script>
import Layout from './Layout'
import { Head } from '@inertiajs/vue2'

export default {
    components: {
        Head,
        Layout,
    },
    props: {
        user: Object,
    },
}
</script>
```

```vue Vue 3 icon="vuejs" theme={null}
<script setup>
import Layout from './Layout'
import { Head } from '@inertiajs/vue3'

defineProps({ user: Object })
</script>

<template>
    <Layout>
        <Head title="Welcome" />
        <h1>Welcome</h1>
        <p>Hello {{ user.name }}, welcome to your first Inertia app!</p>
    </Layout>
</template>
```

```jsx React icon="react" theme={null}
import Layout from './Layout'
import { Head } from '@inertiajs/react'

export default function Welcome({ user }) {
    return (
        <Layout>
            <Head title="Welcome" />
            <h1>Welcome</h1>
            <p>Hello {user.name}, welcome to your first Inertia app!</p>
        </Layout>
    )
}
```

```html Svelte icon="s" theme={null}
<script>
    import Layout from './Layout.svelte'

    export let user
</script>

<Layout>
    <svelte:head>
        <title>Welcome</title>
    </svelte:head>
    <H1>Welcome</H1>
    <p>Hello {user.name}, welcome to your first Inertia app!</p>
</Layout>
```

Given the page above, you can render the page by returning an [Inertia response](https://inertiajs.com/docs/v1/the-basics/responses.md) from a controller or route. In this example, let's assume this page is stored at `resources/js/Pages/User/Show.vue``resources/js/Pages/User/Show.jsx``resources/js/Pages/User/Show.svelte`within a Laravel application.

```php theme={null}
use Inertia\Inertia;

class UserController extends Controller
{
    public function show(User $user)
    {
        return Inertia::render('User/Show', [
            'user' => $user
        ]);
    }
}
```

## Creating Layouts

While not required, for most projects it makes sense to create a site layout that all of your pages can extend. You may have noticed in our page example above that we're wrapping the page content within a `<Layout>` component. Here's an example of such a component:

```vue Vue 2 icon="vuejs" theme={null}
<template>
    <main>
        <header>
            <a href="/">Home</a>
            <a href="/about">About</a>
            <a href="/contact">Contact</a>
        </header>
        <article>
            <slot />
        </article>
    </main>
</template>

<script>
import { Link } from '@inertiajs/vue2'

export default {
    components: {
        Link,
    }
}
</script>
```

```vue Vue 3 icon="vuejs" theme={null}
<script setup>
import { Link } from '@inertiajs/vue3'
</script>

<template>
    <main>
        <header>
            <a href="/">Home</a>
            <a href="/about">About</a>
            <a href="/contact">Contact</a>
        </header>
        <article>
            <slot />
        </article>
    </main>
</template>
```

```jsx React icon="react" theme={null}
import { Link } from '@inertiajs/react'

export default function Layout({ children }) {
    return (
        <main>
            <header>
                <a href="/">Home</a>
                <a href="/about">About</a>
                <a href="/contact">Contact</a>
            </header>
            <article>{children}</article>
        </main>
    )
}
```

```html Svelte icon="s" theme={null}
<script>
    import { inertia } from '@inertiajs/svelte'
</script>

<main>
    <header>
        <a use:inertia href="/">Home</a>
        <a use:inertia href="/about">About</a>
        <a use:inertia href="/contact">Contact</a>
    </header>
    <article>
        <slot />
    </article>
</main>
```

As you can see, there is nothing Inertia specific within this template. This is just a typical VueReactSvelte component.

## Persistent Layouts

While it's simple to implement layouts as children of page components, it forces the layout instance to be destroyed and recreated between visits. This means you cannot have persistent layout state when navigating between pages.

For example, maybe you have an audio player on a podcast website that you want to continue playing as users navigate the site. Or, maybe you simply want to maintain the scroll position in your sidebar navigation between page visits. In these situations, the solution is to leverage Inertia's persistent layouts.

```vue Vue 2 icon="vuejs" theme={null}
<template>
    <div>
        <H1>Welcome</H1>
        <p>Hello {{ user.name }}, welcome to your first Inertia app!</p>
    </div>
</template>

<script>
import Layout from './Layout'

export default {
    // Using a render function...
    layout: (h, page) => h(Layout, [page]),

    // Using shorthand syntax...
    layout: Layout,

    props: {
        user: Object,
    },
}
</script>
```

```vue Vue 3 icon="vuejs" theme={null}
<script>
import Layout from './Layout'

export default {
    // Using a render function...
    layout: (h, page) => h(Layout, [page]),

    // Using shorthand syntax...
    layout: Layout,
}
</script>

<script setup>
defineProps({ user: Object })
</script>

<template>
    <H1>Welcome</H1>
    <p>Hello {{ user.name }}, welcome to your first Inertia app!</p>
</template>
```

```jsx React icon="react" theme={null}
import Layout from './Layout'

const Home = ({ user }) => {
    return (

            <H1>Welcome</H1>
            <p>Hello {user.name}, welcome to your first Inertia app!</p>

    )
}

Home.layout = page => <Layout children={page} title="Welcome" />

export default Home
```

```html Svelte icon="s" theme={null}
<script context="module">
    export { default as layout } from './Layout.svelte'
</script>

<script>
    export let user
</script>

<H1>Welcome</H1>
<p>Hello {user.name}, welcome to your first Inertia app!</p>
```

You can also create more complex layout arrangements using nested layouts.

```vue Vue 2 icon="vuejs" theme={null}
<template>
    <div>
        <H1>Welcome</H1>
        <p>Hello {{ user.name }}, welcome to your first Inertia app!</p>
    </div>
</template>

<script>
import SiteLayout from './SiteLayout'
import NestedLayout from './NestedLayout'

export default {
    // Using a render function...
    layout: (h, page) => {
        return h(SiteLayout, [
            h(NestedLayout, [page]),
        ])
    },

    // Using shorthand syntax...
    layout: [SiteLayout, NestedLayout],

    props: {
        user: Object,
    },
}
</script>
```

```vue Vue 3 icon="vuejs" theme={null}
<script>
import SiteLayout from './SiteLayout'
import NestedLayout from './NestedLayout'

export default {
    // Using a render function...
    layout: (h, page) => {
        return h(SiteLayout, () => h(NestedLayout, () => page))
    },

    // Using the shorthand...
    layout: [SiteLayout, NestedLayout],
}
</script>

<script setup>
defineProps({ user: Object })
</script>

<template>
    <H1>Welcome</H1>
    <p>Hello {{ user.name }}, welcome to your first Inertia app!</p>
</template>
```

```jsx React icon="react" theme={null}
import SiteLayout from './SiteLayout'
import NestedLayout from './NestedLayout'

const Home = ({ user }) => {
    return (

            <H1>Welcome</H1>
            <p>Hello {user.name}, welcome to your first Inertia app!</p>

    )
}

Home.layout = page => (
    <SiteLayout title="Welcome">
        <NestedLayout children={page} />
    </SiteLayout>
)

export default Home
```

```html Svelte icon="s" theme={null}
<script context="module">
    import SiteLayout from './SiteLayout.svelte'
    import NestedLayout from './NestedLayout.svelte'
    export const layout = [SiteLayout, NestedLayout]
</script>

<script>
    export let user
</script>

<H1>Welcome</H1>
<p>Hello {user.name}, welcome to your first Inertia app!</p>
```

If you're using Vue 2.7 or Vue 3, you can alternatively use the [defineOptions plugin](https://vue-macros.sxzz.moe/macros/define-options.html) to define a layout within `<script setup>`:

```html theme={null}
<script setup>
import Layout from './Layout'
defineOptions({ layout: Layout })
</script>
```

## Default layouts

If you're using persistent layouts, you may find it convenient to define the default page layout in the `resolve()` callback of your application's main JavaScript file.

```js Vue 2 icon="vuejs" theme={null}
import Layout from './Layout'

createInertiaApp({
    resolve: name => {
        const pages = import.meta.glob('./Pages/**/*.vue', { eager: true })
        let page = pages[`./Pages/${name}.vue`]
        page.default.layout = page.default.layout || Layout
        return page
    },
    // ...
})
```

```js Vue 3 icon="vuejs" theme={null}
import Layout from './Layout'

createInertiaApp({
    resolve: name => {
        const pages = import.meta.glob('./Pages/**/*.vue', { eager: true })
        let page = pages[`./Pages/${name}.vue`]
        page.default.layout = page.default.layout || Layout
        return page
    },
    // ...
})
```

```js React icon="react" theme={null}
import Layout from './Layout'

createInertiaApp({
    resolve: name => {
        const pages = import.meta.glob('./Pages/**/*.jsx', { eager: true })
        let page = pages[`./Pages/${name}.jsx`]
        page.default.layout = page.default.layout || (page => <Layout children={page} />)
        return page
    },
    // ...
})
```

```js Svelte icon="s" theme={null}
import Layout from './Layout'

createInertiaApp({
    resolve: name => {
        const pages = import.meta.glob('./Pages/**/*.svelte', { eager: true })
        let page = pages[`./Pages/${name}.svelte`]
        return { default: page.default, layout: page.layout || Layout }
    },
    // ...
})
```

This will automatically set the page layout to `Layout` if a layout has not already been set for that page.

You can even go a step further and conditionally set the default page layout based on the page `name`, which is available to the `resolve()` callback. For example, maybe you don't want the default layout to be applied to your public pages.

```js Vue 2 icon="vuejs" theme={null}
import Layout from './Layout'

createInertiaApp({
    resolve: name => {
        const pages = import.meta.glob('./Pages/**/*.vue', { eager: true })
        let page = pages[`./Pages/${name}.vue`]
        page.default.layout = name.startsWith('Public/') ? undefined : Layout
        return page
    },
    // ...
})
```

```js Vue 3 icon="vuejs" theme={null}
import Layout from './Layout'

createInertiaApp({
    resolve: name => {
        const pages = import.meta.glob('./Pages/**/*.vue', { eager: true })
        let page = pages[`./Pages/${name}.vue`]
        page.default.layout = name.startsWith('Public/') ? undefined : Layout
        return page
    },
    // ...
})
```

```js React icon="react" theme={null}
import Layout from './Layout'

createInertiaApp({
    resolve: name => {
        const pages = import.meta.glob('./Pages/**/*.jsx', { eager: true })
        let page = pages[`./Pages/${name}.jsx`]
        page.default.layout = name.startsWith('Public/') ? undefined : page => <Layout children={page} />
        return page
    },
    // ...
})
```

```js Svelte icon="s" theme={null}
import Layout from './Layout'

createInertiaApp({
    resolve: name => {
        const pages = import.meta.glob('./Pages/**/*.svelte', { eager: true })
        let page = pages[`./Pages/${name}.svelte`]
        return { default: page.default, layout: name.startsWith('Public/') ? undefined : Layout }
        return page
    },
    // ...
})
```
