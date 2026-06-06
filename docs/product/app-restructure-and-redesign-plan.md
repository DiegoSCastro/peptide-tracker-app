# App Restructure & Redesign Plan

Status: implementation-ready plan for the v2 navigation, visual system, and the
three missing product pillars.
Date: 2026-06-06.
Source inputs:
- `docs/product/v2-product-vision.md`
- `docs/product/engagement-and-monetization-strategy.md`
- `docs/research/peptide-market-and-competitor-analysis.md`
- `docs/product/mvp-product-spec.md`
- `docs/compliance/compliance-language-pack.md`
- Current code: `lib/src/features/shell/presentation/view/app_shell.dart`,
  `lib/app/app.dart`, `lib/src/features/peptides/*`

This plan keeps every Phase 0 compliance/privacy commitment. It changes
structure, visuals, and feature depth — not what the app is allowed to claim.

---

## Part 1 — Navigation restructuring

### 1.1 Current state

Bottom `NavigationBar` with 5 destinations in an `IndexedStack`:
`Today · Protocols · Calculator · History · Settings`.

Problems:
- **Settings** is low-frequency but eats a permanent slot.
- **History** is medium-frequency and overlaps with Today's "recent activity";
  as a flat list it has no payoff.
- Two of the three missing pillars (Library, Progress/visuals) have **nowhere to
  live** because the nav is full.

### 1.2 Principle

Bottom nav slots are the most valuable real estate in the app. Reserve them for
**high-frequency, forward-looking surfaces**. Push low-frequency utilities
(Settings) to an app-bar affordance, and fold passive lists (History) into a
richer destination that gives them meaning (Progress).

### 1.3 Recommended structure (primary)

5 destinations, all high-value, plus a docked center **Log** action:

```text
[ Today ] [ Protocols ] ( + Log ) [ Library ] [ Progress ]
                  Settings → gear icon in the Today app bar
                  Calculator → reachable contextually (see 1.5)
```

| Slot | Destination | Replaces / role |
|---|---|---|
| 1 | **Today** | Home: streak, due/upcoming, trend glance, "Learn" card |
| 2 | **Protocols** | Manage routines/compounds (+ entry to Calculator) |
| — | **Log (center FAB)** | One-tap quick log from anywhere |
| 3 | **Library** | NEW — the knowledge pillar |
| 4 | **Progress** | NEW — History + trends + adherence + weekly recap |

Moves:
- **History → folded into Progress** as its "Timeline" tab.
- **Settings → gear icon** in the Today (and Progress) app bar; opens a pushed
  route, not a tab.
- **Calculator → contextual** (quick action + Protocol editor + Library compound
  detail), with an optional "Tools" entry. See 1.5 for the trade-off.

Why this works:
- Every permanent slot is now a place users *want* to return to.
- The two new pillars get prime placement.
- The habit loop (streak/recap) is visible on the home surface, not buried.

### 1.4 Alternative structure (if Calculator must stay a tab)

Keep Calculator visible as a tab and drop the center Log FAB (Log stays a quick
action on Today/Progress):

```text
[ Today ] [ Protocols ] [ Calculator ] [ Library ] [ Progress ]
                  Settings → gear icon · History → inside Progress
```

Trade-off: more discoverable Calculator (a top search intent), but loses the
always-available center Log button. **Recommendation: ship the primary
structure (1.3); Calculator discoverability is preserved via contextual entries
and the Library, and reconstitution is most needed *while editing a compound*
anyway.**

### 1.5 Calculator placement detail

Calculator is a *tool*, not a *destination*. Surface it where intent occurs:
- Today → quick action "Calculator".
- Protocol create/edit → "Calculate dose volume" inline.
- Library compound detail → "Open in calculator" (no prefilled recommendation;
  user still enters values).
- Optional: a small "Tools" group on Progress or behind the gear.

This keeps the niche's signature tool one tap from where it is used, without
spending a nav slot on a screen people open occasionally.

### 1.6 Settings as a pushed route

- Gear icon (top-right) on Today and Progress app bars.
- Pushes `/settings` (full screen, back navigation), not part of `IndexedStack`.
- Contents unchanged from MVP spec (upgrade, notifications, legal/safety,
  privacy, about) — only the entry point moves.

### 1.7 Resulting route map

