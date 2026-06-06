# Engagement & Monetization Strategy

Status: strategy for retention loops, ads, and premium packaging.
Date: 2026-06-06.
Source inputs:
- `docs/research/peptide-market-and-competitor-analysis.md`
- `docs/product/v2-product-vision.md`
- `docs/product/phase-0-product-decision-memo.md`
- `docs/compliance/compliance-language-pack.md`

Core thesis: **retention first, monetization second.** In this category, a bare
tracker churns below ~10% by D90; the apps that monetize are the ones that build
a habit. We earn the right to charge by being genuinely sticky and useful, and
we never tie any paid value to medical benefit.

## 1. The retention problem we are solving

- Health/fitness D1 retention averages ~20–30%; D30 ~15–25% for good apps,
  ~5–10% for the median; pure passive trackers fall below ~10% at D90.
- The drug-side reality (GLP-1 6-month discontinuation often >50%) means the
  user's motivation naturally decays — the app has to supply the missing
  consistency.
- Two retention multipliers are well documented:
  - **Gamification** (streaks, badges, milestones): +15–30% D30.
  - **Progress visibility** (weekly recap, trends): the strongest *long-term*
    driver.

## 2. The three habit loops

### Daily loop (sub-60-second completion)
Trigger → tiny action → immediate reward.
- Trigger: reminder notification for a routine the user created.
- Action: one-tap log (Done/Skipped) from Today or the notification.
- Reward: streak increments, adherence % updates, Today trend refreshes.

Design rules: common-case log in under 10 seconds; the reward must be *visible
in the same session* (animate the streak, update the chip).

### Weekly loop (progress visibility)
Every 7 days, a **recap** the user actually wants to open:
- "You logged 6 of 7 planned routines this week — 12-day streak."
- Neutral trend glance: weight sparkline (GLP-1) or logged-dose timeline
  (peptide/TRT). Strictly the user's own entered data, no interpretation that
  implies outcome quality.
- One celebration if a milestone was hit.

Compliance note: the recap reports *what the user did and entered*. It must not
say things like "great progress, your treatment is working." Allowed: "You kept
a 4-week logging streak." Forbidden: outcome/efficacy framing.

### Milestone loop (emotional investment)
Celebrate logging/consistency milestones, not health outcomes:
- 7 / 30 / 90 consecutive days of on-schedule logging.
- "First full month tracked." "Inventory never ran out this cycle."
- A small, shareable card (user-initiated share only; no personal data in the
  default share image).

## 3. Gamification design (compliance-safe)

| Element | What it rewards | Compliance guard |
|---|---|---|
| Streak counter | On-schedule logging consistency | Counts user actions, not health results |
| Adherence % | Logged vs planned routines | "Planned" = the user's own schedule, never an app recommendation |
| Milestone badges | Tracking consistency milestones | No "health achievement" or outcome badges |
| Weekly recap | Showing up + entered trends | Reports activity; no efficacy/optimization language |

Explicitly **not** doing: leaderboards or public competition (privacy-first
stance and a sensitive category make social ranking a poor fit for v1).

## 4. Notifications that help, not nag

- Reminder notifications use protocol labels only (Phase 0 rule, unchanged).
- Add gentle, non-medical re-engagement nudges, capped and easy to disable:
  - "Your 9-day streak is waiting — log today's routine."
  - Weekly: "Your recap is ready."
