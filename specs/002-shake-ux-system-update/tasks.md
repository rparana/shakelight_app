# Tasks: Shake UX & System Integration Update

**Input**: Design documents from `/specs/002-shake-ux-system-update/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

**Tests**: 95% test coverage is mandatory as per the Project Constitution. All logic changes must be verified with unit and integration tests.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 [P] Add dependencies `vibration` and `quick_settings` to `pubspec.yaml`
- [x] T002 [P] Create placeholder service for Quick Settings in `lib/services/quick_settings_service.dart`
- [x] T003 [P] Add `shake_direction.dart` enum (Horizontal, Vertical) in `lib/data/models/shake_direction.dart`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure updates that ALL user stories depend on

- [x] T004 [P] Update `AppSettings` model with `isHapticEnabled` and `shakeDirection` in `lib/data/models/app_settings.dart`
- [x] T005 Update `SettingsRepository` to persist new fields and set `isServiceEnabled` default to true in `lib/data/repositories/settings_repository.dart`
- [x] T006 Update `SettingsNotifier` to handle new preferences in `lib/presentation/providers/settings_provider.dart`
- [x] T007 [P] Create unit tests for updated settings persistence in `test/unit/data/settings_repository_test.dart`

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Advanced Shake Logic (Priority: P1) 🎯 MVP

**Goal**: Implement direction-based filtering and 2-peak shake detection logic.

**Independent Test**: Perform single shakes (no toggle) vs. double shakes (toggle) on specific axes in the app.

### Tests for User Story 1

- [x] T008 [P] [US1] Create unit tests for direction-based filtering logic in `test/unit/services/shake_detection_service_test.dart`
- [x] T009 [P] [US1] Create unit tests for 2-peak counter logic (timing and alternation) in `test/unit/services/shake_detection_service_test.dart`

### Implementation for User Story 1

- [x] T010 [US1] Refactor `ShakeDetectionServiceImpl` to filter by X (Horizontal) or Y/Z (Vertical) axis in `lib/services/shake_detection_service.dart`
- [x] T011 [US1] Implement peak detection with state tracking (last peak time, sign) in `lib/services/shake_detection_service.dart`
- [x] T012 [US1] Implement 2-peak counter logic with timeout (e.g., 600ms) in `lib/services/shake_detection_service.dart`

**Checkpoint**: User Story 1 functional - flashlight only toggles on valid double-shakes.

---

## Phase 4: User Story 2 - UI & Manual Interaction (Priority: P1)

**Goal**: Make the central status icon the primary manual control and add new settings.

**Independent Test**: Tap the central icon to toggle light; verify manual toggle button is gone.

### Tests for User Story 2

- [x] T013 [P] [US2] Update widget tests to verify `StatusIcon` is wrapped in `GestureDetector` in `test/widget/home_screen_ui_test.dart`
- [x] T014 [P] [US2] Update widget tests to verify removal of `ManualToggleButton` in `test/widget/home_screen_ui_test.dart`

### Implementation for User Story 2

- [x] T015 [US2] Wrap `StatusIcon` with `GestureDetector` in `lib/presentation/screens/home_screen.dart`
- [x] T016 [US2] Remove `ManualToggleButton` from `lib/presentation/screens/home_screen.dart`
- [x] T017 [US2] Add direction selector (Horizontal/Vertical) to `lib/presentation/screens/settings_screen.dart`
- [x] T018 [US2] Add haptic feedback toggle to `lib/presentation/screens/settings_screen.dart`

**Checkpoint**: UI updated - cleaner home screen and comprehensive settings.

---

## Phase 5: User Story 3 - System Integration (Priority: P2)

**Goal**: Implement Android Quick Settings Tile to toggle background service.

**Independent Test**: Toggle the ShakeLight tile from the Android notification shade and observe service state change in the app.

### Implementation for User Story 3

- [x] T019 [US3] Configure Android manifest for Quick Settings Tile in `android/app/src/main/AndroidManifest.xml`
- [x] T020 [US3] Implement `QuickSettingsService` using `quick_settings` package in `lib/services/quick_settings_service.dart`
- [x] T021 [US3] Link Quick Settings toggle to `SettingsNotifier` state in `lib/services/quick_settings_service.dart`
- [x] T022 [US3] Request Notification permissions on first launch in `lib/services/permission_service.dart`

---

## Phase 6: User Story 4 - Feedback & UX Preferences (Priority: P2)

**Goal**: Provide haptic feedback upon light toggle.

**Independent Test**: Toggle the light and confirm the device vibrates slightly.

### Implementation for User Story 4

- [x] T023 [US4] Integrate `Vibration` into `FlashlightServiceImpl` or a wrapper service in `lib/services/flashlight_service.dart`
- [x] T024 [US4] Add check for `isHapticEnabled` before triggering vibration in `lib/services/flashlight_service.dart`

---

## Phase N: Polish & Cross-Cutting Concerns

- [x] T025 [P] Update `README.md` with new features and dependency instructions
- [x] T026 Final validation of test coverage across all new services
- [x] T027 [P] Run `quickstart.md` validation steps

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 & 2**: MUST be completed first.
- **Phase 3 (US1)**: High priority core logic.
- **Phase 4 (US2)**: High priority UI alignment.
- **Phase 5 & 6**: Can be worked on after Phase 2, but ideally after Phase 3/4.

### Parallel Opportunities

- T001, T002, T003 can run in parallel.
- T004 can run in parallel with T002/T003.
- Phase 3 (US1) and Phase 4 (US2) can largely run in parallel after Phase 2 is done.
- Testing tasks (T008, T009, T013, T014) can be prepared in parallel with implementation.
