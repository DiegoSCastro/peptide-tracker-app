# MVP Product Spec — Screens, Navigation, and UX Flows

Source inputs:
- `.hermes/plans/2026-06-05_202501-peptide-tracker-app-plan.md`
- `docs/product/phase-0-product-decision-memo.md`
- `docs/compliance/compliance-language-pack.md`

Status: implementation-ready Phase 0 spec for the Android-first MVP.

## 1. Product goal

Ship a narrow, local-first tracker that helps users:
- create their own routines
- receive reminders for routines they created
- log completed events quickly
- review simple history
- run neutral math from values they manually enter

The MVP must feel like a private tracker, not a medical advisor.

## 2. Non-negotiable product rules

1. No account required.
2. All MVP data is local on-device.
3. No dose or protocol recommendations.
4. Calculator performs user-input math only.
5. Free tier is genuinely useful with one active protocol.
6. Pro unlocks organization depth and convenience, not medical benefit.
7. Compliance/safety language must be visible in onboarding, calculator, settings, and paywall context.

## 3. Primary user jobs

1. "I want to set up one routine and stop forgetting it."
2. "I want to log an event in a few seconds."
3. "I want a private record of what I already did."
4. "I want simple math from values I enter myself."
5. "I want to understand what Pro unlocks without hype."

## 4. MVP app shell

## Primary navigation
Use a 5-item bottom navigation bar:
1. Today
2. Protocols
3. Calculator
4. History
5. Settings

Rationale:
- keeps the highest-frequency actions one tap away
- avoids a cluttered medical-style dashboard
- puts reminders inside Today instead of creating a separate tab
- keeps paywall reachable contextually instead of wasting a core tab slot

## Global shell behaviors
- Floating action button appears on Today, Protocols, and History.
- FAB label: `Log event` on Today and History, `New protocol` on Protocols.
- Persistent top app bar title changes per tab.
- Banner ads appear only on Free and only on Today, Calculator, and History list screens.
- Pro users see no ads.
- Upgrade entry points:
  - Settings row: `Upgrade to Pro`
  - Free-tier limit intercept modal
  - Subtle card on Protocols when Free user has 1 active protocol

## Route map

```text
Launch
└── Onboarding flow (first launch only)
    ├── Welcome
    ├── Medical & safety notice
    ├── Notification intro
    ├── Create first protocol
    └── Today (landing)

Main shell
├── Today
│   ├── Quick log sheet
│   ├── Reminder item detail sheet
│   └── Log success snackbar
├── Protocols
│   ├── Protocol list
│   ├── Protocol detail
│   ├── Create/Edit protocol
│   ├── Reminder settings
│   └── Free-tier limit intercept -> Paywall
├── Calculator
│   ├── Calculator form
│   ├── Result state
│   └── Save last inputs locally
├── History
│   ├── Log list
│   ├── Filter sheet
│   └── Log detail / edit note
└── Settings
    ├── Upgrade to Pro
    ├── Notifications
    ├── Legal & safety notice
    ├── Privacy (local-only copy)
    └── About

Global overlays
├── Paywall
├── Delete confirmation dialogs
└── Permission prompts
```

## 5. Core entities for MVP

## Protocol
Fields:
- `id`
- `name` — user-defined label, required
- `compoundLabel` — free text, required
- `category` — `GLP-1`, `Peptide`, `Other`
- `unitLabel` — free text or picker (`mg`, `mcg`, `units`, `mL`, `other`)
- `plannedAmount` — optional numeric reference entered by user
- `scheduleType` — `specific weekdays`, `every N days`, `manual only`
- `scheduleDays` / `intervalDays`
- `reminderTime`
- `startDate`
- `isActive`
- `notes` — optional
- `createdAt`, `updatedAt`

Important: `plannedAmount` is stored only as the user's own reference. UI must not label it as a recommendation.

