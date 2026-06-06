# Peptide Market & Competitor Analysis

Status: research input for the v2 product direction.
Date: 2026-06-06.
Purpose: decide whether this is a good niche, who we compete with, and where the
free/ads vs premium line should sit. Feeds `docs/product/v2-product-vision.md`
and `docs/product/engagement-and-monetization-strategy.md`.

All claims here are market context, not medical guidance. The product
compliance posture in `docs/compliance/compliance-language-pack.md` still wins
any conflict.

## 1. Executive summary

- The niche is real and growing fast, but our current MVP is positioned as the
  *thinnest possible* version of it: a private logger with a calculator. That is
  why it reads as "boring and uninformative."
- There are **two distinct audiences** hiding under "peptide tracker," and they
  want different things:
  1. **GLP-1 / weight-management users** (Ozempic, Wegovy, Mounjaro, Zepbound).
     Mainstream, large, motivated by weight trends and side-effect management.
  2. **Research-peptide / TRT users** (BPC-157, TB-500, Ipamorelin, HCG,
     testosterone). Smaller, more technical, run complex multi-compound stacks,
     and have a high willingness to pay for precision tooling.
- Competitors already win on **information** (compound libraries), **precision**
  (reconstitution + medication-level curves + body maps), and **engagement**
  (streaks, charts, weekly recaps). We currently ship none of those.
- **Verdict on monetization:** this is a *subscription-led* niche, not an
  ads-led one. Ads should be a secondary, low-friction floor on the free tier.
  The premium upgrade should sell **organization depth, precision tooling, and
  insight into your own data** — never better health outcomes.

## 2. Market sizing and trend

Context numbers from Q4 2025 / Q1 2026 third-party market research:

| Signal | Value | Why it matters |
|---|---|---|
| GLP-1 adherence & support platform market (2025) | ~$2.6B | The companion-app space around these drugs is already a real market. |
| Forecast (2034) | ~$14.8B–$20.1B | Strong multi-year tailwind. |
| CAGR (2026–2034) | ~27.4% | Faster than most consumer-app categories. |
| Active US GLP-1 prescriptions (2025) | 9M+ (3x since 2021) | Huge, still-expanding top of funnel. |
| 6-month discontinuation rate | often >50% | Adherence is the core unsolved problem — and a tracker's reason to exist. |
| North America share of the market (2025) | ~47.8% | English-first, US-first go-to-market is defensible. |

Takeaways:
- The **drug wave creates the app wave.** Every new prescription is a potential
  user who needs to remember a weekly shot, rotate sites, and watch a trend.
- The **>50% discontinuation rate** is the single most important product fact:
  the job-to-be-done is "help me stay consistent and feel in control," which is
  exactly what habit loops and progress visibility address.
- The research-peptide / TRT segment is not in these headline numbers but is
  visibly monetizing (multiple paid apps, spreadsheets-to-app migration,
  "I invest real money in my protocol and demand precision" positioning).

## 3. Audience segments

### Segment A — GLP-1 / weight management (volume)
- Drivers: weight-loss journey, weekly injection cadence, side effects (nausea,
  fatigue), "did I take my shot this week?" anxiety.
- Wants: dose reminders, weight trend chart, side-effect log, injection-site
  rotation, simple "estimated level in system" visualization, encouragement.
- Pays for: charts, health-app sync, exports, ad removal, polish.
- Risk: most price-sensitive; churns when weight plateaus or they stop the drug.

### Segment B — Research peptides / TRT (value)
- Drivers: multi-compound stacks (e.g. BPC-157 daily + TB-500 twice weekly),
  reconstitution math, cycling/titration, lab/bloodwork correlation.
- Wants: precise reconstitution calculator with visual syringe, multi-compound
  scheduling, inventory & vial expiry, 12-site body map, medication-level
  curves, neutral compound reference.
- Pays for: precision and "stop managing this in a spreadsheet." Highest LTV.
- Risk: smaller TAM; more compliance-sensitive language; needs accuracy trust.

Strategic implication: **lead acquisition with GLP-1 (broad search intent),
monetize depth with the research/TRT feature set.** One app, two on-ramps.

## 4. Competitor teardown

| App | Positioning | Notable features | Monetization |
|---|---|---|---|
| **Shotsy** | "The" GLP-1 tracker | Dose-coded weight charts, estimated medication-level charts, injection-site stats, side-effect correlation, home-screen widgets, PDF export, 17 languages | Free tier; Pro ~$9.99/mo or ~$39.99–59.99/yr |
| **Regimen** | Multi-compound peptide stacks | Independent schedules per compound, vial expiry reminders, reconstitution calculator, medication-level curves, education content/SEO | Freemium |
| **Dose Track** | "Pharmacokinetic-grade" tracker | 600+ compound DB with half-life/Tmax, real-time level curves, site rotation, lab parsing, smart reconstitution | Freemium, cross-platform sync on Pro |
| **PepBuddy** | Recovery/performance + GLP-1 | 60+ citation-backed compound library, multi-dose/day, inventory + reorder alerts, syringe visualization | Free tier (2 compounds), paid upgrade |
| **Titer** | Peptide + TRT + HCG stacks | Visual syringe with saved recipes, forward/reverse calc, 12-site body map with usage history, inventory stock-out date, cycling/titration | Free plan, no card required |
| **Peptide Tracker Calculator** | Power-user calculator | Multi-peptide blends, GLP-1 & steroid presets, U-100/50/40/30 syringes, titration ramps, on/off cycling, adherence + streaks, iCloud sync | Paid IAP |

