# Agentic review

Agentic review is currently [experimental](https://storybook.js.org/docs/releases/features.md#experimental). The experience may change in future releases. We welcome feedback and contributions to help improve this feature.

When working with an agent, it can be hard to keep track of UI changes it has made. Agentic review allows agents to generate a summary of their work, including a curated selection of stories that have been affected by their changes.

This gives you a single, focused view of the work the agent has done, so you can quickly understand and review it.

![Review summary page, showing a text summary of the work and curated collections of stories](../_assets/ai/agentic-review-summary-in-ade.png)

## Requirements

- Storybook 10.5 or later
- [`experimentalReview` feature flag](https://storybook.js.org/docs/api/main-config/main-config-features.md#experimentalreview) enabled in your Storybook configuration
  - This is automatically enabled if you are using a Storybook [ADE plugin]
- [MCP server](https://storybook.js.org/docs/ai/mcp/overview.md) running and connected to your agent or [ADE plugin] installed

## Reviewing changes

Open the review summary by either clicking the link provided by the agent, requesting a review from your agent in a prompt, or clicking the review widget that appears in the Storybook sidebar when a review is available.

![Review widget in the Storybook sidebar summarizing the availability of a review](../_assets/ai/agentic-review-widget.png)

Note: If you are also using [change detection](https://storybook.js.org/docs/configure/user-interface/change-detection.md), the review widget will take precedence. You can still use the change detection filters to view new and modified stories, but the review widget will always be visible when a review is available.

![Review summary page, showing a text summary of the work and curated collections of stories](../_assets/ai/agentic-review-summary.png)

Everything on this page is generated or curated by the agent, to help you understand and review the work it has done. Stories are grouped into collections of related work, with a helpful title and summary. It's important to note that this is _not_ a comprehensive list of all affected stories, but rather a curated selection of the most relevant ones.

To see a story in more detail, click its thumbnail. You can inspect the component using Storybook features and browser tools, and even [run tests](https://storybook.js.org/docs/writing-tests/integrations/vitest-addon.md) if your Storybook is configured to do so.

![Review detail page, showing a full story with toolbar and navigation buttons](../_assets/ai/agentic-review-detail.png)

When in this view, you can use the next and previous buttons in the top right corner to navigate through the other stories in the review. You can also click the "Back to review" button to return to the summary page.

If you do some work after a review is generated, you'll see a banner informing you that the review may be stale. You can use the provided prompt to request a new review from your agent at any time.

![Review stale banner, informing the user that the review may be outdated](../_assets/ai/agentic-review-stale.png)

Once you're finished reviewing the work, you can return to your Storybook by clicking the Storybook logo in the top left corner of the page.

**More AI resources**

- [Agentic setup](https://storybook.js.org/docs/ai/setup.md)
- [MCP server overview](https://storybook.js.org/docs/ai/mcp/overview.md)
- [MCP server API](https://storybook.js.org/docs/ai/mcp/api.md)
- [Sharing your MCP server](https://storybook.js.org/docs/ai/mcp/sharing.md)
- [Best practices for using Storybook with AI](https://storybook.js.org/docs/ai/best-practices.md)
- [Manifests](https://storybook.js.org/docs/ai/manifests.md)

[ADE plugin]: https://github.com/storybookjs/storybook/tree/next/code/lib/claude-plugin#installation
