# Feature support for frameworks

Storybook integrates with many popular frontend frameworks. We do our best to keep feature parity amongst frameworks, but it’s tricky for our modest team to support every framework.

Below is a comprehensive table of what’s supported in which framework integration. If you’d like a certain feature supported in your framework, we welcome pull requests.

## Core frameworks

Core frameworks have dedicated maintainers or contributors who are responsible for maintaining the integration. As such, you can use most Storybook features in these frameworks.

|                                                                                         | React | Vue 3 | Angular | Web Components |
| --------------------------------------------------------------------------------------- | ----- | ----- | ------- | -------------- |
| **Essentials**                                                                          |       |       |         |                |
| [Actions](https://storybook.js.org/docs/essentials/actions.md)                                                 | ✅    | ✅    | ✅      | ✅             |
| [Backgrounds](https://storybook.js.org/docs/essentials/backgrounds.md)                                         | ✅    | ✅    | ✅      | ✅             |
| [Controls](https://storybook.js.org/docs/essentials/controls.md)                                               | ✅    | ✅    | ✅      | ✅             |
| [Interactions](https://storybook.js.org/docs/writing-tests/interaction-testing.md#debugging-interaction-tests) | ✅    | ✅    | ✅      | ✅             |
| [Measure](https://storybook.js.org/docs/essentials/measure-and-outline.md#measure)                             | ✅    | ✅    | ✅      | ✅             |
| [Outline](https://storybook.js.org/docs/essentials/measure-and-outline.md#outline)                             | ✅    | ✅    | ✅      | ✅             |
| [Viewport](https://storybook.js.org/docs/essentials/viewport.md)                                               | ✅    | ✅    | ✅      | ✅             |
| **Addons**                                                                              |       |       |         |                |
| [A11y](https://storybook.js.org/docs/writing-tests/accessibility-testing.md)                                   | ✅    | ✅    | ✅      | ✅             |
| [Docs](https://storybook.js.org/docs/writing-docs.md)                                                    | ✅    | ✅    | ✅      | ✅             |
| [Test runner](https://storybook.js.org/docs/writing-tests/integrations/test-runner.md)                         | ✅    | ✅    | ✅      | ✅             |
| [Test coverage](https://storybook.js.org/docs/writing-tests/test-coverage.md)                                  | ✅    | ✅    | ✅      | ✅             |
| [CSS resources](https://github.com/storybookjs/addon-cssresources)                      | ✅    | ✅    | ✅      | ✅             |
| [Design assets](https://github.com/storybookjs/addon-design-assets)                     | ✅    | ✅    | ✅      | ✅             |
| [Events](https://github.com/storybookjs/addon-events)                                   | ✅    | ✅    | ✅      | ✅             |
| [Google analytics](https://github.com/storybookjs/addon-google-analytics)               | ✅    | ✅    | ✅      | ✅             |
| [GraphQL](https://github.com/storybookjs/addon-graphql)                                 | ✅    |       | ✅      |                |
| [Jest](https://github.com/storybookjs/addon-jest)                                       | ✅    | ✅    | ✅      | ✅             |
| [Links](https://github.com/storybookjs/storybook/tree/next/code/addons/links)           | ✅    | ✅    | ✅      | ✅             |
| [Queryparams](https://github.com/storybookjs/addon-queryparams)                         | ✅    | ✅    | ✅      | ✅             |
| **Docs**                                                                                |       |       |         |                |
| [CSF Stories](https://storybook.js.org/docs/api/csf.md)                                                  | ✅    | ✅    | ✅      | ✅             |
| [Autodocs](https://storybook.js.org/docs/writing-docs/autodocs.md)                                             | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - ArgTypes](https://storybook.js.org/docs/api/doc-blocks/doc-block-argtypes.md)                    | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Canvas](https://storybook.js.org/docs/api/doc-blocks/doc-block-canvas.md)                        | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - ColorPalette](https://storybook.js.org/docs/api/doc-blocks/doc-block-colorpalette.md)            | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Controls](https://storybook.js.org/docs/api/doc-blocks/doc-block-controls.md)                    | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Description](https://storybook.js.org/docs/api/doc-blocks/doc-block-description.md)              | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - IconGallery](https://storybook.js.org/docs/api/doc-blocks/doc-block-icongallery.md)              | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Markdown](https://storybook.js.org/docs/api/doc-blocks/doc-block-markdown.md)                    | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Meta](https://storybook.js.org/docs/api/doc-blocks/doc-block-meta.md)                            | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Primary](https://storybook.js.org/docs/api/doc-blocks/doc-block-primary.md)                      | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Source](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md)                        | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Story](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md)                          | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Stories](https://storybook.js.org/docs/api/doc-blocks/doc-block-stories.md)                      | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Subtitle](https://storybook.js.org/docs/api/doc-blocks/doc-block-subtitle.md)                    | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Title](https://storybook.js.org/docs/api/doc-blocks/doc-block-title.md)                          | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Typeset](https://storybook.js.org/docs/api/doc-blocks/doc-block-typeset.md)                      | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - Unstyled](https://storybook.js.org/docs/api/doc-blocks/doc-block-unstyled.md)                    | ✅    | ✅    | ✅      | ✅             |
| [Doc Blocks - UseOf](https://storybook.js.org/docs/api/doc-blocks/doc-block-useof.md)                          | ✅    | ✅    | ✅      | ✅             |
| Inline stories                                                                          | ✅    | ✅    | ✅      | ✅             |

## Community frameworks

Community frameworks have fewer contributors which means they may not be as up to date as core frameworks. If you use one of these frameworks for your job, please consider contributing to its integration with Storybook.

|                                                                                         | Ember | HTML | Svelte | Preact | Qwik | SolidJS |
| --------------------------------------------------------------------------------------- | ----- | ---- | ------ | ------ | ---- | ------- |
| **Essentials**                                                                          |       |      |        |        |      |         |
| [Actions](https://storybook.js.org/docs/essentials/actions.md)                                                 | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Backgrounds](https://storybook.js.org/docs/essentials/backgrounds.md)                                         | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Controls](https://storybook.js.org/docs/essentials/controls.md)                                               | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Interactions](https://storybook.js.org/docs/writing-tests/interaction-testing.md#debugging-interaction-tests) |       | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Measure](https://storybook.js.org/docs/essentials/measure-and-outline.md#measure)                             | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Outline](https://storybook.js.org/docs/essentials/measure-and-outline.md#outline)                             | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Viewport](https://storybook.js.org/docs/essentials/viewport.md)                                               | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| **Addons**                                                                              |       |      |        |        |      |         |
| [A11y](https://storybook.js.org/docs/writing-tests/accessibility-testing.md)                                   | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Docs](https://storybook.js.org/docs/writing-docs.md)                                                    | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Test runner](https://storybook.js.org/docs/writing-tests/integrations/test-runner.md)                         |       | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Test coverage](https://storybook.js.org/docs/writing-tests/test-coverage.md)                                  |       | ✅   | ✅     | ✅     | ✅   | ✅      |
| [CSS resources](https://github.com/storybookjs/addon-cssresources)                      | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Design assets](https://github.com/storybookjs/addon-design-assets)                     | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Events](https://github.com/storybookjs/addon-events)                                   | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Google analytics](https://github.com/storybookjs/addon-google-analytics)               | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [GraphQL](https://github.com/storybookjs/addon-graphql)                                 |       |      |        |        |      |         |
| [Jest](https://github.com/storybookjs/addon-jest)                                       | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Links](https://github.com/storybookjs/storybook/tree/next/code/addons/links)           | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Queryparams](https://github.com/storybookjs/addon-queryparams)                         | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| **Docs**                                                                                |       |      |        |        |      |         |
| [CSF Stories](https://storybook.js.org/docs/api/csf.md)                                                  | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Autodocs](https://storybook.js.org/docs/writing-docs/autodocs.md)                                             |       | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - ArgTypes](https://storybook.js.org/docs/api/doc-blocks/doc-block-argtypes.md)                    | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Canvas](https://storybook.js.org/docs/api/doc-blocks/doc-block-canvas.md)                        | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - ColorPalette](https://storybook.js.org/docs/api/doc-blocks/doc-block-colorpalette.md)            | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Controls](https://storybook.js.org/docs/api/doc-blocks/doc-block-controls.md)                    | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Description](https://storybook.js.org/docs/api/doc-blocks/doc-block-description.md)              | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - IconGallery](https://storybook.js.org/docs/api/doc-blocks/doc-block-icongallery.md)              | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Markdown](https://storybook.js.org/docs/api/doc-blocks/doc-block-markdown.md)                    | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Meta](https://storybook.js.org/docs/api/doc-blocks/doc-block-meta.md)                            | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Primary](https://storybook.js.org/docs/api/doc-blocks/doc-block-primary.md)                      | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Source](https://storybook.js.org/docs/api/doc-blocks/doc-block-source.md)                        | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Story](https://storybook.js.org/docs/api/doc-blocks/doc-block-story.md)                          | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Stories](https://storybook.js.org/docs/api/doc-blocks/doc-block-stories.md)                      | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Subtitle](https://storybook.js.org/docs/api/doc-blocks/doc-block-subtitle.md)                    | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Title](https://storybook.js.org/docs/api/doc-blocks/doc-block-title.md)                          | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Typeset](https://storybook.js.org/docs/api/doc-blocks/doc-block-typeset.md)                      | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - Unstyled](https://storybook.js.org/docs/api/doc-blocks/doc-block-unstyled.md)                    | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| [Doc Blocks - UseOf](https://storybook.js.org/docs/api/doc-blocks/doc-block-useof.md)                          | ✅    | ✅   | ✅     | ✅     | ✅   | ✅      |
| Inline stories                                                                          |       | ✅   | ✅     |        |      |         |

## Deprecated

To align the Storybook ecosystem with the current state of frontend development, the following features and addons are now deprecated, no longer maintained, and will be removed in future versions of Storybook

| Feature                                             | Status                                                                                                                                                                                                                                                                                                                            |
| --------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Knobs](https://github.com/storybookjs/addon-knobs) | The Knobs addon was officially deprecated with the release of Storybook 6.3 and is no longer actively maintained. We recommend using the [controls](https://storybook.js.org/docs/essentials/controls.md) instead.                                                                                                                                       |
| Storyshots                                          | The Storyshots addon was officially deprecated with the release of Storybook 7.6, is no longer actively maintained and was removed in Storybook 8. See the [migration guide](https://storybook.js.org/docs/8/writing-tests/snapshot-testing/storyshots-migration-guide.md) for the available alternatives.                             |
| StoriesOf                                           | The `storiesOf` API was officially removed with the release of Storybook 8 and is no longer maintained. We recommend using the [CSF API](https://storybook.js.org/docs/api/csf.md) instead for writing stories.<br />See the [migration guide](https://storybook.js.org/docs/releases/migration-guide-from-older-version.md#major-breaking-changes) for more information. |
| Storysource                                         | The Storysource addon was officially removed with the release of Storybook 9 and is no longer maintained. To display your stories' source code, we recommend using the [`codePanel`](https://storybook.js.org/docs/writing-docs/code-panel.md) parameter instead.                                                                                        |
