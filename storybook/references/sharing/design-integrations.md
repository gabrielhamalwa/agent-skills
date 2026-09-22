# Design integrations

Storybook integrates with design tools to speed up your development workflow. That helps you debug inconsistencies earlier in the design process, discover existing components to reuse, and compare designs to stories.

## Figma

[Figma](https://www.figma.com/) is a collaborative UI design tool that allows multiple people to work on the same design simultaneously in the browser. There are two ways to integrate Storybook and Figma.

- [**Embed Storybook in Figma**](#embed-storybook-in-figma-with-the-plugin)
- [**Embed Figma in Storybook**](#embed-figma-in-storybook-with-the-addon)

### Embed Storybook in Figma with the plugin

[Storybook Connect](https://www.figma.com/community/plugin/1056265616080331589/Storybook-Connect) is a Figma plugin that allows you to embed component stories in Figma. It’s powered by [Storybook embeds](https://storybook.js.org/docs/sharing/embed.md) and [Chromatic](https://www.chromatic.com/?utm_source=storybook_website&utm_medium=link&utm_campaign=storybook), a publishing tool created by the Storybook team.

#### Install plugin

Before we begin, you must have a Storybook [published to Chromatic](https://storybook.js.org/docs/sharing/publish-storybook.md#publish-storybook-with-chromatic). It provides the index, versions, and access control that back the plugin.

Go to [Storybook Connect](https://www.figma.com/community/plugin/1056265616080331589/Storybook-Connect) to install the plugin.

In Figma, open the command palette (in Mac OS, use `Command + /`, in Windows use `Control + /`) and type `Storybook Connect` to enable it.

![Figma palette Storybook connect](../_assets/sharing/figma-plugin-open-in-figma.png)

Follow the instructions to connect and authenticate with Chromatic.

#### Link stories to Figma components

Link stories to Figma components, variants, and instances.

Go to a story in a Storybook published on Chromatic. Make sure it’s on the branch you want to link. Then copy the URL to the story.

In Figma, select the component, open the plugin, and paste the URL.

![Story linked in Figma](../_assets/sharing/figma-plugin-paste-url.png)

Chromatic will automatically update your linked stories to reflect the most recent Storybook published on the branch you linked. That means the link persists even as you push new code.

The plugin does not support linking stories to Figma layers.

#### View stories in Figma

Once they're connected, you'll be able to view the story by clicking the link in the sidebar. Click "View story". Alternatively, open the plugin by using the command palette (in Mac OS, use `Command + /`, in Windows, use `Control + /`), then type `Storybook Connect`.

![Figma sidebar with story link](../_assets/sharing/figma-plugin-sidebar.png)

### Embed Figma in Storybook with the addon

[Designs addon](https://storybook.js.org/addons/@storybook/addon-designs) allows you to embed Figma files and prototypes in Storybook.

![Storybook addon figma](../_assets/sharing/storybook-figma-addon.png)

#### Install design addon

Run the following command to install the addon.

```shell
npx storybook@latest add @storybook/addon-designs
```

```shell
pnpm dlx storybook@latest add @storybook/addon-designs
```

```shell
yarn dlx storybook@latest add @storybook/addon-designs
```

The CLI's [`add`](https://storybook.js.org/docs/api/cli-options.md#add) command automates the addon's installation and setup. To install it manually, see our [documentation](https://storybook.js.org/docs/addons/install-addons.md#manual-installation) on how to install addons.

#### Link Figma components to stories

In Figma, open the file you want to embed in Storybook. You can embed files, prototypes, components, and frames.

- Embed a file or prototype, click the "Share" button to generate a unique URL for the file then click "Copy link".

- Embed a component or frame check "Link to selected frame" in the Share dialog. Or right click on the frame and go to "Copy/Paste as" » "Copy link".

In Storybook, add a new [parameter](https://storybook.js.org/docs/writing-stories/parameters.md) named `design` to your story and paste the Figma URL. For example:

```ts
// MyComponent.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

// More on default export: https://storybook.js.org/docs/writing-stories/#default-export
const meta = {
  component: MyComponent,
} satisfies Meta<typeof MyComponent>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Example: Story = {
  parameters: {
    design: {
      type: 'figma',
      url: 'https://www.figma.com/file/Sample-File',
    },
  },
};
```

```ts
// MyComponent.stories.ts|tsx — CSF Next 🧪

// More on default export: https://storybook.js.org/docs/writing-stories/#default-export
const meta = preview.meta({
  component: MyComponent,
});

export const Example = meta.story({
  parameters: {
    design: {
      type: 'figma',
      url: 'https://www.figma.com/file/Sample-File',
    },
  },
});
```

#### View designs in Storybook

Click the "Design" tab in the addon panel to view the embedded Figma design.

![Design addon panel](../_assets/sharing/design-addon-panel.png)

## Zeplin

[Zeplin](https://zeplin.io/) is a design tool that generates styleguides from [Sketch](https://www.sketch.com/), [Figma](https://www.figma.com/), and [Adobe XD](https://www.adobe.com/products/xd.html).

Use the [Zeplin addon](https://storybook.js.org/addons/storybook-zeplin) to connect Storybook. The addon displays designs from Zeplin alongside the currently selected story. It includes convenient tooling to overlay the design image atop the live component.

Zeplin's native app also supports [links to published Storybooks](https://support.zeplin.io/en/articles/5674596-connecting-your-storybook-instance-with-zeplin).

![Zeplin Storybook addon](../_assets/sharing/storybook-zeplin-addon.png)

## Zeroheight

[Zeroheight](https://zeroheight.com/) is a collaborative styleguide generator for design systems. It showcases design, code, brand, and copywriting documentation in one place. Users can edit that documentation with a WYSIWYG editor.

Zeroheight integrates with [Storybook](https://zeroheight.com/3xlwst8/p/507ba7-storybook), enabling you to embed stories alongside your design specs.

![Zeroheight Storybook integration](../_assets/sharing/storybook-zeroheight.gif)

## UXPin

[UXPin](https://www.uxpin.com/) is an interactive design tool that uses production code to generate prototypes.

UXPin allows you to [use interactive stories](https://www.uxpin.com/docs/merge/storybook-integration/) to design user flows.

## InVision Design System Manager

[InVision DSM](https://www.invisionapp.com/design-system-manager) is a design system documentation tool. It helps design teams consolidate UX principles, user interface design, and design tokens in a shared workspace.

InVision allows you to embed [Storybook](https://support.invisionapp.com/hc/en-us/articles/360028388192-Publishing-Storybook-to-DSM) in your design system documentation.

![Invision DSM Storybook integration](../_assets/sharing/storybook-invision-dsm.gif)

## Adobe XD

[Adobe XD](https://www.adobe.com/products/xd.html) is a UI and UX design tool for creating wireframes, interactive designs, and prototypes.

Integrate Adobe XD with Storybook using the [design addon](https://storybook.js.org/addons/storybook-addon-designs/). You can [embed design specs](https://helpx.adobe.com/xd/help/publish-design-specs.html) alongside stories by following these [instructions](https://pocka.github.io/storybook-addon-designs/?path=/story/docs-iframe-readme--page).

## Build your own integration

Extend and customize Storybook by building an integration. Integrate with lower-level Storybook APIs or bootstrap an addon to customize Storybook's UI and behavior.

- [Addon documentation](https://storybook.js.org/docs/addons.md)
- [Create an addon tutorial](https://storybook.js.org/docs/addons/writing-addons.md)
