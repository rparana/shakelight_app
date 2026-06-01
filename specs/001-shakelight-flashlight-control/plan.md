# Implementation Plan: ShakeLight Flashlight Control

**Branch**: `001-shakelight-flashlight-control` | **Date**: 2026-06-01 | **Spec**: [specs/001-shakelight-flashlight-control/spec.md]

**Input**: Feature specification from `/specs/001-shakelight-flashlight-control/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Technical architecture for a Flutter utility app that toggles the device flashlight via shake gestures detected by background motion sensor monitoring. The approach uses `Riverpod` for state management, `flutter_background_service` for persistent background execution, and native hardware integration via `torch_light` and `sensors_plus`.

## Technical Context

**Language/Version**: Dart 3.x, Flutter 3.x

**Primary Dependencies**: `flutter_riverpod`, `torch_light`, `sensors_plus`, `permission_handler`, `flutter_background_service`, `shared_preferences`

**Storage**: `shared_preferences` (local settings persistence)

**Testing**: `flutter_test` (Unit, Widget, Integration)

**Target Platform**: iOS 15+, Android 10+ (API 29+)

**Project Type**: mobile-app

**Performance Goals**: <500ms shake-to-light latency, minimal background battery impact

**Constraints**: Foreground Service with notification (Android), Background Modes (iOS), 95% Test Coverage

**Scale/Scope**: Single feature MVP

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] **I. Modular Flutter Architecture**: Plan uses Riverpod and modular service structure to decouple hardware/background logic from UI.
- [x] **II. Technical Excellence**: SOLID principles will be applied to service and provider design.
- [x] **III. Testing Discipline**: 95% coverage target is acknowledged and will be part of the task generation.
- [x] **IV. Material Design 3 & Native Integration**: MD3 will be used for UI; `PlatformException` handling is planned for hardware/permission logic.
- [x] **V. Resource & State Optimization**: Background service and motion listener will be optimized for battery efficiency.

## Project Structure

### Documentation (this feature)

```text
specs/001-shakelight-flashlight-control/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output
└── tasks.md             # Phase 2 output
```

### Source Code (repository root)

```text
lib/
├── core/                # Constants, themes, utils
├── data/
│   ├── models/          # Entities/Models
│   ├── repositories/    # Local storage/Persistence
│   └── sources/         # Native hardware wrappers
├── domain/              # Business logic (not used for this simple app)
├── presentation/
│   ├── providers/       # Riverpod providers/state management
│   ├── screens/         # Main UI screens
│   └── widgets/         # Reusable MD3 components
└── services/            # Background service implementation

test/
├── unit/                # Logic/Model tests
├── widget/              # UI tests
└── integration_test/    # E2E hardware flow tests
```

**Structure Decision**: Option 1: Single project (Clean Architecture lite)

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | N/A | N/A |