## Log entry
Fields:
- `id`
- `protocolId`
- `loggedAt`
- `amount` — optional override from planned value
- `unitLabel`
- `status` — `done`, `skipped`
- `note` — optional
- `createdFromReminder` — bool

## Reminder rule
Fields:
- `protocolId`
- `enabled`
- `scheduleType`
- `days / interval`
- `time`
- `startDate`
- `lastTriggeredAt`

## App settings
Fields:
- disclaimer accepted version
- notifications permission seen
- Pro status
- ads enabled
- theme/system mode placeholder if needed later

## 6. Free vs Pro boundaries

| Area | Free | Pro |
|---|---|---|
| Active protocols | 1 | Unlimited |
| Calculator | Included | Included |
| Logging | Included | Included |
| Today reminders | Included | Included |
| History | Included | Included |
| Ads | Light banners | Removed |
| Inventory/vial tracking | Locked | Included |
| Site rotation/body map | Locked | Included |
| Advanced reminder schedules | Basic only | Included |
| Charts/insights | Locked | Included |
| CSV export | Locked | Included |

## Basic reminder rules in Free
Free supports:
- one reminder time per protocol
- `specific weekdays` OR `every N days`
- notification title/body based on protocol label only

Advanced reminder rules reserved for Pro:
- multiple reminders per protocol
- multiple times per day
- richer recurrence builder
- snooze presets beyond system default

## 7. Global content rules

## Allowed framing examples
- `Track routines privately`
- `Your records stay on this device`
- `This tool performs math from the values you enter`
- `Reminders are based on routines you create`

## Forbidden framing examples
- `Recommended dose`
- `Best protocol`
- `Optimized schedule`
- `Safer treatment`
- `Improved results`

## Required disclaimer surfaces
1. onboarding notice (mandatory acceptance)
2. calculator disclaimer (always visible above results)
3. settings legal/safety screen
4. paywall copy restricted to convenience/organization value

## 8. Screen-by-screen spec

## 8.1 Welcome screen
Purpose: explain private-tracker positioning before asking for any action.

### Layout
```text
[App mark]
Private peptide and GLP-1 tracker
Track routines, reminders, and history in one private app.
No account is required for the MVP, and your records stay on this device.

[ Continue ]
Secondary text: You can review the safety notice before getting started.
```

### Primary action
- `Continue`

### Secondary actions
- none; keep friction low

### Notes
- No sign-in CTA.
- No pricing on first screen.
- Tiny footer link allowed: `Learn how this app is framed` -> opens safety notice.

## 8.2 Medical and safety notice
Purpose: force clear acknowledgement of the product boundary.

### Layout
```text
Medical and safety notice
This app is for record-keeping, reminders, and informational calculations based on values you enter.
It does not provide medical advice, diagnosis, treatment guidance, or personalized dose recommendations.
Always use your own judgment and consult a qualified healthcare professional for medical decisions.

[ ] I understand this app is a tracking tool and not medical advice.

[ I understand ]
```

### Rules
- CTA disabled until checkbox checked.
- Save accepted version locally.
- Accessible later via Settings.

## 8.3 Notification intro / soft ask
Purpose: explain why notifications matter before system permission prompt.

### Layout
```text
Stay on top of routines
Enable notifications to get reminders for schedules you create.
Reminders are based on your entries and are not treatment guidance.

[ Enable reminders ]
[ Not now ]
```

### Behavior
- `Enable reminders` -> trigger OS permission.
- If denied, continue onboarding without blocking.
- If granted, go to create-first-protocol screen.

## 8.4 Create first protocol
Purpose: get the user to first value quickly; this is the key activation step.

### Form fields
Required:
- Protocol name
- Compound label
- Category
- Schedule type
- Start date

Optional:
- Planned amount
- Unit label
- Reminder time
- Notes

