# Public Demo Package

<!-- portfolio-status -->
## Project Status

LaunchKey is preserved as a hackathon case study. The original Firebase deployment has been retired. The architecture and deployment sections document the system built for the event; reproduction requires a new cloud project and new credentials.

This folder is shared openly to explain the cross-border partner-matching experience using synthetic, non-sensitive materials. It contains narrative/context and diagrams only—no code, no sample data, no screenshots, and no other generated artifacts.

## Scenario and feature story
- Audience: German mid-market company expanding into Indonesia.
- Flow: capture company profile → surface ranked partner recommendations with risk/opportunity context → show cultural calibration via outreach drafts and market signals.
- Outcome: readers understand the journey and data expectations without seeing production systems or real entities.

## Product intent and goals
- Capture company profiles from uploads or guided input, enforce eligibility (revenue band, origin/target market), and highlight missing data.
- Discover and ingest leads from uploads or discovery; enrich with verification, cultural context, and regional growth signals.
- Recommend partnerships with compatibility scoring, risk/opportunity analysis, and interactive exploration (list/detail/graph).
- Generate culturally calibrated outreach (multi-draft emails) and track engagement; support sending via trusted providers.
- Orchestrate scheduling and follow-up to move opportunities through a repeatable lifecycle.

## Data to UI mapping (schema-level, no payloads)
- Company profile: name, industry, HQ, revenue band, target market, expansion goals, differentiators. Used to frame the landing/value prop and profile completeness surfaces.
- Leads/recommendations: lead id, company, sector, city, compatibility score, risks, opportunities/signals. Drives the recommendations list/grid, detail view, and network/graph relationships.
- Outreach drafts: lead id, subject, tone, brief summary aligned to cultural context. Appears in multi-draft outreach selections.

## Scope reiteration
- Included: descriptive narrative of flows, high-level data schema expectations, diagrams, license notes for design assets.
- Excluded: app source, prompts, configs, sample data, artifacts, screenshots, or any production identifiers.
- Self-contained: this folder alone is intended for open-source sharing; no external directories are required.
- Bring your own synthetic inputs if you recreate captures; this package does not distribute data or media.

## Architecture snapshot (no code)
- Client/UI: Next.js (App Router) exported statically to CDN/Hosting; fetches dynamic data via `/api/**`.
- API layer: Firebase Functions (Node 20) routing profile ingest, lead upload/discovery, recommendations, outreach drafts, and graph data.
- Services (within Functions):
  - Profile service: normalization, eligibility/completeness checks, persistence.
  - Lead service: upload, discovery hooks, enrichment, legitimacy notes.
  - Matching engine: compatibility scoring, ranking, risk/opportunity analysis.
  - Outreach generator: culturally calibrated drafts via Gemini.
  - Graph service: relationship graph for profile → leads → signals.
- Data plane: Firestore (collections for profiles, leads, matches, outreach drafts, signals); optional Cloud Storage for uploads (not used in demo); telemetry via OpenTelemetry.
- External: Gemini for reasoning/drafting; optional business-directory/news feeds for signals (replaced by synthetic stand-ins in this package).

### System context (components and data stores)
```
End User (browser)
    |
    v
Next.js UI (static on CDN/Hosting)
    |
    v
Firebase Functions (/api/**)
    ├─ Profile svc      ─┐
    ├─ Lead svc         ├─> Firestore: profiles, leads, matches, drafts, signals
    ├─ Matching engine  ┘
    ├─ Outreach gen  ─────> Gemini (drafting/reasoning)
    └─ Graph svc     ─────> Firestore signals; optional ext. signals (news/dirs)
```

### Request/response path (detailed)
```
1) Browser UI -> /api/profile         : Profile svc normalizes, checks completeness, stores profile.
2) Browser UI -> /api/leads           : Lead svc stores uploads or triggers discovery/enrichment.
3) Lead svc -> external (optional)    : Fetches synthetic/placeholder signals; no real PII in demo.
4) Browser UI -> /api/matches         : Matching engine reads profile+leads, scores, ranks, stores matches.
5) Browser UI -> /api/graph           : Graph svc composes profile->lead->signal relationships.
6) Browser UI -> /api/outreach        : Outreach gen fetches match context, calls Gemini, stores drafts.
7) Responses to UI return only demo-safe synthetic representations.
```

### Data relationships (logical, illustrative)
```
profiles (1) ────< leads (many)
   │                │
   │                └──< signals (many per lead)
   │
   └──< matches (many per profile) ───> leads (ref)
                            │
                            └──< outreach_drafts (many per match/lead)
```