```text
Main shell (IndexedStack of 4 + center Log)
├── Today          (gear → /settings)
├── Protocols
│   ├── Protocol detail
│   ├── Create/Edit  (→ inline Calculator)
│   └── Free-tier intercept → Paywall
├── Library                         (NEW)
│   ├── Compound list / search / filter
│   └── Compound detail (→ Calculator, → add to protocol)
└── Progress                        (NEW; absorbs History)
    ├── Overview (trends, adherence, weekly recap)
    └── Timeline (former History list + filters)

Overlays / pushed routes
├── Quick log sheet (center Log)
├── /settings  (+ legal/safety, privacy, about)
├── /calculator (contextual)
├── Paywall
└── Permission prompts
```

### 1.8 Code impact (shell)

- `_AppShellState`: reduce `destinations`/`pages` to 4; add a docked
  `FloatingActionButton` (center Log) with
  `floatingActionButtonLocation: centerDocked` and a `NavigationBar` (or
  `BottomAppBar` with a notch).
- Replace `onOpenHistory`/`_selectedIndex = 3` wiring with navigation to the
  Progress destination (Timeline tab).
- Extract `_HistoryPage` body into `ProgressPage`'s "Timeline" tab; build a new
  "Overview" tab.
- Add `LibraryPage` (reuse the existing `peptides` feature as the seed; see
  Part 3.1).
- Settings becomes a pushed route via the gear `IconButton`.
- Keep `IndexedStack` to preserve per-tab scroll/state.

---

## Part 2 — Visual redesign (modern, clean, calm)

Goal: make the app feel like a polished 2026 health utility — calm, confident,
data-forward — while staying compliance-clean (no clinical/marketing imagery).

### 2.1 Design direction

- **Mood:** calm, precise, trustworthy. "A quiet instrument," not a hype app.
- **Surfaces:** layered dark by default with a true light theme; soft tonal
  cards, generous spacing, rounded geometry.
- **Data-forward:** charts, rings, and sparklines are first-class, not
  afterthoughts. Color encodes meaning (streak, due, adherence).
- **Motion:** subtle, purposeful (streak count-up, card press, sheet spring).

### 2.2 Design tokens

Create `lib/src/core/design/` with a single source of truth:

```text
core/design/
├── app_colors.dart       semantic color roles (light + dark)
├── app_typography.dart   type scale
├── app_spacing.dart      4/8/12/16/20/24/32 scale + radii
├── app_theme.dart        ThemeData light/dark from tokens
└── app_motion.dart       durations + curves
```

Color system (refine the current navy + electric blue):
- Keep brand seed `#2E5BFF`; derive a full M3 `ColorScheme` for light & dark.
- Add **semantic roles** beyond M3: `success/streak` (warm green/teal),
  `dueNow` (amber), `skipped` (muted), `caution` (existing secondary).
- Backgrounds: dark base near `#0B1020` with elevated surfaces stepped by tonal
  overlay; light theme on soft off-white `#F7F8FB`.
- Charts get a dedicated, color-blind-safe categorical palette for dose-coding.

Typography:
- Adopt a clean variable font (e.g. Inter/`Geist`) via `google_fonts` or bundled
  asset; define display/headline/title/body/label scale with tight headline
  spacing and comfortable body line-height.

Shape & spacing:
- Radii: cards 20, sheets 28, chips/pills full; controls 12.
- Spacing scale 4→32; default screen padding 16/20.

### 2.3 Theming

- Implement **light + dark + system** (currently dark-only). Add a theme-mode
  setting (Settings → Appearance).
- Drive everything from tokens; remove inline `Color(...)` literals from feature
  widgets (e.g. `app.dart` hard-codes the seed/background today).

### 2.4 Component library

Create `lib/src/core/widgets/` (or `core/design/components/`):

| Component | Use |
|---|---|
| `AppScaffold` | Consistent app bar (large title + gear), padding, ad slot |
| `SectionHeader` | Title + optional action ("See all") |
| `StatChip` | Compact metric (replaces `_DashboardStatChip`) |
| `StreakRing` | Circular progress ring with count-up animation |
| `TrendSparkline` | Tiny inline line chart (weight / activity) |
| `LevelCurveChart` | Medication-level curve (half-life/Tmax) |
| `BodyMap` | 12-site injection map with usage heat |
| `SyringeVisual` | Visual draw indicator for the calculator |
| `AppCard` | Tonal/elevated card with consistent radius/press state |
| `EmptyState` | Icon + title + body + CTA (unify all empty states) |
| `DisclaimerBanner` | Standard compliance line (calculator, library) |
| `PrimarySheet` | Rounded bottom sheet base (quick log, filters) |