### Layout
```text
Create your first routine
Create a routine to organize your own schedule and records.

Protocol name           [ Morning routine        ]
Compound label          [ Compound A             ]
Category                [ GLP-1 v ]
Planned amount          [ 0.25 ] [ mg v ]
Schedule                [ Every 7 days v ]
Start date              [ 06/08/2026 v ]
Reminder time           [ 09:00 AM v ]
Notes (optional)        [ ...                   ]

Helper: Schedules are based on your entries and are not treatment guidance.

[ Save routine ]
```

### Validation
- required fields must be present
- amount can be blank
- if reminder time is empty, protocol saves as manual/no reminder unless schedule requires time
- if notifications are denied, show inline note: `You can still save this routine and enable reminders later in Settings.`

### Success outcome
- navigate to Today
- show success snackbar: `Routine saved`
- if reminder configured and permission granted, schedule local notification

## 8.5 Today screen
Purpose: highest-frequency home screen; show what needs attention now.

### Information hierarchy
1. today summary
2. due/upcoming reminders
3. quick actions
4. recent activity snapshot
5. upgrade card or ad placement

### Layout: populated state
```text
Today
Tue, Jun 8

[Summary card]
1 due today
Next reminder at 9:00 AM

[Due today section]
- Morning routine          Due now         [ Log ]
  Compound A • every 7 days

[Upcoming section]
- Evening routine          Tomorrow 8:00 PM

[Quick actions]
[ Log event ] [ New protocol ] [ Calculator ]

[Recent activity]
- Logged Morning routine at 9:12 AM

[Banner ad for Free only]
```

### Layout: empty state
```text
Today
No routines yet
Create your first routine to see reminders and quick logging here.

[ Create first routine ]
[ Open calculator ]
```

### Primary actions
- `Log` from due item opens quick log sheet prefilled with protocol data
- `Log event` FAB opens quick log sheet
- `New protocol`
- `Calculator`

### Quick log sheet
Fields:
- protocol selector (prefilled if launched from Today item)
- date/time default now
- amount (prefilled from planned amount if available, editable)
- unit label
- status chips: `Done`, `Skipped`
- optional note
- CTA: `Save log`

### Rules
- logging should take < 10 seconds for the common case
- if no protocol exists, `Log event` routes to create protocol first
- if Free user already has one active protocol, `New protocol` opens paywall intercept

## 8.6 Protocols list
Purpose: manage routines and understand free-tier limits.

### Layout: Free with 1 active protocol
```text
Protocols
1 of 1 free routines used
Upgrade to add more routines, remove ads, and unlock advanced organization.
[ Upgrade ]

Active
- Morning routine
  Compound A • Every 7 days • 9:00 AM
  [ View ]
```

### Layout: Pro or Free with none
```text
Protocols
Your routines
Organize schedules, reminders, and records.

[ + New protocol ]

Active
- ...cards...
Inactive
- ...cards if any...
```

### Empty state
```text
No routines yet
Create a routine to organize your schedule and reminders.
[ Create routine ]
```

### Protocol card contents
- protocol name
- compound label
- cadence summary
- reminder status chip (`On`, `Off`, `Manual only`)
- last logged date if any
- chevron to detail

## 8.7 Protocol detail
Purpose: central place to review and manage one routine.

### Layout
```text
Morning routine
Compound A • GLP-1

[Status card]
Every 7 days at 9:00 AM
Started Jun 8, 2026
Next reminder: Jun 15, 9:00 AM

[Primary actions]
[ Log now ] [ Edit ]

[Sections]
- Schedule
- Reminder settings
- Recent logs (last 3)
- Notes

Danger zone
[ Pause routine ]
[ Delete routine ]
```

### Rules
- Free user can edit the existing protocol normally
- if paused, routine no longer appears in Today due list
- deleting a routine requires confirmation dialog

## 8.8 Create/Edit protocol screen
Purpose: full routine editor beyond onboarding.

### Form sections
1. Basics
2. Schedule
3. Reminder
4. Optional notes

### Field details
Basics:
- protocol name
- compound label
- category
- planned amount
- unit label

Schedule:
- `Specific weekdays`
- `Every N days`
- `Manual only`
- start date

