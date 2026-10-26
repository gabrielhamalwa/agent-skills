# Server-side Setup

> [!WARNING]
>
> This is documentation for Inertia.js v1, which is no longer actively maintained. Please refer to the [v3 docs](https://inertiajs.com/docs/v3/getting-started/index.md).

The first step when installing Inertia is to configure your server-side framework. Inertia maintains an official server-side adapter for [Laravel](https://laravel.com/). For other frameworks, please see the [community adapters](https://inertiajs.com/docs/community-adapters).

Inertia is fine-tuned for Laravel, so the documentation examples on this website utilize Laravel. For examples of using Inertia with other server-side frameworks, please refer to the framework specific documentation maintained by that adapter.

## Laravel Starter Kits

Laravel's [starter kits](https://laravel.com/docs/starter-kits), Breeze and Jetstream, provide out-of-the-box scaffolding for new Inertia applications. These starter kits are the absolute fastest way to start building a new Inertia project using Laravel and Vue or React. However, if you would like to manually install Inertia into your application, please consult the documentation below.

## Install Dependencies

First, install the Inertia server-side adapter using the Composer package manager.

```bash theme={null}
composer require inertiajs/inertia-laravel
```

## Root Template

Next, setup the root template that will be loaded on the first page visit to your application. This will be used to load your site assets (CSS and JavaScript), and will also contain a root `<div>` in which to boot your JavaScript application.

```blade theme={null}
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
        @vite('resources/js/app.js')
        @inertiaHead
    </head>
    <body>
        @inertia
    </body>
</html>
```

This template should include your assets, as well as the `@inertia` and `@inertiaHead`directives.

By default, Inertia's Laravel adapter will assume your root template is named `app.blade.php`. If you would like to use a different root view, you can change it using the `Inertia::setRootView()` method.

## Middleware

Next we need to setup the Inertia middleware. You can accomplish this by publishing the `HandleInertiaRequests` middleware to your application, which can be done using the following Artisan command.

```sh theme={null}
php artisan inertia:middleware
```

Once the middleware has been published, append the `HandleInertiaRequests` middleware to the `web` middleware group in your application's `bootstrap/app.php` file.

```php theme={null}
use App\Http\Middleware\HandleInertiaRequests;

->withMiddleware(function (Middleware $middleware) {
    $middleware->web(append: [
        HandleInertiaRequests::class,
    ]);
})
```

This middleware provides a `version()` method for setting your [asset version](https://inertiajs.com/docs/v1/advanced/asset-versioning.md), as well as a `share()` method for defining [shared data](https://inertiajs.com/docs/v1/the-basics/shared-data.md).

## Creating Responses

That's it, you're all ready to go server-side! Now you're ready to start creating Inertia [pages](https://inertiajs.com/docs/v1/the-basics/pages.md) and rendering them via [responses](https://inertiajs.com/docs/v1/the-basics/responses.md).

```php theme={null}
use Inertia\Inertia;

class EventsController extends Controller
{
    public function show(Event $event)
    {
        return Inertia::render('Event/Show', [
            'event' => $event->only(
                'id',
                'title',
                'start_date',
                'description'
            ),
        ]);
    }
}
```
