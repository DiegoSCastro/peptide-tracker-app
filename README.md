# peptide-tracker-app

Starter repository for a Flutter peptide tracker app.

## Stack

- Flutter
- Cubit (`flutter_bloc`) as controller/state layer
- Repository layer with `fpdart`
- `very_good_analysis` as the only lint baseline

## Structure

```text
lib/
  app/
    app.dart
  src/
    core/
      failures/
    features/
      peptides/
        data/
          datasources/
          models/
          repositories/
        domain/
          entities/
          repositories/
        presentation/
          cubit/
          view/
```

## Current scope

- Simple home screen
- Local peptide catalog seed data
- Repository returning `TaskEither`
- Cubit loading flow with success/failure states
- Basic cubit and widget tests

## Next suggested steps

1. Add local persistence for logs and reminders.
2. Add remote config for disclaimers and gated content.
3. Prepare ad placements and premium upgrade hooks.
4. Keep positioning educational and tracking-focused to reduce policy risk.
