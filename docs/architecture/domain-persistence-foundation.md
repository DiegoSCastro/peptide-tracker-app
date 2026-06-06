# Phase 2 Domain Foundation — Domain Model, Persistence, and Slice Boundaries

Source inputs:
- `.hermes/plans/2026-06-05_202501-peptide-tracker-app-plan.md`
- `docs/product/phase-0-product-decision-memo.md`
- `docs/compliance/compliance-language-pack.md`
- `docs/product/mvp-product-spec.md`

Status: implementation-ready architecture decision for the local-first MVP.

## 1. Goals

This document freezes the Phase 2 foundation for the app so implementation can proceed without re-deciding the data model on every screen.

It defines:
- the domain entities and their ownership boundaries
- repository contracts
- the local persistence choice
- schema/versioning rules
- feature slice boundaries
- state management boundaries between Cubits and shared services

## 2. Locked architecture decisions

1. Persistence engine: `drift` on top of SQLite.
2. Storage model: local-only, no account, no sync, no backend dependency for MVP.
3. IDs: stable UUID strings generated on-device for all user-owned records.
4. Timestamps: store as UTC `DateTime` everywhere.
5. Logs are append-first records with selective edits; protocol changes must not rewrite past history.
6. Reminders are owned by protocols, but scheduling execution lives in a core notifications service.
7. Monetization, analytics, and notifications stay behind abstractions in `lib/src/core/` so the MVP can ship locally first and wire providers later.
8. Avoid a single global app state. Each screen/flow owns a narrow Cubit, and repositories/services are the shared source of truth.

## 3. Why Drift was chosen

`drift` is the best fit for this app because the MVP is relational, history-heavy, and migration-sensitive.

Why it fits:
- Protocols, reminders, compounds, and log entries have clear relationships.
- History screens need filtering and ordering by protocol, compound, status, and date.
- We need explicit schema migrations for a product expected to evolve from MVP to Pro features.
- SQLite is mature, testable, offline-first, and easy to inspect during development.
- Drift keeps query logic strongly typed and colocated with the persistence layer.

Why not Hive / SharedPreferences:
- too weak for relational history queries and schema evolution
- easy to accumulate ad-hoc JSON blobs and implicit migrations

Why not Isar for the MVP:
- good option technically, but explicit SQL-style migrations and history queries are more important here than object links or max local throughput
- the app is not performance-bound; clarity and controlled schema evolution matter more

## 4. Domain model overview

The MVP should use these business entities.

### 4.1 Compound

Represents the user-defined compound label and metadata reused by one or more protocols.

Fields:
- `id`
- `name` — free text, required
- `category` — `glp1`, `peptide`, `other`
- `defaultUnit` — `mg`, `mcg`, `units`, `ml`, `other`
- `notes` — optional private notes
- `isArchived`
- `createdAt`
- `updatedAt`

Notes:
- This is intentionally user-defined, not a medical catalog.
- No seeded treatment library in MVP.
- A protocol points to a compound by `compoundId`.

### 4.2 Protocol

Represents the routine the user wants to track.

Fields:
- `id`
- `compoundId`
- `name`
- `plannedAmount` — optional numeric reference entered by user
- `unit` — snapshot of the active unit for easier log defaults
- `scheduleType` — `weekdays`, `everyNDays`, `manualOnly`
- `intervalDays` — nullable
- `startDate`
- `isActive`
- `notes`
- `createdAt`
- `updatedAt`

Notes:
- `plannedAmount` is stored only as user-entered reference data.
- Protocol owns its reminder behavior, but not the notification delivery mechanism.
- Free tier enforcement is applied at protocol creation/activation time, not buried inside UI widgets.

### 4.3 ReminderRule

Represents the notification schedule for a protocol.

Fields:
- `id`
- `protocolId`
- `isEnabled`
- `timeOfDay` — stored as minutes-from-midnight for easy persistence
- `scheduleType` — mirrors protocol schedule type for the scheduler
- `weekdaysMask` — nullable bitmask for weekday schedules
- `intervalDays` — nullable for every-N-days schedules
- `startDate`
- `lastScheduledAt` — nullable
- `lastTriggeredAt` — nullable
- `createdAt`
- `updatedAt`

Notes:
- MVP supports one reminder rule per protocol.
- Pro can later add multiple rules per protocol without changing the owning aggregate.
- Reminder delivery metadata belongs here, not in log entries.

