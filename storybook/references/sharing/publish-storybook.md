# Publish Storybook

Teams publish Storybook online to review and collaborate on works in progress. That allows developers, designers, PMs, and other stakeholders to check if the UI looks right without touching code or requiring a local dev environment.

## Build Storybook as a static web application

First, we'll need to build Storybook as a static web application. The functionality is already built-in and pre-configured for most supported frameworks. Run the following command inside your project's root directory:

```shell
npm run build-storybook
```

```shell
pnpm run build-storybook
```

```shell
yarn build-storybook
```

You can provide additional flags to customize the command. Read more about the flag options [here](https://storybook.js.org/docs/api/cli-options.md).

Storybook will create a static web application capable of being served by any web server. Preview it locally by running the following command:

```shell
npx http-server ./path/to/build
```

```shell
pnpm dlx http-server ./path/to/build
```

### Customizing the build for performance

By default, Storybook's production build will encapsulate all stories and documentation into the production bundle. This is ideal for small projects but can cause performance issues for larger projects or when decreased build times are a priority (e.g., testing, CI/CD). If you need, you can customize the production build with the [`test` option](https://storybook.js.org/docs/api/main-config/main-config-build.md#test) in your `main.js|ts` configuration file and adjust your build script to enable the optimizations with the `--test` [flag](https://storybook.js.org/docs/api/cli-options.md#build).

```shell
npm run build-storybook -- --test
```

```shell
pnpm run build-storybook --test
```

```shell
yarn build-storybook --test
```

### Build Storybook for older browsers

The Storybook app's UI supports [modern browsers](https://storybook.js.org/docs/get-started/install.md#project-requirements). If you need to run the app in older, unsupported browsers, you can use the [`--preview-only` CLI flag](https://storybook.js.org/docs/api/cli-options.md#build) to build Storybook in "preview-only" mode. This skips building the Storybook manager (the UI surrounding your stories) and only builds the preview (the iframe that contains your stories). That makes your [Storybook builder](https://storybook.js.org/docs/builders.md) and its configuration solely responsible for which browsers are supported.

When in "preview-only" mode, the normal entry point, `/index.html`, will result in a 404, because the client-side router is not available. To work around this, start from the `/iframe.html` route and add the `?navigator=true` query parameter to the URL. This will render a basic, HTML-only sidebar inside the preview so that you can navigate to your stories. For example, you can access the preview at `http://localhost:6006/iframe.html?navigator=true` (you may need to update the port number).

This applies to both the [`build`](https://storybook.js.org/docs/api/cli-options.md#build) (for publishing) and [`dev`](https://storybook.js.org/docs/api/cli-options.md#dev) (for local development) commands.

## Publish Storybook with Chromatic

Once you've built your Storybook as a static web application, you can publish it to your web host. We recommend [Chromatic](https://www.chromatic.com/?utm_source=storybook_website&utm_medium=link&utm_campaign=storybook), a free publishing service made for Storybook that documents, versions, and indexes your UI components securely in the cloud.

![Storybook publishing workflow](../_assets/sharing/workflow-publish.png)

To get started, sign up with your GitHub, GitLab, Bitbucket, or email and generate a unique _project-token_ for your project.

Next, install the [Chromatic CLI](https://www.npmjs.com/package/chromatic) package from npm:

```shell
npm install chromatic --save-dev
```

```shell
pnpm add --save-dev chromatic
```

```shell
yarn add --dev chromatic
```

Run the following command after the package finishes installing. Make sure that you replace `your-project-token` with your own project token.

```shell
npx chromatic --project-token=<your-project-token>
```

When Chromatic finishes, you should have successfully deployed your Storybook. Preview it by clicking the link provided (i.e., `https://random-uuid.chromatic.com`).

```shell
Build 1 published.

View it online at https://www.chromatic.com/build?appId=...&number=1.
```

![Chromatic publish build](../_assets/sharing/build-publish-only.png)

### Setup CI to publish automatically

Configure your CI environment to publish your Storybook and [run Chromatic](https://www.chromatic.com/docs/ci?utm_source=storybook_website&utm_medium=link&utm_campaign=storybook) whenever you push code to a repository. Let's see how to set it up using GitHub Actions.

In your project's root directory, add a new file called `chromatic.yml` inside the `.github/workflows` directory:

```yml
// .github/workflows/chromatic.yml
# Workflow name
name: 'Chromatic Publish'

# Event for the workflow
on: push

# List of jobs
jobs:
  test:
    # Operating System
    runs-on: ubuntu-latest
    # Job steps
    steps:
      - uses: actions/checkout@v6
        with:
          fetch-depth: 0
      - uses: actions/setup-node@v6
        with:
          node-version: 24
          cache: 'yarn'
      - run: yarn
      #👇 Adds Chromatic as a step in the workflow
      - uses: chromaui/action@latest
        # Options required for Chromatic's GitHub Action
        with:
          #👇 Chromatic projectToken,
          projectToken: ${{ secrets.CHROMATIC_PROJECT_TOKEN }}
          token: ${{ secrets.GITHUB_TOKEN }}
```

Secrets are secure environment variables provided by GitHub so that you don't need to hard code your `project-token`. Read the [official documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) to learn how to configure them.

Commit and push the file. Congratulations, you've successfully automated publishing your Storybook. Now whenever you open a PR you’ll get a handy link to your published Storybook in your PR checks.

![PR check publish](../_assets/sharing/prbadge-publish.png)

### Review with your team

Publishing Storybook as part of the development process makes it quick and easy to gather team feedback.

A common method to ask for review is to paste a link to the published Storybook in a pull request or Slack.

If you publish your Storybook to Chromatic, you can use the [UI Review](https://www.chromatic.com/features/publish?utm_source=storybook_website&utm_medium=link&utm_campaign=storybook) feature to automatically scan your PRs for new and updated stories. That makes it easy to identify what changed and give feedback.

![UI review in Chromatic](../_assets/sharing/workflow-uireview.png)

### Versioning and history

When you publish Storybook, you also get component history and versioning down to the commit. That's useful during implementation review for comparing components between branches/commits to past versions.

![Library history in Chromatic](../_assets/sharing/workflow-history-versioning.png)

## Publish Storybook to other services

Since Storybook is built as a static web application, you can also publish it to any web host, including [GitHub Pages](https://docs.github.com/en/pages), [Netlify](https://www.netlify.com/), [AWS S3](https://aws.amazon.com/s3/), and more. However, features such as [Composition](https://storybook.js.org/docs/sharing/storybook-composition.md), [embedding stories](https://storybook.js.org/docs/sharing/embed.md), history, versioning, and assets may require tighter integration with Storybook APIs and secure authentication. If you want to know more about headers, you can refer to the [Migration guide](https://github.com/storybookjs/storybook/blob/next/MIGRATION.md#deploying-build-artifacts). Additionally, if you want to learn about the Component Publishing Protocol (CPP), you can find more information below.

### GitHub Pages

To deploy Storybook on GitHub Pages, use the community-built [Deploy Storybook to GitHub Pages](https://github.com/bitovi/github-actions-storybook-to-github-pages) Action. To enable it, create a new workflow file inside your `.github/workflows` directory with the following content:

```yml
// .github/workflows/deploy-github-pages.yml
name: Build and Publish Storybook to GitHub Pages
on:
  push:
    branches:
      - 'your-branch-name' # Use specific branch name
permissions:
  contents: read
  pages: write
  id-token: write
concurrency:
  group: 'pages'
  cancel-in-progress: false
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deploy.outputs.page_url }}
    steps:
      - name: Checkout
        uses: actions/checkout@v6
        with:
          fetch-depth: 0
      - name: Setup Node
        uses: actions/setup-node@v6
        with:
          node-version: '24'
          cache: 'npm' # Adjust caching strategy and configuration if using other package managers
      - name: Install dependencies
        run: npm ci # Replace with appropriate command if using other package managers
      - name: Build Storybook
        run: npm run build-storybook
      # Upload pages artifact
      - name: Upload Pages artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: 'storybook-static'
      # Deploy to Github Pages
      - id: deploy
        name: Deploy to GitHub Pages
        uses: actions/deploy-pages@v4
        with:
          token: ${{ github.token }}
```

The GitHub Pages Action requires additional configuration options to customize the deployment process. Refer to the [official documentation](https://github.com/marketplace/actions/deploy-storybook-to-github-pages) for more information.

<details>
<summary>
<h3>Component Publishing Protocol (CPP)</h3>
</summary>

Storybook can communicate with services that host built Storybooks online. This enables features such as [Composition](https://storybook.js.org/docs/sharing/storybook-composition.md). We categorize services via compliance with the "Component Publishing Protocol" (CPP) with various levels of support in Storybook.

### CPP level 1

This level of service serves published Storybooks and makes the following available:

- Versioned endpoints, URLs that resolve to different published Storybooks depending on a `version=x.y.z` query parameter (where `x.y.z` is the released version of the package).
- Support for `/index.json` (formerly `/stories.json`) endpoint, which returns a list of stories and their metadata.
- Support for `/metadata.json` and the `releases` field.

Example: [Chromatic](https://www.chromatic.com/?utm_source=storybook_website&utm_medium=link&utm_campaign=storybook)

### CPP level 0

This level of service can serve published Storybooks but has no further integration with Storybook’s APIs.

Examples: [Netlify](https://www.netlify.com/), [S3](https://aws.amazon.com/en/s3/)

</details>

## Search engine optimization (SEO)

If your Storybook is publicly viewable, you may wish to configure how it is represented in search engine result pages.

### Description

You can provide a description for search engines to display in the results listing, by adding the following to the `manager-head.html` file in your config directory:

```html
// .storybook/manager-head.html
<meta name="description" content="Components for my awesome project" key="desc" />
```

### Preventing your Storybook from being crawled

You can prevent your published Storybook from appearing in search engine results by including a noindex meta tag, which you can do by adding the following to the `manager-head.html` file in your config directory:

```html
// .storybook/manager-head.html
<meta name="robots" content="noindex" />
```
