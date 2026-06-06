# v2 Product Vision — From "Boring Logger" to "Informative, Engaging Tracker"

Status: product direction for the next iteration after the Phase 0 MVP.
Date: 2026-06-06.
Source inputs:
- `docs/research/peptide-market-and-competitor-analysis.md`
- `docs/product/phase-0-product-decision-memo.md`
- `docs/product/mvp-product-spec.md`
- `docs/compliance/compliance-language-pack.md`

This document keeps every Phase 0 compliance and privacy commitment intact. It
changes *how rich and engaging* the app is, not *what it is allowed to claim*.

## 1. Honest critique of the current MVP

What the MVP does well:
- Clean, compliant framing; privacy-first; no account; fast logging skeleton.

Why it currently feels boring and uninformative (user's words, and correct):
1. **No information layer.** There is nothing to learn or explore. Competitors
   ship compound libraries; we ship a bare form. A tracker with zero reference
   content gives the user no reason to open the app between reminders.
2. **No payoff for logging.** You log an event and… nothing happens. No streak,
   no trend, no recap, no sense of progress. Tracking without feedback is a
   chore, and the data confirms pure trackers churn hard (<10% D90).
3. **The calculator is a dead end.** It is a single formula with a disclaimer,
   not the visual, recipe-saving syringe tool the category expects.
4. **No visual identity for the data.** No weight/measurement trend, no body
   map, no medication-level curve — the exact visuals that make these apps feel
   premium and screenshot-worthy.
5. **One flat audience.** It treats a GLP-1 weight-loss user and a multi-compound
   research/TRT user identically, so neither feels understood.

The fix is not to abandon the calm, compliant positioning — it is to add
**knowledge, feedback, and visual payoff** on top of it.

## 2. North star

> A private, local-first tracker that makes peptide and GLP-1 routines easy to
> understand, easy to keep, and easy to feel good about — built for
> record-keeping and education, not medical advice.

Three words: **Informative. Engaging. Private.**

## 3. The four product pillars

### Pillar 1 — Knowledge (fixes "uninformative")
A neutral, cited **compound library**: what each compound is, how it is reported
in literature/community, typical reconstitution context, half-life/Tmax for the
level curve, and common logging considerations. Strictly educational and
attributed (see compliance rules in the market doc, §7).

Why it matters: it is the reason to open the app when nothing is "due," and it
is a powerful ASO/SEO acquisition surface ("BPC-157 reconstitution," "Mounjaro
tracker," etc.).

### Pillar 2 — Precision (fixes "the calculator is a dead end")
Upgrade the calculator into a **visual reconstitution tool**: visual syringe
draw, forward and reverse calculations, U-100/50/40/30 syringe support, saved
recipes, and per-compound inventory/vial expiry. Still user-input math only.

### Pillar 3 — Habit (fixes "no payoff for logging")
A real habit loop: **streaks, adherence %, milestone celebrations, and a weekly
recap.** Logging produces immediate, visible feedback. This is the retention
engine and stays mostly free on purpose.

### Pillar 4 — Privacy (our wedge)
Keep local-first, no-account, on-device. Make it a *feature we market*, not just
a default. Export is user-initiated; nothing leaves the device silently.

## 4. Headline new features (and why)

| Feature | Pillar | Why it earns its place |
|---|---|---|
| Compound library (neutral, cited) | Knowledge | The missing "informative" layer + acquisition engine |
| Visual reconstitution calculator | Precision | Category table-stakes; turns a dead end into a daily tool |
| Saved recipes + inventory + vial expiry | Precision | "Doses remaining / reorder" is genuinely sticky |
| Injection-site body map (12-site) | Precision | Concrete daily value; prevents lipohypertrophy; screenshot-worthy |
| Medication-level curve (half-life/Tmax) | Knowledge/Precision | The category's signature "wow" visualization |
| Streaks + adherence % | Habit | +15–30% D30 in comparable apps |
| Weekly recap | Habit | Strongest long-term retention driver (progress visibility) |
| Progress tracker (weight/measurements/photos) | Habit | Gives GLP-1 users their core motivation loop |
| Two on-ramps (GLP-1 vs research/TRT) at onboarding | All | Each audience feels the app is "for them" |
| CSV/PDF export ("bring to your provider") | Precision | Clear premium value, compliance-safe framing |

Each feature maps to a Free/Premium boundary in
`docs/research/peptide-market-and-competitor-analysis.md` §6.

## 5. Reworked onboarding (adds a fork, keeps compliance)

Add one lightweight branching step after the safety notice:

```text
What are you tracking?
[ GLP-1 / weight management ]   e.g. Ozempic, Wegovy, Mounjaro, Zepbound
[ Peptides / TRT ]              e.g. BPC-157, TB-500, Ipamorelin, HCG, TRT
[ A bit of both / not sure ]

(You can change this anytime. This only tailors the app — it is not advice.)
```

Effect on the app:
- GLP-1 path emphasizes weight trend, weekly cadence, side-effect log, simple
  level estimate, encouragement.
- Peptide/TRT path emphasizes multi-compound stacks, reconstitution, body map,
  inventory, cycling/titration.
- "Both" shows the union with sensible defaults.

The mandatory safety-notice acceptance and all Phase 0 copy rules are unchanged.

## 6. Today screen, made non-boring

Current Today is a list. v2 Today becomes a calm dashboard with payoff:
1. **Streak + adherence chip** ("12-day streak · 94% this month").
2. Due today / next reminder (existing).
3. **A small trend or level glance** (weight sparkline for GLP-1; medication
   level curve for peptide/TRT).
4. Quick actions (existing).
5. **"Learn" entry point** into the library (one tappable card, rotating topic).
6. Free-tier upgrade card / light banner ad (unchanged placement rules).

This turns Today from "a list of chores" into "a reason to check in."

## 7. Phasing

### Phase A — Make it feel alive (engagement first, low compliance risk)
- Streaks + adherence % + milestone celebrations.
- Weekly recap.
- Progress tracker (weight/measurements) with a simple chart.
- Today dashboard refresh.

Rationale: highest retention ROI, lowest compliance risk, no new medical
content. Ship this first.

### Phase B — Make it informative (the library)
- Neutral, cited compound library with strict compliance review.
- "Learn" surface on Today; deep links from protocols.
- ASO/SEO landing alignment with library topics.

### Phase C — Make it precise (power tooling)
- Visual reconstitution calculator + saved recipes.
- Inventory, vial expiry, reorder alerts.
- 12-site body map with usage history.
- Medication-level curve (half-life/Tmax from library data).
- Advanced schedules (cycling, titration, multiple times/day).

### Phase D — Monetize depth
- Premium packaging + paywall refresh (see engagement/monetization doc).
- CSV/PDF export.
- Remove-ads as a premium bullet.

## 8. What stays out of scope (still)

Unchanged from Phase 0 §15, and reaffirmed:
- No dose or protocol recommendations.
- No AI "what should I take" guidance.
- No diagnosis, efficacy, or outcome claims.
- No prefilled "recommended" defaults in the calculator.
- Cloud sync / accounts remain optional future work, never required for core
  utility.

## 9. Success criteria for v2

v2 is working if:
- A user has a reason to open the app on a non-reminder day (library or recap).
- Logging produces visible feedback within the same session (streak/trend).
- The calculator is used more than once per user (saved recipes signal).
- D30 retention moves toward the 15–25% health-app band, away from bare-tracker
  <10% territory.
- Upgrade intent is driven by depth/insight/ad-removal, never by any implied
  medical benefit.

## 10. Final stance

Keep the calm, private, compliance-clean soul of the Phase 0 MVP. Add the three
things it is missing — **something to learn, a payoff for logging, and visual
proof of progress** — and the app stops being boring without ever becoming a
medical advisor.
