# Public Demo Package

This folder is meant to be shared openly: it showcases the product experience using synthetic data and non-sensitive assets, with zero reliance on proprietary code or prompts.

## Scope and contents
- `walkthrough.md` – narrative tour of the product flows.
- `mock-data/` – clearly fake sample data to stage the UI for captures.
- `artifacts/` – generated, non-sensitive outputs (e.g., sample email drafts as text).
- `scripts/` – capture playbooks/checklists; no build or source code.

## Principles
- Keep everything community-friendly: synthetic data, clean visuals, and no secrets or IDs.
- Keep it focused: no source files (`.ts`, `.tsx`, `.js`), configs, or compiled assets here.
- Keep it self-contained: pointers to the main repo are fine; duplication of code is not needed.

## How to update the demo
1) Run the app with synthetic data from `mock-data/` (or add your own fully fake data).  
2) Capture the flows in `walkthrough.md`; store images outside this repo (e.g., `../demo-screens/`) and keep filenames numbered to match the steps.  
3) Add any supporting outputs (draft text, compatibility tables) to `artifacts/`.  
4) Spot-check captures for URLs/IDs/headers before publishing them elsewhere.  
5) Refresh `walkthrough.md` to match the latest story.

## Licensing note
Demo assets are licensed under CC BY-NC-SA 4.0 (see `LICENSE`) to encourage sharing and remixing while keeping the visuals non-commercial. This applies **only** to `demo/` and not to the proprietary codebase. If you add code snippets later, you can layer MIT on those snippets while keeping CC BY-NC-SA for media.
