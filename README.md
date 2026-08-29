# TurkWave App Legal & Support Documents

Source for [turkwave.github.io](https://turkwave.github.io/) — privacy policies, terms of
use, and other legal/support documents for TurkWave's apps. Built with Jekyll
([just-the-docs](https://github.com/just-the-docs/just-the-docs) theme) and deployed
automatically by GitHub Actions on every push to `main`.

## What's where

- `_docs/` — each app's documents, one folder per app (e.g. `_docs/<app-slug>/`). This is
  where the actual content (privacy policy, terms, etc.) lives.
- `_layouts/` — Jekyll page templates that turn the documents in `_docs/` into site pages.
- `_templates/` — copy-paste starting points for adding a new app or a new document.
- `_config.yml` — site-wide configuration (theme, plugins, URL structure).
- `.github/workflows/` — GitHub Actions workflow that builds and deploys the site.
- `index.md` — the site's home page.

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
| `make install` | `bundle install`                                               |
| `make serve`   | `bundle exec jekyll serve --livereload`                        |
| `make build`   | `JEKYLL_ENV=production bundle exec jekyll build` (matches CI)   |
| `make clean`   | removes `_site` and `.jekyll-cache`                            |
| `make preview` | `install`, then `serve`                                        |

## Live site

https://turkwave.github.io/
