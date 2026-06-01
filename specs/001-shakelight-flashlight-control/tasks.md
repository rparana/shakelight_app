---

description: "Task list for ShakeLight Flashlight Control implementation"
---

# Tasks: ShakeLight Flashlight Control

**Input**: Design documents from `/specs/001-shakelight-flashlight-control/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: The tasks below include test tasks. Tests are MANDATORY as per the Project Constitution (95% coverage requirement). All implementation tasks must be accompanied by corresponding test tasks.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: `lib/`, `test/` at repository root
- Paths assume single project structure from plan.md

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create project structure (lib/core, lib/data, lib/presentation, lib/services) per plan.md
- [x] T002 Add dependencies (flutter_riverpod, torch_light, sensors_plus, permission_handler, flutter_background_service, shared_preferences) to pubspec.yaml
- [x] T003 [P] Configure linting rules in analysis_options.yaml

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T004 Create base theme and MD3 color scheme in lib/core/theme.dart
- [x] T005 [P] Implement AppSettings model in lib/data/models/app_settings.dart
- [x] T006 [P] Implement FlashlightState model in lib/data/models/flashlight_state.dart
- [x] T007 Implement SettingsRepository using shared_preferences in lib/data/repositories/settings_repository.dart
- [x] T008 [P] Setup Riverpod ProviderContainer and fundamental providers in lib/presentation/providers/base_providers.dart
- [x] T009 [P] Create common error handling and PlatformException wrapper in lib/core/error_handler.dart

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Initial Setup & Permissions (Priority: P1) 🎯 MVP

**Goal**: Request Camera, Motion, and Background permissions on first launch.

**Independent Test**: Verify permission dialogs appear on fresh install and state is persisted.

### Tests for User Story 1

- [x] T010 [P] [US1] Unit test for PermissionService logic in test/unit/services/permission_service_test.dart
- [x] T011 [US1] Widget test for Permission Request Flow in test/widget/permission_flow_test.dart

### Implementation for User Story 1

- [x] T012 [P] [US1] Implement PermissionService using permission_handler in lib/services/permission_service.dart
- [x] T013 [US1] Create PermissionProvider for UI binding in lib/presentation/providers/permission_provider.dart
- [x] T014 [US1] Update Main screen to trigger permission request on init in lib/presentation/screens/home_screen.dart

**Checkpoint**: Initial Setup & Permissions functional.

---

## Phase 4: User Story 2 - Manual Flashlight Control (Priority: P1) 🎯 MVP

**Goal**: Toggle flashlight via UI button.

**Independent Test**: Tapping UI button toggles physical flashlight and updates status icon.

### Tests for User Story 2

- [x] T015 [P] [US2] Unit test for FlashlightService in test/unit/services/flashlight_service_test.dart
- [x] T016 [US2] Widget test for Status Icon and Toggle Button in test/widget/home_screen_ui_test.dart

### Implementation for User Story 2

- [x] T017 [P] [US2] Implement FlashlightService using torch_light in lib/services/flashlight_service.dart
- [x] T018 [US2] Create FlashlightProvider for state management in lib/presentation/providers/flashlight_provider.dart
- [x] T019 [US2] Implement Status Icon component per ui-contract.md in lib/presentation/widgets/status_icon.dart
- [x] T020 [US2] Implement Manual Toggle Button in lib/presentation/widgets/toggle_button.dart
- [x] T021 [US2] Integrate widgets into lib/presentation/screens/home_screen.dart

**Checkpoint**: Manual Flashlight Control functional.

---

## Phase 5: User Story 3 - Shake to Toggle (Priority: P1) 🎯 MVP

**Goal**: Toggle flashlight by shaking the device.

**Independent Test**: Shaking the device (when enabled) toggles the flashlight.

### Tests for User Story 3

- [x] T022 [P] [US3] Unit test for ShakeDetectionService algorithm in test/unit/services/shake_detection_test.dart
- [x] T023 [US3] Integration test for Shake-to-Toggle flow in test/integration_test/shake_flow_test.dart

### Implementation for User Story 3

- [x] T024 [P] [US3] Implement ShakeDetectionService using sensors_plus in lib/services/shake_detection_service.dart
- [x] T025 [US3] Create ShakeMonitoringProvider in lib/presentation/providers/shake_monitoring_provider.dart
- [x] T026 [US3] Connect ShakeDetectionService to FlashlightService in lib/presentation/providers/shake_monitoring_provider.dart

**Checkpoint**: Shake to Toggle functional.

---

## Phase 6: User Story 4 - Background Monitoring (Priority: P2)

**Goal**: Shake detection works when app is minimized or screen is locked.

**Independent Test**: Minimize app/lock screen and verify shake still toggles flashlight.

### Tests for User Story 4

- [x] T027 [P] [US4] Unit test for BackgroundService initialization in test/unit/services/background_service_test.dart
- [ ] T028 [US4] Integration test for background shake detection in test/integration_test/background_shake_test.dart

### Implementation for User Story 4

- [x] T029 [P] [US4] Configure Android Manifest for Foreground Service and Notifications
- [x] T030 [P] [US4] Configure iOS Info.plist for Background Modes
- [x] T031 [US4] Implement BackgroundService using flutter_background_service in lib/services/background_service.dart
- [x] T032 [US4] Move ShakeDetection logic to background entry point in lib/services/background_service.dart

**Checkpoint**: Background Monitoring functional.

---

## Phase 7: User Story 5 - Settings & Persistence (Priority: P2)

**Goal**: Adjust sensitivity and persist settings.

**Independent Test**: Adjust slider, restart app, verify settings are restored.

### Tests for User Story 5

- [x] T033 [P] [US5] Unit test for SettingsRepository persistence in test/unit/data/settings_repository_test.dart
- [x] T034 [US5] Widget test for Sensitivity Slider in test/widget/settings_ui_test.dart

### Implementation for User Story 5

- [x] T035 [P] [US5] Implement Sensitivity Slider widget in lib/presentation/widgets/sensitivity_slider.dart
- [x] T036 [P] [US5] Implement Service Toggle switch in lib/presentation/widgets/service_switch.dart
- [x] T037 [US5] Create SettingsProvider to manage persistence via SettingsRepository in lib/presentation/providers/settings_provider.dart
- [x] T038 [US5] Connect SettingsProvider to ShakeDetectionService threshold in lib/services/shake_detection_service.dart

**Checkpoint**: Settings & Persistence functional.

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T039 [P] Finalize MD3 styling and animations (Transitions for status icon)
- [ ] T040 [P] Add haptic feedback for manual button (if desired, optional per spec)
- [ ] T041 Code cleanup and refactoring (SOLID check)
- [ ] T042 Performance optimization (Minimize sensor listener frequency)
- [x] T043 [P] Documentation updates in README.md and code comments
- [ ] T044 Run quickstart.md validation on physical device
- [x] T045 Final coverage report check (Must be >= 95%)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - US1, US2, US3 can proceed in parallel (P1 priorities)
  - US4 depends on US3 logic
  - US5 can proceed in parallel with US3/US4

### User Story Dependencies

- **User Story 1 (P1)**: Independent after Phase 2
- **User Story 2 (P1)**: Independent after Phase 2
- **User Story 3 (P1)**: Independent after Phase 2
- **User Story 4 (P2)**: Depends on US3 (Shake algorithm)
- **User Story 5 (P2)**: Depends on Phase 2 (Repository)

### Implementation Strategy

### MVP First (User Stories 1, 2, 3 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: US1 (Permissions)
4. Complete Phase 4: US2 (Manual)
5. Complete Phase 5: US3 (Shake)
6. **STOP and VALIDATE**: Verify core utility on device

### Incremental Delivery

1. Setup + Foundation → Core ready
2. US1 + US2 + US3 → MVP ready (Flashlight works by shake in foreground)
3. US4 → Background capability added
4. US5 → User configuration and persistence added
5. Phase N → Final polish

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- 95% test coverage is mandatory - tests are written before implementation
- Physical device is required for validating flashlight and motion sensors
