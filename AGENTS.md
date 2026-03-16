# Repository Guidelines

## Project Structure & Module Organization
- Source pages live in `index.md`, `press/`, `support/`, `contact/`, and `privacy/`; each uses Jekyll front matter for titles and layout selection.
- Layouts and partials are in `_layouts/` and `_includes/` and control repeated chrome (navigation, footer, SEO tags).
- Authoring assets live in `_assets/` (`stylesheets/`, `images/`, `javascripts/`); build output is written to `assets/`.
- `_config.yml` holds site metadata and configuration; `_vendor/` contains third-party JS copied during builds.

## Build, Test, and Development Commands
- Prereqs: `jekyll`, `sass`, and `rsync` available on PATH (install via `gem install jekyll sass` and your OS package manager for rsync).
- `rake` or `rake serve`: watches SCSS and runs `jekyll serve --watch` for local development at http://localhost:4000.
- `rake build`: compiles SCSS to `assets/application.css`, syncs assets, and produces the static site in `_site/`.
- `rake clean`: removes `_site/` and `assets/` to reset build artifacts.
- If you prefer, run the underlying tools directly: `scss _assets/stylesheets/application.scss:assets/application.css` then `jekyll build`.

## Coding Style & Naming Conventions
- Use two-space indentation for Ruby, SCSS, and Markdown/HTML; keep lines wrapped reasonably (≈100 chars) for readability.
- Name assets with hyphenated, descriptive filenames (e.g., `_assets/images/hero-banner.png`, `_assets/javascripts/analytics.js`).
- SCSS variables live in `_assets/stylesheets/globals/variables.scss`; prefer variables over hard-coded colors or spacing.
- Keep Liquid templates small and reusable via `_includes/`; pass data through front matter rather than hardcoding text in layouts.

## Testing Guidelines
- There is no automated test suite; treat `rake build` as the primary guardrail—fix warnings and ensure a clean build.
- Manually verify key pages (home, press, support, contact, privacy) in a browser after changes, including mobile viewport checks.
- For asset changes, confirm generated files appear in `assets/` and that image paths resolve after `rake build`.

## Commit & Pull Request Guidelines
- Follow the existing short, imperative commit style (e.g., `Fix typo`, `Update FAQ`); group related edits per commit.
- For PRs, include: a brief summary of the change, any related issue links, steps to reproduce and verify, and screenshots/GIFs for visual updates.
- Note any dependency or configuration changes (e.g., new gems) so reviewers can rebuild locally; mention if cache or `_site/` needs cleaning.
