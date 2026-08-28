# TurkWave App Legal & Support Documents

Source for `https://turkwave.github.io/` — the privacy policies, terms of use, and other
legal/support documents for every app TurkWave publishes. Built with Jekyll
([just-the-docs](https://github.com/just-the-docs/just-the-docs) theme) and deployed by
GitHub Actions on every push to `main`.

## URL scheme (frozen — do not change)

```
https://turkwave.github.io/apps/<app-slug>/<doc-slug>/
```

Directory-style URLs, no `.html`. These links are pasted into app stores and in-app UIs, so
the scheme is permanent. `<app-slug>` and `<doc-slug>` come mechanically from the file path —
never typed into a link list anywhere.

## How it works

- Every app's documents live under `_docs/<app-slug>/` — a single flat Jekyll collection,
  declared once in `_config.yml` regardless of how many apps exist.
- A file's URL is derived purely from its path: `_docs/acme/privacy.md` → `/apps/acme/privacy/`.
  No front-matter permalink needed on ordinary documents.
- Each app has one `index.md` (front matter only) holding that app's name, contact email, and
  an explicit `permalink: /apps/<slug>/` — the one field that has to be typed once, at
  app-creation time, because Jekyll's collection permalink pattern can't turn an `index.md`
  into a clean `/apps/<slug>/` URL any other way. It never needs editing again.
- The root page and every app's index page are **generated** by Liquid loops in
  `_layouts/home-apps.html` and `_layouts/app-index.html` — they read the `docs` collection at
  build time. Nothing to hand-edit when you add an app or a document.
- Each document's layout (`_layouts/legal-doc.html`) looks up its app's name and contact email
  from that app's `index.md` by matching folder → URL — so app metadata lives in exactly one
  file and every document under it inherits it automatically.

## Add a new app

1. Copy `_templates/new-app/` to `_docs/<your-app-slug>/`.
2. Edit `_docs/<your-app-slug>/index.md`: set `permalink: /apps/<your-app-slug>/` (must match
   the folder name), `app_name`, and `contact_email`.
3. Edit `privacy.md` and `terms.md` inside that folder: set `title` (if different),
   `effective_date`, `last_updated`, and write the actual content.
4. Commit and push. The app appears on the root page and its two documents are live at
   `/apps/<your-app-slug>/privacy/` and `/apps/<your-app-slug>/terms/` — no other file touched.

## Add a new document to an existing app

1. Copy `_templates/new-doc.md` to `_docs/<app-slug>/<doc-slug>.md` (e.g. `eula.md`,
   `data-deletion.md`).
2. Edit its front matter (`title`, `effective_date`, `last_updated`) and write the content.
3. Commit and push. It appears automatically in that app's document list at
   `/apps/<app-slug>/<doc-slug>/` — no other file touched.

## Move or rename a document

Renaming a file changes its URL, which would break an already-published link. Keep the old
URL alive with `redirect_from`:

```yaml
---
title: Privacy Policy
effective_date: 2026-01-01
last_updated: 2026-01-01
redirect_from:
  - /apps/<app-slug>/<old-doc-slug>/
---
```

The old URL becomes a redirect stub pointing at the new one instead of 404ing.

## Local preview

This repo has no committed `Gemfile.lock` — GitHub Actions resolves gem versions fresh on
each run (see "Deployment" below), so there's nothing checked in to go stale. To preview
locally, install Ruby + Bundler, then from the repo root:

```sh
bundle install
bundle exec jekyll serve
```

Open `http://localhost:4000/`.

## Deployment

`.github/workflows/pages.yml` builds the site with `ruby/setup-ruby` + `bundle exec jekyll
build` (not the classic GitHub Pages gem whitelist, so any theme/plugin in the `Gemfile`
works) and deploys via `actions/deploy-pages` on every push to `main`. GitHub Pages must be
set to "GitHub Actions" as its build source (Settings → Pages → Build and deployment) — this
repo already has that set.
