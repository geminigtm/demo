#!/usr/bin/env bash

# Minimal capture helper for demo assets. Run from repo root.
# Keeps all outputs inside demo/ and uses synthetic data only.

set -euo pipefail

echo "Starting demo capture with mock data..."
echo "Reminder: use synthetic data (see mock-data/), hide IDs/URLs, and save images outside this repo (e.g., ../demo-screens/) with the walkthrough naming."
echo
echo "Typical steps:"
echo "1) In another terminal, run: npm run dev"
echo "2) Load the app with mock data and stage each flow per demo/walkthrough.md"
echo "3) Capture screenshots and save as PNG/WebP outside the repo (keep numbering per walkthrough)"
echo "4) Export supporting artifacts (text/CSV/PDF) into artifacts/"
echo
echo "This script does not run the app or modify files; it's a guided checklist."