### 4.4 LogEntry

Represents what the user actually recorded.

Fields:
- `id`
- `protocolId`
- `compoundId`
- `loggedAt`
- `status` — `done`, `skipped`
- `amount` — nullable override
- `unit`
- `note` — optional
- `createdFromReminder`
- `protocolNameSnapshot`
- `compoundNameSnapshot`
- `createdAt`
- `updatedAt`

Notes:
- Snapshot fields are intentional. Past history must remain readable even if a protocol or compound is renamed later.
- History queries should not require joining to live protocol names just to render old entries.
- Editing a log entry can update note/status/amount, but it should not mutate protocol state.

### 4.5 CalculatorDraft

Represents the last local inputs used in the calculator.

Fields:
- `id` — singleton key, e.g. `last_calculation`
- `vialAmount`
- `dilutionVolume`
- `targetAmount`
- `unit`
- `updatedAt`

Notes:
- This is not a long-lived history feature in MVP.
- Store only the latest draft so the calculator feels sticky without creating unnecessary data scope.

### 4.6 UserSettings

Represents app-level preferences and local device flags.

Fields:
- `id` — singleton
- `themeMode` — `system`, `light`, `dark`
- `notificationsPromptSeen`
- `adsEnabled`
- `analyticsEnabled` — default conservative if needed for consent/compliance
- `historyRetentionMode` — keep as `all` for MVP, but field is future-safe
- `createdAt`
- `updatedAt`

Notes:
- Keep settings separate from legal acceptance and monetization state.
- This avoids an oversized “everything settings” entity.

### 4.7 LegalAcceptance

Represents required acknowledgement of app framing.

Fields:
- `id` — singleton
- `acceptedDisclaimerVersion`
- `acceptedAt`
- `needsReacceptance`

Notes:
- This must be versioned independently from generic settings.
- If legal copy changes materially later, the app can force a new acknowledgement without disturbing other preferences.

### 4.8 MonetizationState

Represents local entitlement and paywall-related app state.

Fields:
- `id` — singleton
- `plan` — `free`, `proLifetime`, `proAnnual`, `proMonthly`
- `isEntitled`
- `lastPurchaseCheckAt` — nullable
- `activeProtocolLimit` — integer, default `1` for free
- `adsRemoved`
- `updatedAt`

Notes:
- This is a domain state object, not the billing SDK response model.
- External provider payloads must be mapped into this shape in the data layer.
- Free-vs-Pro rules should read from this repository so business logic stays testable.

### 4.9 AnalyticsEvent

Represents an internal event contract, not a product feature screen.

Fields:
- `name`
- `properties`
- `occurredAt`

Canonical MVP events:
- `onboarding_completed`
- `protocol_created`
- `protocol_activated`
- `reminder_enabled`
- `log_recorded`
- `calculator_used`
- `paywall_viewed`
- `purchase_started`
- `purchase_completed`

Notes:
- Analytics should be an abstraction first.
- MVP can start with a no-op implementation or a debug logger and swap in a provider later.
- If we need guaranteed offline delivery later, add a local event queue table without changing feature APIs.

## 5. Repository contracts

Recommended repository set:

### CompoundsRepository
Owns compound CRUD and active/archive queries.

Methods:
- `watchAll()`
- `watchActive()`
- `getById(String id)`
- `save(Compound compound)`
- `archive(String id)`
- `deleteIfUnused(String id)`

### ProtocolsRepository
Owns protocol CRUD, free-tier gating checks, and protocol-level reminder state.

Methods:
- `watchAll()`
- `watchActive()`
- `watchById(String id)`
- `create(ProtocolDraft draft)`
- `update(Protocol protocol)`
- `setActive(String id, bool isActive)`
- `delete(String id)`
- `countActive()`

### ReminderRulesRepository
Owns reminder rule persistence only.

Methods:
- `watchForProtocol(String protocolId)`
- `save(ReminderRule rule)`
- `deleteForProtocol(String protocolId)`
- `listSchedulable()`

### LogEntriesRepository
Owns quick-log, history, and edit-note operations.

Methods:
- `watchRecent()`
- `watchByDateRange(DateTime start, DateTime end)`
- `watchByProtocol(String protocolId)`
- `create(LogEntryDraft draft)`
- `update(LogEntry entry)`
- `delete(String id)`

### CalculatorDraftRepository
Owns only the sticky calculator inputs.

