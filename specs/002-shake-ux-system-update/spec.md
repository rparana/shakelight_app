# Feature Specification: Shake UX & System Integration Update

**Feature Branch**: `002-shake-ux-system-update`

**Created**: 2026-06-02

**Status**: Draft

**Input**: User description: "Update the ShakeLight app specifications. 1. The shake detection must require at least 2 consecutive shake movements to toggle the light to prevent accidental triggers. 2. The user must be able to choose the required shake direction (Horizontal or Vertical). 3. Include an option to enable/disable a slight haptic feedback (vibration) upon toggling the light, which must be enabled by default. 4. The background shake detection service must be enabled by default on first launch. 5. Remove the manual toggle button; instead, the central status icon must be fully tappable to manually toggle the flashlight. 6. The app must request Notification permissions and integrate with the OS Quick Settings (Notification Bar tiles) so the user can easily toggle the background service on and off, similar to Wi-Fi or Bluetooth toggles."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Advanced Shake Logic (Priority: P1)

As a user, I want the flashlight to only toggle when I perform at least two consecutive shake movements in my chosen direction so that accidental bumps don't trigger the light.

**Why this priority**: Directly addresses user frustration with accidental triggers and improves the reliability of the core feature.

**Independent Test**: Can be tested by performing a single shake (should not toggle) and then performing two rapid shakes (should toggle).

**Acceptance Scenarios**:

1. **Given** shake detection is enabled, **When** I perform a single shake movement, **Then** the flashlight state remains unchanged.
2. **Given** shake detection is enabled, **When** I perform two consecutive shake movements within a short interval, **Then** the flashlight toggles.
3. **Given** I have selected "Horizontal" shake direction, **When** I shake the device vertically, **Then** the flashlight does not toggle.

---

### User Story 2 - UI & Manual Interaction (Priority: P1)

As a user, I want to manually toggle the flashlight by tapping the central status icon instead of a separate button so that the UI is cleaner and more intuitive.

**Why this priority**: Simplifies the UI and aligns with modern design patterns where the status indicator acts as the primary control.

**Independent Test**: Can be tested by tapping the central status icon and verifying the flashlight toggles.

**Acceptance Scenarios**:

1. **Given** the flashlight is off, **When** I tap the central status icon, **Then** the flashlight turns on and the icon updates to the "On" state.
2. **Given** the flashlight is on, **When** I tap the central status icon, **Then** the flashlight turns off and the icon updates to the "Off" state.

---

### User Story 3 - System Integration & Quick Access (Priority: P2)

As a user, I want to toggle the background shake service from my device's Quick Settings (Notification Bar) so that I can easily enable or disable it without opening the app.

**Why this priority**: Enhances utility by providing system-level access to the core service, similar to system toggles like Wi-Fi or Bluetooth.

**Independent Test**: Can be tested by opening the Quick Settings panel on the device and interacting with the ShakeLight tile.

**Acceptance Scenarios**:

1. **Given** the app is installed, **When** I open the OS Quick Settings, **Then** I see a "ShakeLight" tile.
2. **Given** the background service is disabled, **When** I tap the Quick Settings tile, **Then** the background service is enabled.
3. **Given** the background service is enabled, **When** I tap the Quick Settings tile, **Then** the background service is disabled.

---

### User Story 4 - Feedback & UX Preferences (Priority: P2)

As a user, I want to feel a slight vibration when the light toggles and be able to choose my preferred shake direction in the settings.

**Why this priority**: Provides tactile confirmation of success (especially useful when shaking) and allows customization for different ergonomic preferences.

**Independent Test**: Can be tested by toggling the light and verifying haptic feedback, and by changing the shake direction in settings.

**Acceptance Scenarios**:

1. **Given** haptic feedback is enabled (default), **When** the flashlight is toggled (manually or via shake), **Then** the device provides a short vibration.
2. **Given** "Vertical" direction is selected in settings, **When** I shake the device vertically, **Then** the flashlight toggles.

### Edge Cases

- **Rapid Multiple Shakes**: If the user shakes the device 4 times, does it toggle twice? (Should implement a cooldown period after a successful toggle).
- **Notification Permissions Denied**: If the user denies notification permissions, how is the Quick Settings tile affected? (Tile may still exist but might be non-functional or prompt for permissions).
- **Service State Mismatch**: What happens if the service is toggled from Quick Settings while the app is open? (The app UI must update in real-time).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST require at least 2 consecutive shake movements within a defined timeout (e.g., 500ms) to trigger a toggle.
- **FR-002**: System MUST allow the user to select between "Horizontal" and "Vertical" shake directions in the settings.
- **FR-003**: System MUST provide an option to enable/disable haptic feedback (vibration) upon toggling the light.
- **FR-004**: Haptic feedback MUST be enabled by default.
- **FR-005**: Background shake detection service MUST be enabled by default upon first launch of the app.
- **FR-006**: The manual toggle button MUST be removed from the UI.
- **FR-007**: The central status icon MUST be interactive and toggle the flashlight when tapped.
- **FR-008**: System MUST request Notification permissions to support system-level integrations.
- **FR-009**: System MUST provide a Quick Settings Tile (Android) or equivalent system-level toggle for the background service.

### Key Entities

- **ShakePattern**: Configuration for the required movement (direction, count, timeout).
- **HapticFeedbackSettings**: User preference for tactile feedback.
- **SystemTileState**: Synchronized state between the app service and the OS Quick Settings.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Accidental triggers (single bumps) are reduced to near zero while maintaining 95%+ success rate for intentional double-shakes.
- **SC-002**: UI manual toggle response time remains under 100ms.
- **SC-003**: Quick Settings tile state updates within 1 second of the app's internal service state change.
- **SC-004**: Haptic feedback occurs within 50ms of a successful flashlight toggle.
- **SC-005**: 100% of first-launch users are prompted for Notification permissions.

## Assumptions

- The OS (Android/iOS) provides APIs for Quick Settings tiles or similar notification-based toggles.
- "Consecutive shakes" implies movements in opposing directions along the chosen axis (e.g., left-then-right for horizontal).
- The "first launch" auto-enable logic happens after permissions are granted.
