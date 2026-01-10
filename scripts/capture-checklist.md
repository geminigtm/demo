# Capture Checklist (manual)

Use this when updating screenshots. Keep everything offline and synthetic.

1) From repo root, run the app with demo env values (local emulators or a throwaway project), seeded with `mock-data/sample-data.json` or your own fully synthetic dataset.  
2) Confirm auth banners or user avatars are generic (anonymous/demo) and that no IDs/emails are visible.  
3) Navigate through the flows in `walkthrough.md` in order and stage UI states before each capture.  
4) Take screenshots at a consistent resolution; store them outside this folder (numbered per `walkthrough.md`).  
5) Export any supporting text/CSV/PDF outputs to `../artifacts/` and align names with the flows they support.  
6) Spot-check images for URLs, headers, doc IDs, or bucket names; blur or re-capture if anything appears.  
7) Update `walkthrough.md` and `demo/README.md` notes if the flow or assets change so the open demo stays fresh.