Methods:
- `loadLastDraft()`
- `saveDraft(CalculatorDraft draft)`
- `clearDraft()`

### SettingsRepository
Owns local app preferences.

Methods:
- `watchSettings()`
- `saveSettings(UserSettings settings)`

### LegalRepository
Owns disclaimer acceptance state.

Methods:
- `getAcceptance()`
- `acceptVersion(String version, DateTime acceptedAt)`
- `markNeedsReacceptance(String version)`

### MonetizationRepository
Owns entitlement state used by business logic.

Methods:
- `watchState()`
- `refreshEntitlement()`
- `applyEntitlement(MonetizationState state)`

### AnalyticsTracker
This should be a service interface, not a screen repository.

Methods:
- `track(String event, {Map<String, Object?> properties = const {}})`

## 6. Recommended Drift schema

Minimum MVP tables:
- `compounds`
- `protocols`
- `reminder_rules`
- `log_entries`
- `calculator_draft`
- `user_settings`
- `legal_acceptance`
- `monetization_state`

Suggested relational rules:
- `protocols.compound_id -> compounds.id`
- `reminder_rules.protocol_id -> protocols.id`
- `log_entries.protocol_id -> protocols.id`
- `log_entries.compound_id -> compounds.id`

Suggested indexes:
- `protocols(is_active, updated_at)`
- `reminder_rules(protocol_id)` unique for MVP
- `log_entries(logged_at desc)`
- `log_entries(protocol_id, logged_at desc)`
- `compounds(is_archived, updated_at)`

Deletion rules:
- deleting a protocol should delete its reminder rule
- deleting a protocol should not silently delete logs in the real app without confirmation
- if hard-delete of protocol is allowed, log entries should remain with snapshots or be soft-deleted only after explicit destructive action

Recommendation:
- keep protocol deletion as a “deactivate + optional archive” flow in MVP
- reserve true destructive cleanup for a later explicit settings action

## 7. Versioning and migration strategy

### 7.1 Schema versioning

Use Drift schema versions with additive migrations.

Rules:
1. Never rely on destructive reset outside debug builds.
2. Prefer adding nullable columns or new tables over rewriting old columns.
3. Keep migrations small and named in chronological order.
4. Add a migration test for every schema version bump.

### 7.2 Planned schema milestones

#### Schema v1
Covers MVP foundation:
- compounds
- protocols
- reminder_rules
- log_entries
- calculator_draft
- user_settings
- legal_acceptance
- monetization_state

#### Schema v2
Reserved for first Pro expansion:
- inventory items
- inventory events
- protocol-level stock warnings

#### Schema v3
Reserved for convenience/insight expansion:
- body site rotation
- chart preferences
- richer reminder presets

### 7.3 Data evolution rules

- Every entity gets `createdAt` and `updatedAt`.
- Prefer archived/inactive flags over destructive deletion for user-authored records.
- Log entries preserve display snapshots for protocol and compound labels.
- Legal acceptance is version-keyed so disclaimer updates can trigger re-acceptance cleanly.

## 8. Feature slice boundaries

The app should move from the single `peptides/` starter slice to product-oriented slices.

Recommended top-level structure:

```text
lib/src/
  core/
    analytics/
    database/
    failures/
    monetization/
    notifications/
    routing/
    utils/
  features/
    onboarding/
    today/
    protocols/
    calculator/
    history/
    settings/
    paywall/
```

### 8.1 `core/`
Owns cross-cutting infrastructure only.

Should contain:
- Drift database and table definitions
- notification scheduler abstraction
- monetization provider abstraction
- analytics tracker abstraction
- shared failures, result types, ids, clocks

Must not contain:
- screen-specific Cubits
- feature business rules that belong to protocols/history/settings

### 8.2 `features/onboarding/`
Owns:
- welcome flow
- disclaimer acceptance step
- notification intro step
- first protocol creation orchestration

Reads/writes:
- `LegalRepository`
- `SettingsRepository`
- `ProtocolsRepository`
- notification permission service

### 8.3 `features/protocols/`
Owns:
- compound CRUD
- protocol CRUD
- reminder rule editing
- free-tier enforcement before activation/creation

Reads/writes:
- `CompoundsRepository`
- `ProtocolsRepository`
- `ReminderRulesRepository`
- `MonetizationRepository`
- notification sync use case

