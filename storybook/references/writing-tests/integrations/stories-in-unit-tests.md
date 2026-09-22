# Stories in unit tests

Teams test a variety of UI characteristics using different tools. Each tool requires you to replicate the same component state over and over. That’s a maintenance headache. Ideally, you’d set up your tests similarly and reuse that across tools.

Storybook enables you to isolate a component and capture its use cases in a `*.stories.js|ts` file. Stories are standard JavaScript modules that are cross-compatible with the whole JavaScript ecosystem.

Stories are a practical starting point for UI testing. Import stories into tools like [Jest](https://jestjs.io/), [Testing Library](https://testing-library.com/), [Vitest](https://vitest.dev/) and [Playwright](https://playwright.dev/), to save time and maintenance work.

## Write a test with Testing Library

[Testing Library](https://testing-library.com/) is a suite of helper libraries for browser-based component tests. With [Component Story Format](https://storybook.js.org/docs/api/csf.md), your stories are reusable with Testing Library. Each named export (story) is renderable within your testing setup. For example, if you were working on a login component and wanted to test the invalid credentials scenario, here's how you could write your test:

Storybook provides a [`composeStories`](https://storybook.js.org/docs/api/portable-stories/portable-stories-vitest.md#composestories) utility that helps convert stories from a test file into renderable elements that can be reused in your Node tests with JSDOM. It also allows you to apply other Storybook features that you have enabled your project (e.g., [decorators](https://storybook.js.org/docs/writing-stories/decorators.md), [args](https://storybook.js.org/docs/writing-stories/args.md)) into your tests, enabling you to reuse your stories in your testing environment of choice (e.g., [Jest](https://jestjs.io/), [Vitest](https://vitest.dev/)), ensuring your tests are always in sync with your stories without having to rewrite them. This is what we refer to as portable stories in Storybook.

```ts
// Form.test.ts|tsx

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const { InvalidForm } = composeStories(stories);

test('Checks if the form is valid', async () => {
  const user = userEvent.setup();

  // Renders the composed story
  await InvalidForm.run();

  const buttonElement = screen.getByRole('button', {
    name: 'Submit',
  });

  await user.click(buttonElement);

  const isFormValid = screen.getByLabelText('invalid-form');
  expect(isFormValid).toBeInTheDocument();
});
```

These examples use Testing Library's `screen` queries because the composed stories run inside your unit test renderer. In a story's `play` function, prefer the provided `canvas` queries so interactions stay scoped to the rendered story.

You **must** [configure your test environment to use portable stories](https://storybook.js.org/docs/api/portable-stories/portable-stories-vitest.md#1-apply-project-level-annotations) to ensure your stories are composed with all aspects of your Storybook configuration, such as [decorators](https://storybook.js.org/docs/writing-stories/decorators.md).

Once the test runs, it loads the story and renders it. [Testing Library](https://testing-library.com/) then emulates the user's behavior and checks if the component state has been updated.

### Override story properties

By default, the `setProjectAnnotations` function injects into your existing tests any global configuration you've defined in your Storybook instance (i.e., parameters, decorators in the `preview.*` file). Nevertheless, this may cause unforeseen side effects for tests that are not intended to use these global configurations. For example, you may want to always test a story in a particular locale (via `globalTypes`) or configure a story to apply specific `decorators` or `parameters`.

To avoid this, you can override the global configurations by extending either the `composeStory` or `composeStories` functions to provide test-specific configurations. For example:

```js
// Form.test.js|ts — compose-stories
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const { ValidForm } = composeStories(stories, {
  decorators: [
    // Decorators defined here will be added to all composed stories from this function
  ],
  globalTypes: {
    // Override globals for all composed stories from this function
  },
  parameters: {
    // Override parameters for all composed stories from this function
  },
});
```

```js
// Form.test.js|ts — compose-story
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const ValidForm = composeStory(ValidFormStory, Meta, {
  decorators: [
    // Decorators defined here will be added to this story
  ],
  globalTypes: {
    // Override globals for this story
  },
  parameters: {
    // Override parameters for this story
  },
});
```

## Run tests on a single story

You can use the [`composeStory`](https://storybook.js.org/docs/api/portable-stories/portable-stories-vitest.md#composestory) function to allow your tests to run on a single story. However, if you're relying on this method, we recommend that you supply the story metadata (i.e., the [default export](https://storybook.js.org/docs/writing-stories/index.md#default-export)) to the `composeStory` function. This ensures that your tests can accurately determine the correct information about the story. For example:

```ts
// Form.test.ts|tsx

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const ValidForm = composeStory(ValidFormStory, Meta);

test('Validates form', async () => {
  const user = userEvent.setup();

  await ValidForm.run();

  const buttonElement = screen.getByRole('button', {
    name: 'Submit',
  });

  await user.click(buttonElement);

  const isFormValid = screen.getByLabelText('invalid-form');
  expect(isFormValid).not.toBeInTheDocument();
});
```

## Combine stories into a single test

If you intend to test multiple stories in a single test, use the [`composeStories`](https://storybook.js.org/docs/api/portable-stories/portable-stories-vitest.md#composestories) function. It will process every component story you've specified, including any [`args`](https://storybook.js.org/docs/writing-stories/args.md) or [`decorators`](https://storybook.js.org/docs/writing-stories/decorators.md) you've defined. For example:

```ts
// Form.test.ts|tsx

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const { InvalidForm, ValidForm } = composeStories(FormStories);

test('Tests invalid form state', async () => {
  const user = userEvent.setup();

  await InvalidForm.run();

  const buttonElement = screen.getByRole('button', {
    name: 'Submit',
  });

  await user.click(buttonElement);

  const isFormValid = screen.getByLabelText('invalid-form');
  expect(isFormValid).toBeInTheDocument();
});

test('Tests filled form', async () => {
  const user = userEvent.setup();

  await ValidForm.run();

  const buttonElement = screen.getByRole('button', {
    name: 'Submit',
  });

  await user.click(buttonElement);

  const isFormValid = screen.getByLabelText('invalid-form');
  expect(isFormValid).not.toBeInTheDocument();
});
```

## Troubleshooting

### Run tests in other frameworks

Storybook provides community-led addons for other frameworks like [Vue 2](https://storybook.js.org/addons/@storybook/testing-vue) and [Angular](https://storybook.js.org/addons/@storybook/testing-angular). However, these addons still lack support for the latest stable Storybook release. If you're interested in helping out, we recommend reaching out to the maintainers using the default communication channels (GitHub and [Discord server](https://discord.com/channels/486522875931656193/839297503446695956)).

### The args are not being passed to the test

The components returned by `composeStories` or `composeStory` not only can be rendered as React components but also come with the combined properties from the story, meta, and global configuration. This means that if you want to access args or parameters, for instance, you can do so:

```ts
// Button.test.ts|tsx

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const { Primary } = composeStories(stories);

test('reuses args from composed story', () => {
  render();

  const buttonElement = screen.getByRole('button');
  // Testing against values coming from the story itself! No need for duplication
  expect(buttonElement.textContent).toEqual(Primary.args.label);
});
```

### Next.js Vite cannot find the module

If you are seeing error messages like `Cannot find module 'sb-original/image-context'` ensure you have included `storybookNextJsPlugin`.

```ts
// vitest.config.ts

export default defineConfig({
  // only necessary when not using @storybook/addon-vitest, otherwise the plugin is loaded automatically
  plugins: [storybookNextJsPlugin()],
});
```

**More testing resources**

- [Interaction testing](https://storybook.js.org/docs/writing-tests/interaction-testing.md) for user behavior simulation
- [Accessibility testing](https://storybook.js.org/docs/writing-tests/accessibility-testing.md) for accessibility
- [Visual testing](https://storybook.js.org/docs/writing-tests/visual-testing.md) for appearance
- [Snapshot testing](https://storybook.js.org/docs/writing-tests/snapshot-testing.md) for rendering errors and warnings
- [Test coverage](https://storybook.js.org/docs/writing-tests/test-coverage.md) for measuring code coverage
- [CI](https://storybook.js.org/docs/writing-tests/in-ci.md) for running tests in your CI/CD pipeline
- [Vitest addon](https://storybook.js.org/docs/writing-tests/integrations/vitest-addon.md) for running tests in Storybook
- [Test runner](https://storybook.js.org/docs/writing-tests/integrations/test-runner.md) to automate test execution
- [End-to-end testing](https://storybook.js.org/docs/writing-tests/integrations/stories-in-end-to-end-tests.md) for simulating real user scenarios
