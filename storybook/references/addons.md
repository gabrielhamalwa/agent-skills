# Introduction to addons

Addons extend Storybook with features and integrations that are not built into the core. Most Storybook features are implemented as addons. For instance: [documentation](https://storybook.js.org/docs/writing-docs.md), [accessibility testing](https://storybook.js.org/docs/writing-tests/accessibility-testing.md), [interactive controls](https://storybook.js.org/docs/essentials/controls.md), among others.
The [addon API](https://storybook.js.org/docs/addons/addons-api.md) makes it easy for you to configure and customize Storybook in new ways. There are countless addons made by the community that unlocks time-saving workflows.

Browse our [addon catalog](https://storybook.js.org/addons) to install an existing addon or as inspiration for your own addon.

## Storybook basics

Before writing your first [addon](https://storybook.js.org/addons), let’s take a look at the basics of Storybook’s architecture. While Storybook presents a unified user interface, under the hood it’s divided down the middle into **Manager** and **Preview**.

The **Manager** is the UI responsible for rendering the:

- 🔍 Search
- 🧭 Navigation
- 🔗 Toolbars
- 📦 Addons

The **Preview** area is an `iframe` where your stories are rendered.

![Storybook detailed window](../_assets/addons/manager-preview.png)

Because both elements run in their own separate `iframes`, they use a communication channel to keep in sync. For example, when you select a story in the Manager an event is dispatched across the channel notifying the Preview to render the story.

## Anatomy of an addon

Storybook addons allow you to extend what's already possible with Storybook, everything from the [user interface](https://storybook.js.org/docs/addons/addon-types.md) to the [API](https://storybook.js.org/docs/addons/addons-api.md). Each one is classified into two broader categories.

### UI-based addons

[UI-based addons](https://storybook.js.org/docs/addons/addon-types.md#ui-based-addons) focus on customizing Storybook's user interface to extend your development workflow. Examples of UI-based addons include: [Controls](https://storybook.js.org/docs/essentials/controls.md), [Docs](https://storybook.js.org/docs/writing-docs.md) and [Accessibility](https://storybook.js.org/docs/writing-tests/accessibility-testing.md).

[Learn how to write an addon »](https://storybook.js.org/docs/addons/writing-addons.md)

### Preset addons

[Preset addons](https://storybook.js.org/docs/addons/addon-types.md#preset-addons) help you integrate Storybook with other technologies and libraries. An examples of a preset addons is [preset-create-react-app](https://github.com/storybookjs/presets/tree/master/packages/preset-create-react-app).

[Learn how to write a preset addon »](https://storybook.js.org/docs/addons/writing-presets.md)
