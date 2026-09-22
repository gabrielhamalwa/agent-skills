---
name: symfony
description: Symfony documentation and reference (7.x branch). Use when building or debugging Symfony PHP applications: controllers, routing, service container and autowiring, Doctrine entities and migrations, forms and validation, security and authentication, Messenger queues, Twig templates, console commands, bundle configuration, or testing.
metadata:
    source: https://github.com/symfony/symfony-docs
    mirrored: "2026-09-22"
    version: "1.0"
---

# Symfony Skill Reference

## Overview

Symfony is a PHP framework of decoupled components + a full-stack app skeleton. Core model: services in a compiled container (autowiring/autoconfiguration via `config/services.yaml`), bundles provide features, attributes or YAML configure behavior, `bin/console` is the CLI entry.

`references/` contains the full Symfony documentation (7.4 branch): 430 `.rst` pages in reStructuredText (readable plain text; `.. code-block:: php` marks code samples). `references/VERSION` records the branch and commit. Do not edit files in `references/` (licensed CC BY-SA 3.0, see `references/LICENSE.md`); update with `bash scripts/refresh-docs.sh`.

## When to Use

- **HTTP layer**: controllers, routing (attributes or `config/routes/`), request/response, sessions
- **Services/DI**: `services.yaml`, autowiring, service decoration, compiler passes, `debug:container`
- **Doctrine**: entities, repositories, migrations, fixtures, query builder/DQL
- **Forms & validation**: form types, constraints, data transformers
- **Security**: firewalls, authenticators, voters, password hashing, access control
- **Async**: Messenger transports/workers, Scheduler, Mercure, notifier, mailer
- **Frontend**: Twig templates, AssetMapper/Encore (`frontend/`), Stimulus/Turbo
- **Platform**: cache, console commands, deployment, testing (PHPUnit + BrowserKit/Panther), profiler, logging

## Reference Index

Root `.rst` pages are component/topic entries (each often has a matching subdirectory of detail pages):

| Area | Path | Covers |
|------|------|--------|
| Start | `references/` root | `index.rst`, `page_creation.rst`, `setup.rst`, `getting_started/`, `introduction/`, `best_practices.rst`, `create_framework/` |
| HTTP core | root + dirs | `controller.rst` + `controller/`, `routing.rst` + `routing/`, `templates.rst` (Twig), `session.rst`, `http_cache.rst` + `http_cache/` |
| Services & config | root + dirs | `service_container.rst` + `service_container/`, `configuration.rst` + `configuration/`, `bundles.rst` + `bundles/`, `reference/` (config formats, Twig functions, form types, constraints, DI tags) |
| Doctrine | `doctrine.rst` + `doctrine/` | entities, migrations, fixtures, events, associations |
| Forms & data | root + dirs | `forms.rst` + `form/`, `validation/`, `serializer.rst` + `serializer/`, `object_mapper.rst` |
| Security | `security.rst` + `security/` | firewalls, authenticators, voters, access control |
| Async/messaging | root + dirs | `messenger.rst` + `messenger/`, `scheduler.rst`, `mercure.rst`, `notifier.rst`, `mailer.rst`, `lock.rst`, `rate_limiter.rst` |
| Frontend | `frontend.rst` + `frontend/` | AssetMapper, Webpack Encore, Stimulus, UX components |
| Components | `components/` + root | `components/` holds http_foundation, http_kernel, browser_kit, dom_crawler, finder, process, uid, yaml, config, contracts, asset...; standalone topics are root pages (`http_client.rst`, `event_dispatcher.rst`, `expression_language.rst`, `string.rst`, `html_sanitizer.rst`, `mime_types.rst`, `emoji.rst`, ...) |
| Ops | root + dirs | `deployment.rst` + `deployment/`, `cache.rst` + `cache/`, `logging.rst` + `logging/`, `profiler.rst`, `migration.rst`, `performance.rst` |
| Testing/console | root + dirs | `testing.rst` + `testing/`, `console.rst` + `console/` |
| Contributing | `contributing/` | Docs/code contribution rules |

## Quick Reference

| Task | Command | Notes |
|------|---------|-------|
| New project | `symfony new myapp --webapp` | Or `composer create-project symfony/skeleton` |
| Dev server | `symfony serve` | Or `symfony server:start` |
| Run console | `php bin/console <cmd>` | `symfony console` wraps with env vars |
| Make things | `bin/console make:controller` | make:entity, make:form, make:migration, make:security:form-login, make:security:custom ... |
| Clear cache | `bin/console cache:clear` | Per-env: `--env=prod` |
| Debug | `debug:router`, `debug:container`, `debug:autowiring`, `debug:config <bundle>` | `lint:container`, `lint:yaml`, `lint:twig` for validation |
| DB | `doctrine:migrations:migrate`, `doctrine:schema:validate` | `make:migration` diffs entities → migration |
| Migrations | `bin/console doctrine:migrations:diff` | Requires doctrine/migrations-bundle |
| Secrets | `bin/console secrets:set KEY` | Vault, not `.env` |
| Worker | `bin/console messenger:consume async` | Long-running; restart on deploy |

## Common Gotchas

- **Config changes need a cache clear in prod** (`cache:clear --env=prod`); dev rebuilds automatically.
- **Services are private by default** — inject via constructor autowiring; don't `$container->get()`. Scalar args need `bind` or explicit config in `services.yaml`.
- **`.env` is for defaults, not secrets** — use the secrets vault (`secrets:set`) or real env vars; `%env(VAR)%` resolves at runtime, `%env(json:VAR)%`/`%env(bool:VAR)%` for typed decoding.
- **Attributes are the modern default** for routes, security, validation constraints, doctrine mapping — YAML/XML still supported.
- **Messenger handlers run in a separate worker process** — code changes need a worker restart; use `messenger:consume --limit` or restart strategy in deploys.
- **Routes/forms/validation docs are per-version** — these references track the `7.4` docs branch; older projects may differ (check `references/VERSION`).

## Maintenance

Update `references/` with `bash scripts/refresh-docs.sh` (pulls the latest docs source, prunes stale pages). Runs weekly via GitHub Actions.
