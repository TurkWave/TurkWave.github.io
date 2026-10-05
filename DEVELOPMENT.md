# Development

Technical notes for the source of [turkwave.github.io](https://turkwave.github.io/).
Built with Jekyll (no theme gem — the layouts and styling live in this repo) and deployed
automatically by GitHub Actions on every push to `main`.

## What's where

- `_docs/` — each app's documents, one folder per app (e.g. `_docs/<app-slug>/`). This is
  where the actual content (privacy policy, terms, etc.) lives.
- `_layouts/` — Jekyll page templates that turn the documents in `_docs/` into site pages.
- `_templates/` — copy-paste starting point for adding a new app (`new-app/`).
- `_config.yml` — site-wide configuration (plugins, the `docs` collection, URL scheme).
- `.github/workflows/` — GitHub Actions workflow that builds and deploys the site.
- `bin/new-app` — scaffolds a new app's folder from `_templates/new-app/`.
- `index.md` — the site's home page.

## Adding an app

```sh
bin/new-app <app-slug>   # Windows: prefix with `ruby `
```

Creates `_docs/<app-slug>/` from the template with `permalink`, `title`, a first
`description` and today's `effective_date` / `last_updated` filled in (override with
`--date YYYY-MM-DD`). The display name is derived from the slug (`my-app` → "My App")
by both the layouts and this script, so it lives in exactly one place — the folder
name. The support address comes from `contact_email` in `_config.yml`, shared by every
page. Validates the slug, refuses an existing folder. Then set `lang` in `index.md` and
in every document (see [Search engines & bots](#search-engines--bots)), write the real
text into `privacy.md`, `terms.md`, `license.md`, `third-party.md` and `support.md`, and
commit.

## URLs & redirects

Documents publish at `/<app-slug>/<doc-slug>/` and each app index at `/<app-slug>/`,
derived mechanically from the file path — no link list is kept by hand. `<app-slug>`
may not be one of the reserved top-level names (`apps`, `assets`, `sitemap`, `robots`,
`404`, `index`); `_scripts/validate_urls.rb` enforces that. The previous
`/apps/<app-slug>/…` scheme still works: every old URL redirects to its new location
via `jekyll-redirect-from` (`redirect_from:` entries in `_docs/*/*.md`), and
`_scripts/validate_redirects.rb` verifies each one after the build.

## Search engines & bots

Every page is static HTML, so crawlers and AI readers get the full text without running
JavaScript. What they are told about each page is front matter, checked by
`_scripts/validate_metadata.rb` (part of `make lint`):

- `description` — required in `index.md` and every document. It is the page's
  `<meta name="description">` (and the description in the app's structured data), written
  by hand; `bin/new-app` only supplies a first version.
- `lang` — required, `en-US` or `tr-TR`. It sets `<html lang>` and `og:locale`. A page
  that repeats its text in a second language adds `lang_also` with the other value
  (`og:locale:alternate`). `bin/new-app` leaves `lang: REPLACE-WITH-LANG`, so a new app
  fails the check until the language is set. It must stay a single string: jekyll-seo-tag
  calls `String#tr` on it, and a YAML list would abort the build.
- Document pages are typed `WebPage` in the structured data (a `defaults` entry in
  `_config.yml`); an app index also carries a `SoftwareApplication` block
  (`_layouts/app-index.html`) built only from facts in its `index.md`.
- `/llms.txt` (`llms.txt`) is generated from that front matter. `/sitemap.xml` and
  `/robots.txt` come from `jekyll-sitemap`.
- The sample apps (`demo-app`, `example-app`) are `noindex` and left out of `sitemap.xml`
  and `llms.txt` by `defaults` entries in `_config.yml`. Delete an entry to publish that
  app normally. Scope paths match by string prefix, hence the trailing slash.

## Local development

Requires Ruby + Bundler. From the repo root:

```sh
bundle install
bundle exec jekyll serve   # http://localhost:4000/
```

With `make` installed (standard on Unix; `scoop install make` / `choco install make` on
Windows) there are shortcuts — recipes assume a POSIX shell, so use Git Bash on Windows:

| Command        | Runs                                                            |
|----------------|--------------------------------------------------------------- |
| `make install`  | `bundle install`                                              |
| `make serve`    | `bundle exec jekyll serve --livereload`                       |
| `make build`    | `JEKYLL_ENV=production bundle exec jekyll build` (matches CI)  |
| `make lint`     | config + URL + content + metadata validators (bare Ruby, pre-build) |
| `make validate` | redirect validator (bare Ruby, needs a build first)          |
| `make test`     | the Ruby test suites                                          |
| `make clean`    | removes `_site` and `.jekyll-cache`                           |
| `make preview`  | `install`, then `serve`                                       |
