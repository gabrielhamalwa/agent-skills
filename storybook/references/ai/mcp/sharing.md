# Sharing your MCP server

Storybook's AI capabilities are in [preview](https://storybook.js.org/docs/releases/features.md#preview).
The API may change in future releases.
We welcome feedback and contributions to help improve this feature.

Sharing an MCP server means sharing its docs toolset, which needs a [components manifest](https://storybook.js.org/docs/ai/manifests.md).
See [framework support](https://storybook.js.org/docs/ai/mcp/overview.md#framework-support).

Your framework does not generate a components manifest yet, so there is no docs toolset to share.
The rest of this page applies once manifest support reaches it.

Just as [publishing your Storybook](https://storybook.js.org/docs/sharing/publish-storybook.md) can help your team work more effectively, sharing your MCP server can enable your team to share the benefits of AI-assisted development.

The MCP server is made of [development](https://storybook.js.org/docs/ai/mcp/overview.md#development), [docs](https://storybook.js.org/docs/ai/mcp/overview.md#docs), and [testing](https://storybook.js.org/docs/ai/mcp/overview.md#testing) toolsets that an agent can call to interact with your Storybook. The development and testing toolsets are only relevant to the locally-running Storybook instance, but the docs toolset can be published and shared so that agents outside of your local environment can access the knowledge from your Storybook's [manifest](https://storybook.js.org/docs/ai/manifests.md) to reference your components and documentation when generating UI.

There are two different ways you can share your MCP server.

## Automatic publishing with Chromatic

The easiest way to share your MCP server is to [publish your Storybook with Chromatic](https://storybook.js.org/docs/sharing/publish-storybook.md#publish-storybook-with-chromatic), which will [automatically publish your MCP server](https://chromatic.com/docs/mcp/) as well. If your Storybook is private, your MCP server will be private as well, and only accessible to those you invite to your Chromatic project. If your Storybook is public, your MCP server will be public as well, and accessible to anyone with the URL.

Once published, you can share the [MCP server URL](https://chromatic.com/docs/mcp/#grab-your-mcp-server-url) with your team or community, and they can configure their agent to use that URL to access it.

By publishing with Chromatic, you can be sure that your MCP server is always up-to-date with your latest Storybook, it's safeguarded by UI tests, and you don't have to worry about hosting or maintaining it yourself.

## Self-hosting with `@storybook/mcp`

If you prefer full control over your MCP server, you can self-host it. This approach allows you to manage the server's infrastructure, security, and updates according to your team's requirements. You will need to ensure your MCP server is accessible to your team or community and properly maintained.

We provide a package, `@storybook/mcp`, which is a library that creates a [`tmcp`-based](https://github.com/paoloricciuti/tmcp/) MCP server exposing Storybook component/docs knowledge from [manifests](https://storybook.js.org/docs/ai/manifests.md).

### Prerequisites

- Node.js 20+
- A [manifest](https://storybook.js.org/docs/ai/manifests.md) source containing:
  - `components.json` (required)
  - `docs.json` (optional)

### API

The full API for `@storybook/mcp` is documented in the [package README](https://github.com/storybookjs/storybook/tree/next/code/lib/mcp#api-reference).

### Example implementation

You can reference the in-repo [`serve.ts`](https://github.com/storybookjs/storybook/blob/next/code/lib/mcp/serve.ts) for a Node self-hosting example.

This is the minimal implementation of a server using `@storybook/mcp`:

```ts title="server.ts"

const storybookMcpHandler = await createStorybookMcpHandler();

export async function handleRequest(request: Request): Promise<Response> {
  if (new URL(request.url).pathname === '/mcp') {
    return storybookMcpHandler(request);
  }

  return new Response('Not found', { status: 404 });
}
```

**More AI resources**

- [Agentic setup](https://storybook.js.org/docs/ai/setup.md)
- [MCP server overview](https://storybook.js.org/docs/ai/mcp/overview.md)
- [MCP server API](https://storybook.js.org/docs/ai/mcp/api.md)
- [Best practices for using Storybook with AI](https://storybook.js.org/docs/ai/best-practices.md)
- [Manifests](https://storybook.js.org/docs/ai/manifests.md)