Charts: add a dependency such as `fl_chart` for sparkline / level curve /
progress charts.

### 2.5 Screen-level visual upgrades

- **Today:** hero "status" header (date + streak ring + adherence), due/upcoming
  cards, trend glance, rotating "Learn" card, calm ad slot at the very bottom.
- **Protocols:** richer cards (cadence chip, reminder status, last-logged, next
  reminder), grouped Active/Inactive, clear free-tier card.
- **Calculator:** `SyringeVisual` + forward/reverse, saved recipes list,
  persistent `DisclaimerBanner`.
- **Library:** searchable grid/list of compound cards with category color
  coding; detail page with sections + sources + disclaimer.
- **Progress:** Overview (charts + adherence + recap) and Timeline (grouped-by-
  day history with status chips).

### 2.6 Accessibility & polish

- Min 4.5:1 contrast on text; 48dp tap targets; semantic labels on charts/rings.
- Respect reduced-motion; provide text alternatives to color-coded data.
- Empty/loading/error states for every async surface (consistent `EmptyState`).

---

## Part 3 — The three missing pillars

Maps directly to the v2 vision (Knowledge, Habit, Visual identity / Precision).

### 3.1 Pillar A — Knowledge: the Library (fixes "uninformative")

What: a neutral, **cited** compound reference. The existing `peptides` feature
already models this shape (`category`, `name`, `summary`, `highlights`,
`caution`) — promote it from the old starter home into the real **Library** tab.

Scope:
- Compound list with search + category filter (GLP-1 / Peptide / TRT / Other).
- Compound detail: what it is, how it's *reported* in literature/community
  (clearly attributed), reconstitution context, half-life/Tmax (feeds the level
  curve), logging considerations, **sources**, standard disclaimer.
- Cross-links: "Open in calculator" and "Add to a protocol" (no prefilled
  recommended dose).

Data/architecture:
- Extend the `peptides` domain into a `library` feature
  (`features/library/...`): `CompoundInfo` entity (id, name, category, summary,
  bullets, half-life, tmax, sources, disclaimer).
- Ship content as a **bundled local JSON asset** (local-first, no network
  needed); allow future remote-config refresh without an app update.
- Reuse `PeptidesCubit` pattern for load/success/failure states.

Compliance (hard rules, from market doc §7):
- Educational and attributed only; never "you should take" / "recommended dose".
- Ranges only as *reported*, clearly sourced, never app-endorsed defaults.
- Every entry carries the informational-only line; re-run Phase 0 checklist.

Why it matters: the reason to open the app on a non-reminder day, plus the
ASO/SEO acquisition surface.

### 3.2 Pillar B — Habit: payoff for logging (fixes "no payoff")

What: make logging produce immediate, visible feedback. (Stays mostly free — it
is the retention engine.)

Surfaces:
- **Today status header:** `StreakRing` (consecutive on-schedule days) +
  adherence % chip, animated on log.