Reminder:
- toggle on/off
- reminder time
- inline helper: `Reminders help you keep track of routines you create.`

Notes:
- free text

### Rules
- if `Manual only`, reminder toggle defaults off
- if user turns reminder on, time is required
- schedule summary preview shown live at bottom
- save CTA label: `Save routine`

## 8.9 Calculator
Purpose: neutral, user-input-only math tool.

### Screen sections
1. short disclaimer
2. manual input form
3. result card
4. optional reset action

### Layout
```text
Simple calculator
This tool performs math from the information you provide.
For user-input math only. Not a dose recommendation.

Vial amount            [ 10 ] [ mg v ]
Dilution volume        [ 2 ]  [ mL v ]
Desired amount         [ 0.25 ] [ mg v ]

[ Calculate ]
[ Reset ]

Result
Volume to draw: 0.05 mL
Footer: Double-check your entries before using this result.
```

### Empty state
- result card hidden until valid calculation performed

### Rules
- no prefilled medical defaults beyond placeholders/examples if approved later
- no saved protocol templates in MVP
- save last entered values locally for convenience only after first successful use
- no CTA that says `apply`, `follow`, or `use this dose`

## 8.10 History
Purpose: simple private record view.

### Layout: populated
```text
History
[ Filter ]

Jun 8, 2026
- Morning routine   Done     9:12 AM
  0.25 mg

Jun 1, 2026
- Morning routine   Skipped  9:05 AM
  Note: traveling
```

### Layout: empty
```text
No history yet
Saved logs will appear here for your private records.
[ Log your first event ]
```

### Filters in MVP
- All protocols
- Single protocol
- Last 7 days
- Last 30 days
- All time
- Status: all / done / skipped

### Log detail/edit scope
MVP allows:
- view full timestamp
- edit note
- delete log

MVP does not need:
- bulk edit
- charts
- exports

## 8.11 Settings
Purpose: privacy, legal, notifications, and upgrade hub.

### Layout
```text
Settings

Account
- No account required in MVP

Upgrade
- Upgrade to Pro
- Restore purchases

Preferences
- Notifications
- Reminder test notification

Legal and safety
- Review medical and safety notice
- Privacy: your data stays on this device

About
- App version
```

### Notes
- `Restore purchases` visible even if no current purchase
- `Reminder test notification` is useful for Android support/debugging
- no account/profile settings

## 8.12 Paywall
Purpose: convert without implying medical outcomes.

### When to show
1. user tries to create a second active protocol on Free
2. user taps `Upgrade to Pro`
3. optional subtle prompt after repeated free usage, never on first launch

### Layout
```text
Unlock Pro tracking tools
Upgrade your tracker with more organization and convenience.

- Unlimited protocols and compounds
- Inventory and vial tracking
- Advanced reminders
- Charts and history tools
- CSV export
- Remove ads

[ Start Pro ]
[ Maybe later ]
```

### Rules
- no claims about better results or optimized decisions
- include restore purchases link
- show current free plan summary above bullets when triggered by limit hit:
  `Free includes 1 active routine, calculator, logging, reminders, and history.`

## 8.13 Free-tier limit intercept
Purpose: explain the gate before showing full paywall.

### Trigger
- Free user with 1 active protocol taps `New protocol`

### Modal copy
```text
Free includes 1 active routine
You already have your free routine in use.
Upgrade to Pro for unlimited routines, advanced organization, and no ads.

[ Upgrade to Pro ]
[ Keep current routine ]
```

## 9. Empty states inventory

| Screen | Empty state | Primary CTA |
|---|---|---|
| Today | No routines yet | Create first routine |
| Protocols | No routines yet | Create routine |
| History | No history yet | Log your first event |
| Calculator | No result yet | Calculate |
| Notifications denied | Reminders are off until notifications are enabled | Open settings |
|

## 10. Critical flows

