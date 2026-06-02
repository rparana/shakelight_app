# PRD — ShakeLight App

**Document:** Product Requirements Document
**Product:** ShakeLight App — A background utility to toggle the flashlight by shaking the device
**Version:** 1.0
**Last updated:** 2026-06-01
**Author:** Desenvolvimento com IA

> **How to use this file with spec-kit:** > Replace every `{{placeholder}}` with real content. Once the document is finalized, use it as a reference for your Gemini CLI agent running `spec-kit`. The workflow maps to the `spec-kit` commands:
> - Use `/speckit.constitution` to define the non-functional requirements and coding standards (e.g., SOLID, 95% test coverage).
> - Use `/speckit.specify` to pass the Functional Requirements and Overview.
> - Use `/speckit.plan` to establish the Tech Stack and Data Model.
> - Finally, use `/speckit.tasks` to break this PRD into actionable steps, and `/speckit.implement` to execute the code generation.

## 1. Overview

ShakeLight App is a mobile utility developed in Flutter that allows users to turn their device's flashlight on and off simply by shaking the phone. It is designed for quick, eyes-free illumination, functioning seamlessly in the background even when the app is minimized or the screen is locked. The app provides a clean interface for users to manually toggle the light, configure shake sensitivity, and manage background service states.

## 2. Goals and non-goals

**Goals**

- Provide a reliable, battery-efficient background listener for motion events to trigger the flashlight.
- Ensure a seamless setup experience with proper native permission handling on the first launch.
- Maintain a minimum of 95% automated test coverage and adhere to Clean Code (SOLID) principles.

**Non-goals (explicitly out of scope for this build)**

- Strobe lighting or custom SOS flashing patterns.
- Screen-based illumination (using the display as a flashlight instead of the camera LED).
- Cross-device sync of user preferences (data is strictly local).

## 3. Target users

- **General Mobile Users** — People who frequently need a flashlight (e.g., during power outages, night walks, or searching for items in the dark) and want the fastest possible activation method without navigating touch menus or lock screens.

## 4. Functional requirements

### 4.1 Core Shake & Background Features

- **FR-1:** Shake Activation: The app shall use the accelerometer to detect a specific shaking pattern. The pattern must register at least 2 consecutive movements in the user-selected direction (Horizontal or Vertical) to toggle the flashlight state.
- **FR-2:** Background Execution: The app shall continue monitoring motion sensors when minimized or locked. This feature must be **enabled by default**.
- **FR-3:** Quick Settings Tile: The app shall integrate with the native OS Quick Settings (Notification Bar) allowing the user to toggle the background monitoring service outside the app.

### 4.2 User Interface & Controls

- **FR-4:** Manual Control: The central status icon on the home screen shall be interactive; tapping it will manually turn the flashlight on/off, reflecting the real-time state.
- **FR-5:** Direction & Sensitivity: The UI shall include a slider (0-100) for G-force sensitivity and a selector (Horizontal/Vertical) for the required shake direction.
- **FR-6:** Haptic Feedback: The UI shall include a toggle to enable/disable a slight vibration when the light state changes (enabled by default).
- **FR-7:** State Persistence: The app shall save all user preferences (sensitivity, direction, haptic state, service toggle) locally and restore them upon reopening.

### 4.3 Setup & Permissions

- **FR-7:** First-Launch Permissions: The app shall natively request necessary permissions (Camera/Flashlight, Motion Sensors, Background Services/Notifications) and handle permanent denials gracefully with dialogs directing users to system settings.

## 5. Non-functional requirements

- **Performance:** Battery Efficiency: The accelerometer listener must implement a debounce or optimized sampling interval to prevent excessive battery drain during background execution.
- **Quality/Testing:** All code must include automated tests, maintaining a minimum test coverage of 95%.
- **Architecture:** The project must strictly adhere to Clean Code best practices, SOLID principles, and maintain a modular architecture separating UI from business logic.
- **UI/UX:** The interface must follow Material Design 3 guidelines.
- **CI/CD:** The project must integrate with Harness (via Docker delegate) to validate Flutter code, test coverage, and track metadata versions/Feature Flags.

## 6. Tech stack

- **Language(s):** Dart
- **Frontend / Framework:** Flutter
- **State Management:** Riverpod (or BLoC)
- **Hardware Integrations:** `torch_light` or `camera` (Flashlight), `sensors_plus` (Accelerometer)
- **Background Service:** `flutter_background_service`
- **Permissions:** `permission_handler`
- **Local Storage:** `shared_preferences`
- **Testing:** `flutter test` (with `lcov` for coverage validation)

## 7. Data model

- **UserPreferences** — fields: `isShakeEnabled` (boolean, default: true), `sensitivityThreshold` (double/integer, 0-100); relates to: Local Storage (Shared Preferences).

## 8. Integrations

- **Harness CI/CD** — Used for pipeline triggers, test validation, and release tracking based on markdown metadata; requires Harness Delegate running via Docker.

## 9. Milestones

1. **Phase 0 — Foundation:** Project setup, configuration of `.speckit.yml`, Harness Docker delegate setup, and CI/CD pipeline creation.
2. **Phase 1 — Permissions & Hardware:** Implementation of `PermissionService` and manual flashlight control via UI.
3. **Phase 2 — Background Engine:** Implementation of `flutter_background_service` and accelerometer listening logic.
4. **Phase 3 — State & Polish:** Wiring the sensitivity slider, state persistence with `shared_preferences`, and final Material Design 3 UI adjustments.

## 10. Open questions