- **Milestone celebrations:** 7/30/90-day logging streaks, "first full month."
- **Weekly recap:** in Progress → Overview ("You logged 6 of 7 planned routines
  · 12-day streak"), optionally shareable (user-initiated, no PII by default).

Data/architecture:
- New `features/engagement/` (or `core/engagement/`): pure functions to compute
  streak length, adherence % (logged vs planned in window), and milestone state
  from existing `LogEntry` + `Protocol` schedule data — **derived, not a new
  source of truth** where possible.
- Persist lightweight counters (current streak, longest streak, last-celebrated
  milestone) in a small settings/store table.
- Add gentle, capped, disable-able re-engagement notifications (streak reminder,
  "recap ready") — non-medical framing only.

Compliance:
- Reward **user actions** (logging consistency), never health outcomes.
- "Planned" = the user's own schedule, never an app recommendation.
- No leaderboards / public ranking (privacy + sensitive category).

### 3.3 Pillar C — Visual identity for data + precision tooling (fixes "no visual payoff")

What: the signature visuals that make the category feel premium.

Surfaces:
- **Progress → Overview:** weight/measurement `TrendSparkline` + full chart;
  adherence chart; recap. Progress entries are user-entered, neutral.
- **Medication-level curve** (`LevelCurveChart`): from logged doses + library
  half-life/Tmax (one-compartment decay sum). Premium.
- **Body map** (`BodyMap`): 12-site injection rotation with usage history /
  "needs rest" hint. Premium (free shows last-site hint).
- **Visual reconstitution calculator** (`SyringeVisual`): forward/reverse, saved
  recipes; **inventory & vial expiry** with doses-remaining / reorder. Premium
  depth, basic calc stays free.

Data/architecture:
- `features/progress/`: `ProgressEntry` (date, type weight/measurement/note,
  value, unit) in a new Drift table.
- `features/inventory/`: `Vial`/`Recipe` entities (compound, concentration,
  volume, doses remaining, expiry).
- Injection site: add optional `site` field to `LogEntry` (DB migration, bump
  `schemaVersion`).
- Charts via `fl_chart`; all curves carry a "based on your entries / reported
  values" note.

Compliance:
- Level curve is an **estimate from user-entered logs and reported half-lives**,
  labeled as such — not a dosing instruction.
- No "optimal site" / "optimize your levels" language; describe rotation as
  user-managed.

### 3.4 Free vs Premium mapping (consistent with research doc §6)

| Capability | Free | Premium |
|---|---|---|
| Library browsing | ✅ | ✅ full detail + add to protocol |
| Streaks + adherence + basic recap | ✅ | ✅ + advanced insights |
| Basic reconstitution calc | ✅ | Visual + saved recipes |
| Inventory / vial expiry | Locked | ✅ |
| Body map | Last-site hint | ✅ full + history |
| Level curve | Locked | ✅ |
| Progress charts | Limited entries | ✅ full |
| CSV/PDF export | Locked | ✅ |
| Ads | Light banners | Removed |

---

## Part 4 — Architecture & data summary

New / changed feature modules (clean architecture, mirrors existing layering):

```text
lib/src/
├── core/
│   ├── design/         tokens + theme + motion (NEW)
│   ├── widgets/        shared components (NEW)
│   └── engagement/     streak/adherence/milestone logic (NEW)
└── features/
    ├── library/        promoted from `peptides` (NEW surface)
    ├── progress/       progress entries + charts (NEW)
    ├── inventory/      vials + recipes (NEW)
    ├── history/        absorbed into Progress → Timeline
    ├── shell/          new 4-tab + center Log nav
    └── settings/       pushed route (extracted from shell)
```

Persistence (Drift) changes:
- New tables: `ProgressEntriesTable`, `VialsTable`/`RecipesTable`,
  `EngagementCountersTable`.
- Alter `LogEntriesTable`: add nullable `site`.
- Bump `schemaVersion` and add migration steps (current is v2).
- Bundle `assets/library/compounds.json` for offline Library content.

Dependencies to add: `fl_chart` (charts), `google_fonts` or bundled font.
Keep everything local-first; no account/cloud required.

---

## Part 5 — Sequencing (aligned with v2 phasing)

1. **Phase 0 (foundation):** design tokens + theme (light/dark) + component
   library + nav restructure (4 tabs + center Log, Settings→gear,
   History→Progress Timeline). Low risk, unblocks everything.
2. **Phase A (Habit):** streak/adherence/milestones + weekly recap + Today
   status header. Highest retention ROI, lowest compliance risk. Ship first
   after foundation.
3. **Phase B (Knowledge):** promote `peptides` → Library with cited content +
   compliance review.
4. **Phase C (Precision/visuals):** visual calculator + saved recipes +
   inventory + body map + level curve + progress charts.
5. **Phase D (Monetize):** paywall refresh, export, remove-ads, pricing tests.

Do not gate the habit loop or ship monetization before Phase A retention is
proven.

---

## Part 6 — Compliance guardrails (unchanged, reaffirmed)

- No dose/protocol recommendations; calculator is user-input math only.
- Library is educational + attributed; no endorsed defaults.
- Engagement rewards user actions, not health outcomes; no efficacy/optimization
  language anywhere.
- Ads stay off sensitive surfaces (onboarding, safety, calculator result, body
  map, recap, paywall).
- Re-run the Phase 0 review checklist on all new copy and UI before shipping.

---

## Part 7 — Definition of done for the restructure

- Bottom nav has 4 forward-looking destinations + center Log; Settings is a gear
  route; History lives in Progress.
- The app has a token-driven theme with working light/dark and a reusable
  component set; no hard-coded colors in feature widgets.
- A user can: learn something in Library, see a streak/recap payoff after
  logging, and view at least one data visualization (trend or level curve).
- Free remains genuinely useful; premium sells depth/precision/insight only.
- All new surfaces pass the compliance checklist.