## 10.1 First launch -> first value
1. User opens app.
2. Welcome screen communicates private/local/no-account framing.
3. User accepts safety notice.
4. User sees notification intro and can enable or skip.
5. User creates first routine.
6. App lands on Today with success confirmation.
7. If reminder configured and permission granted, first local reminder is scheduled.

Success metric:
- user reaches Today with one saved protocol in under 2 minutes.

## 10.2 Today -> log event
1. User opens Today.
2. User taps `Log` on due item or FAB.
3. Quick log sheet opens prefilled.
4. User confirms `Done` or `Skipped` and optionally edits amount/note.
5. App saves entry locally.
6. Today list updates immediately.
7. History receives the new record.

Success metric:
- common-case log completion under 10 seconds.

## 10.3 Calculator use
1. User opens Calculator.
2. User manually enters all values.
3. User taps `Calculate`.
4. Result card appears with neutral copy and verification footer.
5. Last used values saved locally for convenience.

Guardrail:
- screen never suggests what value to enter.

## 10.4 Create second protocol on Free
1. Free user opens Protocols.
2. User taps `New protocol`.
3. App detects existing active protocol.
4. Free-tier limit intercept modal appears.
5. User either upgrades or returns to current routine.

## 10.5 Settings -> review legal copy
1. User opens Settings.
2. User taps `Review medical and safety notice`.
3. App opens the exact accepted notice copy in a read-only screen.
4. Optional button: `Copy summary` not needed in MVP.

## 11. Notification design rules

1. Notification content uses protocol labels only.
2. Avoid medical recommendation language.
3. Default title: `Routine reminder`
4. Default body: `It's time for your scheduled routine: Morning routine.`
5. Tapping a notification deep-links to Today with the relevant routine highlighted.
6. If protocol is paused or deleted, pending notifications are canceled.

## 12. Ad placement rules

Free only:
- Today: one banner below recent activity or empty-state secondary CTA
- Calculator: one banner pinned near bottom, below result/reset area
- History: one banner below the list after several rows or at bottom

Never place ads:
- onboarding
- legal/safety notice
- protocol creation/edit form
- paywall

## 13. Implementation notes for Flutter feature slicing

Recommended feature modules:
- `onboarding`
- `today`
- `protocols`
- `calculator`
- `history`
- `settings`
- `paywall`
- shared `notifications`, `ads`, and `purchases` services under core/platform layer

Recommended route names:
- `/welcome`
- `/safety-notice`
- `/notification-intro`
- `/today`
- `/protocols`
- `/protocol/new`
- `/protocol/:id`
- `/calculator`
- `/history`
- `/settings`
- `/paywall`

## Suggested build order after this spec
1. onboarding + disclaimer acceptance state
2. protocol CRUD + one-active-protocol free gate
3. local notifications + Today list
4. quick log + History
5. calculator
6. settings/legal surface
7. paywall hooks + ads

## 14. Acceptance checklist for this MVP spec

A build is aligned to this spec only if all answers are yes:
- Does onboarding clearly frame the app as tracking/record-keeping only?
- Can a user create one routine without any account?
- Can a user log a due event from Today in under 10 seconds?
- Does the calculator require manual input and avoid recommendations?
- Are reminders clearly user-created and non-advisory?
- Is Free useful with one active routine, logging, reminders, calculator, and history?
- Does Pro messaging focus on organization/convenience only?
- Are ads absent from sensitive/compliance-heavy screens?
- Can the user review the safety notice again in Settings?

## 15. Explicit out-of-scope for MVP

Do not include in this implementation phase:
- cloud sync
- login/account system
- AI insights
- bloodwork or symptom analysis
- recommended doses or templates
- protocol library
- social/community features
- charts, CSV export, inventory, site rotation in Free
- iOS-specific UX optimization

## 16. Final product stance

The MVP should feel like a calm, private utility:
- open app
- see what is due
- log it quickly
- review records later
- run simple math from user-entered values

If any screen starts to feel like treatment advice, the implementation is out of spec.