# Phase 0 Product Decision Memo

Source of truth: `.hermes/plans/2026-06-05_202501-peptide-tracker-app-plan.md`

## Objective
Freeze product framing, compliance guardrails, and monetization assumptions for the MVP before deeper product or engineering work.

## Locked decisions

### 1) Platform and launch
- Launch platform: Android first.
- iOS is explicitly deferred until a separate policy review is done.
- Rationale: lower policy risk, faster iteration, and better fit for a tracking-first MVP.

### 2) Core product framing
The MVP is a private tracker for peptide and GLP-1 routines.
It is for record-keeping, reminders, and user-entered calculations.
It is not positioned as treatment guidance, diagnosis, optimization, or physician replacement.

Canonical positioning statement:
> A private tracker for peptide and GLP-1 routines with reminders, logs, and simple user-input math — built for record-keeping, not medical advice.

### 3) Privacy and account model
- MVP is privacy-first.
- No account required.
- Local-only by default.
- No cloud sync in MVP.
- No backend dependency for core utility.

User promise:
> Your data stays on your device in the MVP. No account is required to get started.

### 4) Tracking-first scope
The MVP should emphasize:
- fast logging
- today/upcoming reminders
- protocol organization
- simple history
- calculator from user-entered values only

The MVP should not emphasize:
- health outcomes
- recommendations
- optimization
- coaching
- AI insights

### 5) Compliance guardrails
The product must not:
- recommend doses
- recommend protocols
- suggest schedules as medical guidance
- provide personalized medical guidance
- claim efficacy or safety outcomes
- present itself as a substitute for clinical advice
- use store language that implies diagnosis, treatment, or prescription support

The product may:
- log user-entered records
- organize routines
- remind users about schedules they create
- perform neutral calculations from values the user manually enters
- show historical records and adherence-style tracking

### 6) Calculator rule
The calculator is allowed only as neutral math from user input.
It must not include:
- suggested defaults that imply a recommended dose
- prefilled protocol templates that imply advice
- language like “you should take” or “recommended amount”

Calculator framing:
> This tool performs math from values you enter. It does not tell you what or how much to take.

### 7) Free vs Pro packaging
Recommended packaging for MVP:

#### Free
- 1 active protocol or compound
- basic calculator from user-entered values
- simple logs
- due today list
- local reminders
- light banner ads
- optionally limited history depth if needed later for conversion

#### Pro
- unlimited protocols/compounds
- inventory/vial tracking
- body map / site rotation
- advanced reminder schedules
- charts and adherence insights
- CSV export
- no ads

Packaging principle:
- Free must be genuinely useful.
- Pro must unlock organization depth and convenience, not medical claims.

### 8) Monetization hypothesis
Primary hypothesis:
- best MVP monetization is freemium with a low-friction Pro upgrade, not ads-only.

Secondary hypothesis to test after MVP utility is validated:
- one-time Pro unlock
- low-price annual plan

Commercial recommendation:
- do not optimize the first release around ads alone
- keep paywall value centered on convenience, organization depth, exports, and ad removal
- avoid pricing language tied to medical benefit or better outcomes

### 9) Launch framing for safe store review
Store framing should center on:
- private tracking
- reminders
- logs/history
- protocol organization
- user-entered calculations
- no account required

Store framing should avoid:
- dose recommendations
- treatment guidance
- protocol optimization
- clinical claims
- personalized guidance
- efficacy promises

## Review checklist for future copy and UX
Approve copy only if all answers are yes:
- Does this describe tracking or record-keeping instead of treatment?
- Does this avoid telling the user what to take or how much to take?
- Does this avoid personalized or optimization language?
- Does this keep the calculator framed as neutral math from user input?
- Does this avoid efficacy, diagnosis, or medical outcome claims?
- Does this preserve Android-first / privacy-first / no-account framing?

## Final thesis
The MVP wins by being narrow, private, and useful every day.
It should feel like a clean personal tracker with reminders and logs, not a medical advisor.
The safest commercial path is a useful free tier plus Pro convenience/features, with policy-sensitive language enforced across onboarding, calculator, settings, and store copy.
