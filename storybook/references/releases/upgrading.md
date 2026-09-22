# Upgrading Storybook

The frontend ecosystem is a fast-moving place. Regular dependency upgrades are a way of life, whether upgrading a framework, library, tooling, or all of the above! Storybook provides a few resources to help ease the pain of upgrading.

## Upgrade script

The most common upgrade is Storybook itself. [Storybook releases](https://storybook.js.org/releases) follow [Semantic Versioning](https://semver.org/). We publish patch releases with bug fixes continuously, minor versions of Storybook with new features every few months, and major versions of Storybook with breaking changes roughly once per year.

To help ease the pain of keeping Storybook up-to-date, we provide a command-line script that automatically detects all Storybook projects in your repository:

```shell
npx storybook@latest upgrade
```

```shell
pnpm dlx storybook@latest upgrade
```

```shell
yarn dlx storybook@latest upgrade
```

**Important:** Always run the upgrade command from your repository root. The script will automatically detect all Storybook projects in your repository, including in mono-repository setups.

The `upgrade` command will use whichever version you specify. For example:

- `storybook@latest upgrade` will upgrade to the latest version
- `storybook@8.6.1 upgrade` will upgrade to `8.6.1`
- `storybook@9 upgrade` will upgrade to the newest `9.x.x` version

The `upgrade` command is designed to upgrade from one major version to the next.

- ✅ OK: Using Storybook 8 and running `storybook@9 upgrade`
- ❌ Not OK: Using Storybook 7 and running `storybook@9 upgrade`

If you want to upgrade across more than major version, run the command multiple times. For example, to upgrade from Storybook 7 to Storybook 9, you first need to upgrade to the latest version of Storybook 8 with `storybook@8 upgrade`, and then run `storybook@9 upgrade` to upgrade to the latest version of Storybook 9.

The only exception to this is when upgrading from 6 to 8, where you can run `storybook@8 upgrade` directly to upgrade from 6.x.x to 8.x.x.

### Mono-repository support

The upgrade script provides enhanced support for mono-repositories:

- **Automatic detection**: The script automatically detects all Storybook projects in your repository
- **Selective upgrades**: If your Storybooks are truly encapsulated (meaning each Storybook project has its own independent Storybook dependencies in its own `package.json`), you can select which Storybook project to upgrade
- **Bulk upgrades**: If your Storybooks share dependencies, all detected projects will be upgraded together to ensure consistency

#### Limiting scope in large mono-repositories

For large mono-repositories where you want to limit the upgrade to a specific directory, use the `STORYBOOK_PROJECT_ROOT` environment variable:

```bash
STORYBOOK_PROJECT_ROOT=./packages/frontend storybook@latest upgrade
```

This is especially helpful in huge mono-repositories with semi-encapsulated Storybooks.

## Upgrade process

After running the command, the script will:

- Detect all Storybook projects in your repository
- Upgrade all Storybook packages to the specified version
- Run the relevant [automigrations](https://storybook.js.org/docs/releases/migration-guide.md#automatic-upgrade) factoring in the [breaking changes](https://storybook.js.org/docs/releases/migration-guide.md#major-breaking-changes) between your current version and the specified version
- Automatically run the [doctor command](#automatic-health-check) to verify the upgrade

In addition to running the command, we also recommend checking the [MIGRATION.md file](https://github.com/storybookjs/storybook/blob/next/MIGRATION.md), for the detailed log of relevant changes and deprecations that might affect your upgrade.

### Experimental feature flags

When an upgrade crosses into Storybook 10.5, the automigration step additionally offers to enable the experimental [`experimentalReview`](https://storybook.js.org/docs/api/main-config/main-config-features.md#experimentalreview) and [`experimentalDocgenServer`](https://storybook.js.org/docs/api/main-config/main-config-features.md#experimentaldocgenserver) feature flags.
These are strictly opt-in and are never enabled on your behalf: they appear unchecked in the automigration prompt, and, unless you name them with `--features`, `--yes` skips them along with the other migrations that require a deliberate choice.
If your configuration already sets one of them, to either `true` or `false`, that choice is left untouched and the flag is not offered.

To preselect them, including on a project that is already on 10.5 or later, list them with the [`--features` flag](https://storybook.js.org/docs/api/cli-options.md#upgrade):

```bash
storybook@latest upgrade --features experimentalReview,experimentalDocgenServer
```

`experimentalDocgenServer` is only offered on frameworks that provide server-side docgen.

### Automatic health check

The upgrade script automatically runs a health check on all detected Storybook projects after the upgrade. This verifies that the upgrade was completed successfully and checks for common issues that might arise after an upgrade, such as duplicated dependencies, incompatible addons, or mismatched versions.

The health check runs automatically for all detected Storybooks. You can also run it manually at any time using the `storybook doctor` command:

```shell
npx storybook@latest doctor
```

```shell
pnpm dlx storybook@latest doctor
```

```shell
yarn dlx storybook@latest doctor
```

### Error handling and debugging

If you encounter issues during the upgrade:

1. A `debug-storybook.log` file will be created in the repository root containing all relevant logs
2. For more detailed information, set the log level to `debug` using the `--loglevel debug` flag
3. Create a GitHub issue with the logs if you need help resolving the problem

## Command-line options

The upgrade command supports several flags to customize the upgrade process:

```bash
storybook@latest upgrade [options]
```

See the [`upgrade` command reference](https://storybook.js.org/docs/api/cli-options.md#upgrade) for the full list of supported flags.

### Example usage

```bash
# Upgrade with logging for debugging
storybook@latest upgrade --loglevel debug --logfile debug-storybook.log

# Force upgrade without prompts
storybook@latest upgrade --force --yes

# Upgrade specific config directories only
storybook@latest upgrade --config-dir .storybook-app .storybook-ui
```

## Automigrate script

Storybook upgrades are not the only thing to consider: changes in the ecosystem also present challenges. For example well-known frontend frameworks, such as [Angular](https://update.angular.io/?l=2&v=16.0-17.0), [Next.js](https://nextjs.org/docs/pages/building-your-application/upgrading) or [Svelte](https://svelte.dev/docs/v4-migration-guide) have been rolling out significant changes to their ecosystem, so even if you don't upgrade your Storybook version, you might need to update your configuration accordingly. That's what Automigrate is for:

```shell
npx storybook@latest automigrate
```

```shell
pnpm dlx storybook@latest automigrate
```

```shell
yarn dlx storybook@latest automigrate
```

It runs a set of standard configuration checks, explains what is potentially out-of-date, and offers to fix it for you automatically. It also points to the relevant documentation so you can learn more. It runs automatically as part of [`storybook upgrade`](#upgrade-script) command, but it's also available on its own if you don't want to upgrade Storybook.

## Prereleases

In addition to the above, Storybook is under constant development, and we publish pre-release versions almost daily. Pre-releases are the best way to try out new features before they are generally available, and we do our best to keep them as stable as possible, although this is not always possible.

To upgrade to the latest pre-release:

```shell
npx storybook@next upgrade
```

```shell
pnpm dlx storybook@next upgrade
```

```shell
yarn dlx storybook@next upgrade
```

The `upgrade` command will use whichever version you specify. For example:

- `storybook@next upgrade` will upgrade to the newest pre-release version
- `storybook@8.0.0-beta.1 upgrade` will upgrade to `8.0.0-beta.1`
- `storybook@8 upgrade` will upgrade to the newest `8.x` version

If you'd like to downgrade to a stable version, manually edit the package version numbers in your `package.json` and re-install.

Storybook collects completely anonymous data to help us improve user experience. Participation is optional, and you may [opt-out](https://storybook.js.org/docs/configure/telemetry.md#how-to-opt-out) if you'd not like to share any information.

## Troubleshooting

### Storybook doesn't detect my Storybook project

By default, the upgrade script will attempt to find Storybook configuration in `.storybook` directories in your repository. If your Storybook configuration is located in a different directory, you can specify it using the `--config-dir` flag.

The `--config-dir` flag can accept multiple directories.

```bash
storybook@latest upgrade --config-dir .storybook-app .storybook-ui
```

If your project can be detected, but you get an error during the detection process, please check the `debug-storybook.log` file in the root of your repository. It will contain the full output of the detection process and will help you troubleshoot the issue.

### Storybook doesn't automigrate non-Storybook files

Our automigrations usually only transform and migrate files inside of your `.storybook` directory and your story and mdx files, which are mentioned as part of the Storybook configuration.

If you have other files that contain Storybook-specific code, you might need to manually migrate them.