- Never imply medical urgency or consequence ("you missed your dose, your
  results will suffer" is forbidden). Frame around the user's own tracking goal.

## 5. Ads strategy

Position: ads are a **revenue floor and an upgrade lever**, not the core model.

- Free tier shows light banner ads only on non-sensitive screens: Today (below
  recent activity), Calculator (below result), History (below the list).
- **Never** on: onboarding, safety notice, calculator result reveal moment, body
  map, weekly recap, paywall, or any compliance-heavy surface.
- "Remove ads" is one bullet of the premium upgrade — a concrete, honest reason
  to pay that requires no medical claim.
- Data-safety: if ad/analytics SDKs are present, disclose them accurately in the
  Play Data safety form; do not claim "no data collected" unless verified.

Why not ads-first: session volume on a tracker is too low for ads to be the
primary business, and an ads-heavy free experience would undercut the
privacy-first wedge that differentiates us.

## 6. Premium packaging

Single guiding rule: **premium sells organization depth, precision, and insight
into your own data — never better health outcomes.**

### Recommended tiers
- **Free** — genuinely useful forever:
  - 1–2 active protocols/compounds
  - fast logging, today/upcoming, history
  - basic reconstitution calculator
  - streaks + adherence + basic weekly recap (the habit loop stays free)
  - library browsing
  - light banner ads
- **Premium (subscription)** — the depth bundle:
  - unlimited protocols/compounds
  - visual reconstitution calculator + saved recipes
  - inventory, vial expiry, reorder alerts
  - 12-site body map with history
  - medication-level curve
  - full progress charts (weight/measurements/photos)
  - advanced schedules (cycling, titration, multiple/day)
  - rich shareable weekly recap
  - CSV/PDF export
  - no ads

### Pricing hypothesis (validate, don't hard-code)
- Anchor to the category: competitors sit around **$9.99/mo** and
  **~$39.99–59.99/yr**.
- Start hypothesis: **$8.99/mo** and **$44.99/yr** (annual ~58% off monthly to
  push the high-retention annual plan), plus consider a **one-time "Pro unlock"**
  for the privacy-minded user who dislikes subscriptions.
- Annual plans show the best retention (~33% YoY in comparable data) and ~72%
  annual retention when purchased in the first 30 days — so surface annual as
  the default, and make first-week upgrade easy.

### Trial / paywall approach
- Freemium with a soft, contextual paywall (not a hard wall at install). The
  niche skews toward "prove value first."
- Trigger the paywall on: hitting the protocol limit, opening a premium feature
  (body map, level curve, export), and a gentle post-value nudge after repeated
  use — never on first launch.
- Always include "Restore purchases." Paywall copy follows the compliance pack
  (convenience/organization/insight only).

## 7. Metrics & guardrails

Track cohort-based, not averages:
- **Activation:** % reaching Today with ≥1 protocol < 2 min (Phase 0 target).
- **Habit:** D1 / D7 / D30 retention; DAU/MAU; streak length distribution;
  % of logs completed in < 10s.
- **Information value:** library opens per user; library → calculator/protocol
  conversion.
- **Monetization:** free→paid conversion; annual vs monthly mix; ad ARPU on
  free; LTV:CAC (target ≥3:1, ideally 4:1).
- **Health of the wedge:** uninstall reasons, data-safety complaints (should be
  near zero given local-first).

Guardrail metric: if any growth/monetization experiment requires copy that fails
the Phase 0 review checklist, it does not ship — regardless of conversion lift.

## 8. Sequencing (matches v2 phasing)

1. **Phase A (engagement):** streaks, adherence, weekly recap, progress chart,
   Today refresh. Cheapest, safest, biggest retention win. Ship first.
2. **Phase B (library):** acquisition + "informative" payoff.
3. **Phase C (precision tooling):** the premium feature surface.
4. **Phase D (monetize):** paywall refresh, export, remove-ads, pricing tests.

Do not flip on aggressive monetization before Phase A retention is proven —
charging for a still-boring app is the fastest way to bad reviews and churn.

## 9. One-paragraph summary

This is a strong, fast-growing niche, but it rewards **stickiness and trust**,
not ads volume. Build the habit loop and the information layer first so people
keep showing up; monetize with a subscription that unlocks precision tooling and
insight into the user's own data; keep ads as a light free-tier floor and an
"upgrade to remove" lever; and never let any paid or growth surface drift into
medical-benefit claims.
