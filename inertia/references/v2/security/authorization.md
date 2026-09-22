# Authorization

<Warning>You are viewing the documentation for Inertia.js v2. Inertia.js v3 has been released and is now the default version. Please visit the [upgrade guide](/docs/v3/getting-started/upgrade-guide) to get started.</Warning>

When using Inertia, authorization is best handled server-side in your application's authorization policies. However, you may be wondering how to perform checks against your authorization policies from within your Inertia page components since you won't have access to your framework's server-side helpers.

The simplest approach to solving this problem is to pass the results of your authorization checks as props to your page components.

```php theme={null}
class UsersController extends Controller
{
    public function index()
    {
        return Inertia::render('Users/Index', [
            'can' => [
                'create_user' => Auth::user()->can('create', User::class),
            ],
            'users' => User::all()->map(function ($user) {
                return [
                    'first_name' => $user->first_name,
                    'last_name' => $user->last_name,
                    'email' => $user->email,
                    'can' => [
                        'edit_user' => Auth::user()->can('edit', $user),
                    ]
                ];
            }),
        ]);
    }
}
```
