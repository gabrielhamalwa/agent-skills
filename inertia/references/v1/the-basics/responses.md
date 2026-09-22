# Responses

<Warning>This is documentation for Inertia.js v1, which is no longer actively maintained. Please refer to the [v3 docs](/docs/v3/getting-started/index).</Warning>

## Creating Responses

Creating an Inertia response is simple. To get started, invoke the `Inertia::render()` method within your controller or route, providing both the name of the [JavaScript page component](/docs/v1/the-basics/pages) that you wish to render, as well as any props (data) for the page.

In the example below, we will pass a single prop (`event`) which contains four attributes (`id`, `title`, `start_date` and `description`) to the `Event/Show` page component.

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

        // Alternatively, you can use the inertia() helper...
        return inertia('Event/Show', [
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

```html theme={null}
<meta name="twitter:title" content="{{ $page['props']['event']->title }}">
```

```php theme={null}
return Inertia::render('Event', ['event' => $event])
    ->withViewData(['meta' => $event->meta]);
```

```html theme={null}
<meta name="description" content="{{ $meta }}">
```