## Operational posture (conceptual, no runbooks)
- Hosting/runtime: Next.js static export on Firebase Hosting with CDN; rewrites `/api/**` to the Functions backend.
- Auth: Firebase Auth (anonymous allowed for demos); Functions expect ID token on every call and apply lightweight rate limiting.
- Data handling: Firestore for profiles, leads, matches, outreach drafts, signals; Cloud Storage path `uploads/{userId}/{timestamp}-{filename}` for raw uploads in non-demo setups; Storage trigger (`processUpload`) normalizes uploads into leads.
- Pipelines: UI can request signed upload URLs; Storage trigger fans out CSV/JSON into `leads`, then matching/outreach consume stored leads; optional seed datasets can flow through the same trigger (not distributed here).
- Security: Firestore/Storage rules enforce per-user isolation; Functions perform validation/sanity checks before writes.
- Integrations: Gemini for reasoning/drafting; optional Gmail OAuth/send and external signals (directories/news) when configured—omit in the open demo package.

## Capability coverage (from product requirements)
- Company profile management: ingest, normalize, validate eligibility (revenue band, HQ, target market), surface completeness and confirmation.
- Lead discovery and management: upload targeted contacts, trigger discovery, enrich with signals, legitimacy notes.
- Partner matching: compatibility scoring, ranked recommendations, risk/opportunity analysis, graph visualization of relationships.
- Communication generation: multiple culturally calibrated outreach drafts per lead, editable in the UI.
- Meeting/follow-up (conceptual): scheduling preferences, tracking outcomes, integrating notes back into the system.
- Data intelligence: optional external signals (news, hiring, trade) to refresh recommendations; demo uses synthetic placeholders.
- UX: landing value prop, workflow dashboard, upload paths, recommendation views with filters/sorting, live-assist surfaces (if enabled).

## API and data references (illustrative, no payloads)
- API endpoints (Functions):
  - `POST /api/profile` – create/update profile (normalize, validate).
  - `POST /api/leads` – upload or request discovery/enrichment; attaches signals.
  - `GET /api/matches` – return ranked matches with risk/opportunity.
  - `GET /api/graph` – relationship graph (profile ↔ leads ↔ signals).
  - `GET /api/outreach` – outreach drafts for selected leads/matches.
- Firestore collections (demo-safe logical view):
  - `profiles`: company_name, industry, hq_city/country, revenue_band, target_market, expansion_goals[], differentiators[], status.
  - `leadUploads`: upload metadata, storage path, status for ingestion runs.
  - `leads`: company_name, sector, city, discovery_source, legitimacy_note, signals_ref, contact_stub (no PII in demo).
  - `matches`: profile_ref, lead_ref, compatibility_score, risks[], opportunities[], rank, explanation.
  - `signals`: lead_ref, type (news/hiring/trade), summary, source_hint (no URLs in demo).
  - `outreach_drafts` / `emailDrafts`: lead_ref, subject, tone, summary, cultural_notes, generated_via (Gemini).
  - `gmailTokens` (optional): OAuth tokens for direct send; omit in open demo.

## Configuration considerations (informational, no secrets)
- Client: Firebase Web SDK config (standard public keys) for Hosting/SDK bootstrapping.
- Functions: optional overrides for `FIREBASE_STORAGE_BUCKET`; environment entries for Gmail OAuth (client id/secret/redirect) when enabling sends.
- Secrets handling: store service accounts and OAuth JSON locally (e.g., under `secrets/`) and reference via env vars in non-demo setups; deployed Functions use runtime identity.
- Rules: Firestore/Storage security rules restrict data to the authenticated user; align any demo data with these constraints.

## Flow at a glance
1) User submits company profile (form or upload).  
2) Leads are uploaded or discovered; legitimacy and signals are attached.  
3) Matching engine ranks leads with compatibility + risk/opportunity.  
4) UI surfaces list/grid, detail, and graph views of relationships and signals.  
5) Outreach drafts are generated with cultural calibration for selected leads.  

## Logical data model (illustrative)
- `profiles`: id, company_name, industry, hq_city, hq_country, revenue_band, target_market, expansion_goals[], differentiators[], status.
- `leads`: id, company_name, sector, city, signals[], legitimacy_note, discovery_source, contact stub (no PII in demo).
- `matches`: id, profile_id, lead_id, compatibility_score, risks[], opportunities[], rank, explanation.
- `signals`: id, lead_id, type (news/hiring/trade), summary, source_hint (no URLs in demo).
- `outreach_drafts`: id, lead_id, subject, tone, summary, cultural_notes.

## Included diagrams (local)
- Architecture: `diagrams/svg/architecture.svg` (source: `diagrams/src/architecture.mmd`)
- Request lifecycle: `diagrams/svg/request-lifecycle.svg` (source: `diagrams/src/request-lifecycle.mmd`)
- Lead ingestion: `diagrams/svg/lead-ingestion.svg` (source: `diagrams/src/lead-ingestion.mmd`)
- Outreach flow: `diagrams/svg/outreach-flow.svg` (source: `diagrams/src/outreach-flow.mmd`)
- Firestore ER: `diagrams/svg/firestore-er.svg` (source: `diagrams/src/firestore-er.mmd`)

## Licensing
- All materials in this folder are MIT licensed (see `LICENSE`).
- The rest of the repository follows its own licensing; nothing here grants rights to proprietary code outside this folder.
