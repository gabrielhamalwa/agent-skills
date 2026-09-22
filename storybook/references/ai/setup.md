# Agentic setup

Storybook's agentic setup is currently only available for projects using the [React](https://storybook.js.org/docs/ai/?renderer=react.md) renderer with the [Vite](https://storybook.js.org/docs/builders/vite.md) builder. Support for additional renderers and builders will follow.

The API may change in future releases. We welcome feedback and contributions to help improve this feature.

Configuring Storybook in an existing application is repetitive, project-specific work that AI agents handle well. When you add Storybook to a project using an agent, it analyzes your project (framework, renderer, builder, language, addons) and produces a Markdown guide with [step-by-step instructions](#generated-setup-instructions). By following this guide, your agent will configure your preview file, set up commonly needed mocks, and write stories for components in your codebase.

After an agent follows those instructions, you have a working Storybook with stories for your components and a clear path to expanding coverage across your codebase.

## Set up Storybook with an agent

To set up Storybook in your project, copy/paste this prompt into your agent's chat:

```shell
Set up Storybook for me with npm create storybook@latest and follow its instructions precisely
```

The agent first runs [`storybook init`](https://storybook.js.org/docs/api/cli-options.md#init) to add Storybook to your project. When init completes, the agent offers to continue with project-specific configuration. If you agree, the agent generates the instructions, follows them step by step, and applies each change directly to your codebase so you can review its work.

### Generated setup instructions

The project-specific instructions cover the following steps:

1. **Analyze the codebase:** read providers, global CSS, portals, and data-fetching patterns.
2. **Configure the [preview](https://storybook.js.org/docs/configure/story-rendering.md):** set up [decorators](https://storybook.js.org/docs/writing-stories/decorators.md), [global styles](https://storybook.js.org/docs/configure/styling-and-css.md), and any framework-level providers in `preview.tsx`.
3. **Support portals:** ensure portal roots exist in the Storybook preview DOM.
4. **Mock side effects:** intercept [network requests](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-network-requests.md) (via MSW), storage, timers, and navigation at the preview level rather than per-story.
5. **Write [stories](https://storybook.js.org/docs/writing-stories.md):** add stories from up to 10 components, from simple to complex, [tagging](https://storybook.js.org/docs/writing-stories/tags.md) them as `ai-generated` for your review.
6. **Add [play functions](https://storybook.js.org/docs/writing-stories/play-function.md):** implement [interaction tests](https://storybook.js.org/docs/writing-tests/interaction-testing.md) for the most important flows.
7. **Cover additional patterns:** expand coverage across the components the agent has already touched.
8. **Verify:** run [Vitest](https://storybook.js.org/docs/writing-tests/integrations/vitest-addon.md) against every new story to confirm it renders, and run the type checker.
9. **Install useful addons:** add and configure addons like [MCP](https://storybook.js.org/docs/ai/mcp/overview.md) to help you (and your agent) get the most out of Storybook.

## Next steps

Once the agent has completed the setup:

- [Run your new Storybook](https://storybook.js.org/docs/get-started/install.md#start-storybook) and review the generated configuration files ([main](https://storybook.js.org/docs/configure/index.md#configure-your-storybook-project) and [preview](https://storybook.js.org/docs/configure/index.md#configure-story-rendering), most importantly).
- Review the stories tagged `ai-generated`, and remove the tag once you've validated each one.
- Connect the [Storybook MCP server](https://storybook.js.org/docs/ai/mcp/overview.md) to your agent so it can continue reading manifests, generating stories, and running tests against your live Storybook.
- Follow the [best practices](https://storybook.js.org/docs/ai/best-practices.md) to make your stories and documentation maximally useful to both humans and agents.

**More AI resources**

- [MCP server overview](https://storybook.js.org/docs/ai/mcp/overview.md)
- [MCP server API](https://storybook.js.org/docs/ai/mcp/api.md)
- [Sharing your MCP server](https://storybook.js.org/docs/ai/mcp/sharing.md)
- [Best practices for using Storybook with AI](https://storybook.js.org/docs/ai/best-practices.md)
- [Manifests](https://storybook.js.org/docs/ai/manifests.md)
