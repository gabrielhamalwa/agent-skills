# babelDefault

Parent: [main.js|ts configuration](https://storybook.js.org/docs/api/main-config/main-config.md)

Type: `(config: Babel.Config, options: Options) => Babel.Config | Promise<Babel.Config>`

`babelDefault` allows customization of Storybook's [Babel](https://babeljs.io/) setup. It is applied to the preview config before any user presets have been applied, which makes it useful and recommended for [addon authors](https://storybook.js.org/docs/addons/writing-presets.md#babel) so that the end user's [`babel`](https://storybook.js.org/docs/api/main-config/main-config-babel.md) setup can override it.

To adjust your Storybook's Babel setup directly—not via an addon—use [`babel`](https://storybook.js.org/docs/api/main-config/main-config-babel.md) instead.

```ts

export function babelDefault(config: TransformOptions) {
  return {
    plugins: [[import.meta.resolve('@babel/plugin-transform-react-jsx'), {}, 'preset']],
  };
}
```

## `Babel.Config`

The options provided by [Babel](https://babeljs.io/docs/options) are only applicable if you've enabled the [`@storybook/addon-webpack5-compiler-babel`](https://storybook.js.org/addons/@storybook/addon-webpack5-compiler-babel) addon.

## `Options`

Type: `{ configType?: 'DEVELOPMENT' | 'PRODUCTION' }`

There are other options that are difficult to document here. Please introspect the type definition for more information.
