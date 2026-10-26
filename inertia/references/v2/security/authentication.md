# Authentication

> [!WARNING]
>
> You are viewing the documentation for Inertia.js v2. Inertia.js v3 has been released and is now the default version. Please visit the [upgrade guide](https://inertiajs.com/docs/v3/getting-started/upgrade-guide.md) to get started.

One of the benefits of using Inertia is that you don't need a special authentication system such as OAuth to connect to your data provider (API). Also, since your data is provided via your controllers, and housed on the same domain as your JavaScript components, you don't have to worry about setting up CORS.

Rather, when using Inertia, you can simply use whatever authentication system your server-side framework ships with. Typically, this will be a session based authentication system such as the authentication system included with Laravel.

> **[Laravel Starter Kits](https://laravel.com/docs/starter-kits)**
>
> Laravel's starter kits provide out-of-the-box scaffolding for new Inertia applications, including authentication.