Notes:
- compound and protocol editing stay together because the UX treats them as one setup flow
- reminder editing belongs here because reminder rules are protocol configuration

### 8.4 `features/today/`
Owns:
- due today list
- upcoming reminders preview
- quick log entry points
- “nothing due” and “create first protocol” empty states

Reads/writes:
- `ProtocolsRepository`
- `ReminderRulesRepository`
- `LogEntriesRepository`

Notes:
- Today is a read-model slice. It should compose data from other repositories rather than owning separate persistence.
- Do not create a second source of truth for “today items”. Compute them from protocols, reminders, and recent logs.

### 8.5 `features/calculator/`
Owns:
- user-input math form
- disclaimer rendering
- sticky last-input behavior

Reads/writes:
- `CalculatorDraftRepository`
- `AnalyticsTracker`

Notes:
- calculator data should remain isolated from protocol state in MVP
- avoid auto-filling values from protocols, which risks blurring into guidance

### 8.6 `features/history/`
Owns:
- log list
- filters
- log details
- note edits

Reads/writes:
- `LogEntriesRepository`
- optional protocol/compound lookup for filters

Notes:
- history owns browsing and editing past records
- it does not own reminder state or protocol setup

### 8.7 `features/settings/`
Owns:
- legal and safety screen
- privacy/local-only copy
- notification settings entry point
- theme/app preferences
- upgrade row entry point

Reads/writes:
- `SettingsRepository`
- `LegalRepository`
- `MonetizationRepository`

### 8.8 `features/paywall/`
Owns:
- paywall UI
- offer presentation
- purchase flow orchestration

Reads/writes:
- `MonetizationRepository`
- analytics tracker

Notes:
- keep SDK-specific billing code out of the widget layer
- paywall does not decide free-tier rules; it only presents offers and purchase actions

## 9. State management boundaries

Use small Cubits per screen/flow. Do not create a single app-wide Cubit for all product data.

Recommended Cubits:
- `OnboardingCubit`
- `TodayCubit`
- `ProtocolsListCubit`
- `ProtocolEditorCubit`
- `CalculatorCubit`
- `HistoryCubit`
- `SettingsCubit`
- `PaywallCubit`

Rules:
1. Cubits talk to repositories/services, not directly to Drift tables.
2. Cross-feature workflows should use an application service/use case, not Cubit-to-Cubit calls.
3. Protocol save/update flows should trigger reminder rescheduling through a service.
4. Quick log writes to `LogEntriesRepository`; it must not mutate reminder entities directly.
5. Paywall presentation can be triggered from any slice, but entitlement state still comes from `MonetizationRepository`.

## 10. Notification boundary

Notifications are implementation detail, not domain truth.

Recommended split:
- `ReminderRule` stores the desired schedule.
- `NotificationScheduler` translates stored reminder rules into OS notifications.
- `SyncProtocolRemindersUseCase` runs after protocol/reminder mutations and on app startup.

This keeps reminder logic testable without tying the domain directly to plugin APIs.

## 11. Analytics boundary

Analytics should be additive and low-risk.

Rules:
- Never make a core user flow depend on analytics success.
- Fire analytics from use cases/Cubits after successful business actions.
- Keep event names centralized in one file to avoid drift.
- If analytics is disabled, the app still behaves identically.

## 12. Suggested implementation order

1. Add `core/database/` with Drift database and schema v1.
2. Replace the starter `peptides/` slice with `protocols/`, `today/`, `calculator/`, `history/`, `settings/`, and `onboarding/` scaffolds.
3. Implement compound/protocol/reminder repositories.
4. Implement log entry repository and Today read model.
5. Implement settings/legal/monetization singletons.
6. Add notification scheduler abstraction.
7. Add analytics tracker abstraction with no-op default.
8. Add fixture builders for local development and widget tests.

## 13. Practical non-goals for this phase

Do not add in Phase 2:
- cloud sync
- remote content system
- AI-generated suggestions
- medical defaults or protocol templates
- deep analytics warehouse design
- advanced reminder recurrence beyond the MVP matrix

## 14. Final recommendation

Build the MVP around Drift-backed local relational data, with protocols as the main authoring aggregate, log entries as immutable-ish historical records, reminder scheduling pushed into a core service, and narrow feature-owned Cubits on top.

This gives the project a stable local-first foundation now while keeping Pro features, provider integrations, and later schema growth straightforward.