### Patterns every serious competitor has that we don't
1. **A compound library / knowledge base.** This is the "informative" layer the
   user says we are missing, and it doubles as an ASO/SEO acquisition engine.
2. **A visual reconstitution calculator** (syringe drawing, forward/reverse,
   saved recipes) — not a single bare formula screen.
3. **Injection-site rotation / body map** — concrete, sticky, prevents
   lipohypertrophy; very screenshot-able.
4. **Medication-level / half-life curve** — the single most "wow" visualization
   in the category.
5. **Inventory & vial expiry** with "doses remaining / stock-out date."
6. **Progress visualization** (weight/measurements/photos) and **engagement**
   (streaks, adherence %, weekly recap).
7. **Export (PDF/CSV)** framed as "bring to your provider."

### Where we can differentiate
- **Privacy-first / local-first / no-account** is a genuine wedge. Several
  competitors had funding-round privacy concerns and no cloud backup; we can own
  "your data never leaves your phone unless you export it."
- **Calm, neutral, compliance-clean tone** in a category full of hype and
  borderline medical claims — a trust differentiator, especially on Android
  policy review.
- **One app for both GLP-1 and research/TRT** with a clean two-on-ramp design,
  instead of forcing users to pick a tribe.

## 5. Is this a good niche for an ads-supported app?

Short answer: **it is a good niche, but not primarily for ads.**

- Health/fitness D30 retention averages ~15–25%; pure passive trackers fall
  below ~10% at D90. Ad revenue scales with retained daily sessions, and a bare
  logger does not generate enough sessions to make ads meaningful.
- The category's revenue is demonstrably **subscription-led**: ~71% of fitness
  users are willing to pay for premium; annual plans drive the best retention;
  competitors price at $40–60/yr and sustain it.
- Ads are still useful as a **conversion lever and revenue floor**: light,
  well-placed banners on the free tier make "remove ads" a real reason to
  upgrade. But optimizing the first release around ads alone would cap the
  business and add a privacy story we don't want to tell.

Recommendation:
- **Free tier:** genuinely useful, light banner ads on non-sensitive screens,
  "remove ads" as one bullet of the upgrade.
- **Premium tier (subscription):** the depth/precision/insight bundle below.
- Keep ads off onboarding, the safety notice, calculator results, the body map,
  and the paywall.

## 6. What should be premium vs free

Guiding rule (unchanged from Phase 0): **free must be genuinely useful; premium
unlocks organization depth, precision, and insight into your own data — never
medical benefit.**

| Capability | Free | Premium |
|---|---|---|
| Active protocols/compounds | 1–2 | Unlimited |
| Fast logging, today/upcoming, history | ✅ | ✅ |
| Basic reconstitution calculator | ✅ | ✅ |
| Compound library (neutral reference) | Browse | Full detail + save to protocol |
| Visual syringe + saved recipes | Basic | Full |
| Injection-site rotation / body map | Last-site hint | Full 12-site map + history |
| Medication-level / half-life curve | Locked | ✅ |
| Inventory, vial expiry, reorder alerts | Locked | ✅ |
| Progress (weight/measurements/photos) | Limited entries | Full + charts |
| Streaks & adherence | ✅ (core habit loop) | ✅ + advanced insights |
| Weekly recap | Basic | Rich, shareable |
| Advanced schedules (cycling, titration, multi/day) | Basic only | ✅ |
| CSV/PDF export | Locked | ✅ |
| Ads | Light banners | Removed |

Why streaks/adherence stay free: they are the **retention engine**. Gating the
habit loop would suppress the very behavior that creates upgrade intent.

## 7. Compliance guardrails for the "informative" layer

The biggest opportunity (a compound library) is also the biggest compliance
risk. Hard rules so it stays a reference, not advice:
- Present neutral, educational descriptions with cited sources; never "you
  should take," "recommended dose," or protocol prescriptions.
- Show ranges only as *reported in literature/community*, clearly attributed,
  never as a default the app endorses or pre-fills as a recommendation.
- Keep the calculator strictly user-input math; library entries may *link into*
  the calculator but must not auto-fill a "recommended" dose.
- Every library entry carries the standard "informational only, not medical
  advice" line.
- Re-run the Phase 0 review checklist on all new copy before shipping.

## 8. Sources

Market and competitor context gathered 2026-06-06 via web research:
- MarketIntelo — GLP-1 drug adherence & patient-support platform / digital
  therapeutics market reports (2034 forecast).
- HLTH — "GLP-1 Drugs, Digital Health & Obesity Trends in 2026."
- DataIntelo — Global Weight Loss App market report.
- IntuitionLabs — Pharma mobile app engagement strategies (MySugr case).
- Shotsy (shotsyapp.com, App Store, Google Play) and third-party Shotsy review
  (glp1muscleloss.com).
- Regimen (helloregimen.com), Dose Track (dosetrack.app), PepBuddy
  (pepbuddyapp.com), Titer (titer.app), Peptide Tracker Calculator (App Store).
- Retention/engagement benchmarks: ScaleWithFuture, enable3, Plotline,
  productgrowth.in, lucid.now.

Numbers are third-party estimates and will drift; treat as directional.
