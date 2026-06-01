# Feature Specification: ShakeLight Flashlight Control

**Feature Branch**: `001-shakelight-flashlight-control`

**Created**: 2026-06-01

**Status**: Draft

**Input**: User description: "Develop a Flutter mobile utility app named ShakeLight. The core feature is allowing the user to turn the device's flashlight on and off by shaking the phone. It must monitor motion sensors in the background, continuing to run even when the app is minimized or the screen is locked. On the first run, it must natively request permissions for Camera/Flashlight, Motion Sensors, and Background Services. The main UI must have a central status icon, a primary manual button to turn the flashlight on/off, a global switch to enable/disable the shake monitoring, and a sensitivity slider from 0 to 100 to control the required G-force threshold. User preferences for sensitivity and service state must be saved locally to be restored upon reopening."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Initial Setup & Permissions (Priority: P1)

As a new user, I want the app to request all necessary permissions on the first launch so that the flashlight and shake detection can function correctly.

**Why this priority**: Essential for the app to function; without permissions, core features are blocked.

**Independent Test**: Can be tested on a fresh install by verifying that system permission dialogs for Camera, Motion, and Background Activity appear and the app handles the responses.

**Acceptance Scenarios**:

1. **Given** the app is opened for the first time, **When** it reaches the home screen, **Then** it prompts for Camera, Motion Sensor, and Background Service permissions.
2. **Given** all permissions are granted, **When** the app is restarted, **Then** it does not prompt for permissions again.

---

### User Story 2 - Manual Flashlight Control (Priority: P1)

As a user, I want to be able to turn the flashlight on and off using a button in the app's UI so that I have manual control.

**Why this priority**: Basic utility feature and fallback for shake detection.

**Independent Test**: Can be tested by tapping the manual button and observing the device's physical flashlight.

**Acceptance Scenarios**:

1. **Given** the flashlight is off, **When** I tap the manual toggle button, **Then** the physical flashlight turns on and the UI status icon reflects the "On" state.
2. **Given** the flashlight is on, **When** I tap the manual toggle button, **Then** the physical flashlight turns off and the UI status icon reflects the "Off" state.

---

### User Story 3 - Shake to Toggle (Priority: P1)

As a user, I want to toggle the flashlight by shaking my phone so that I can turn it on quickly without looking at the screen.

**Why this priority**: Core unique value proposition of the app.

**Independent Test**: Can be tested by enabling shake monitoring and shaking the device according to the sensitivity setting.

**Acceptance Scenarios**:

1. **Given** shake monitoring is enabled and the flashlight is off, **When** I shake the device with sufficient force, **Then** the flashlight turns on.
2. **Given** the flashlight is on, **When** I shake the device with sufficient force, **Then** the flashlight turns off.

---

### User Story 4 - Background Monitoring (Priority: P2)

As a user, I want the shake detection to work even when the app is in the background or the screen is locked so that I don't have to keep the app open.

**Why this priority**: Critical for the "utility" aspect of the app.

**Independent Test**: Can be tested by minimizing the app or locking the screen and then shaking the device.

**Acceptance Scenarios**:

1. **Given** shake monitoring is enabled and the app is minimized, **When** I shake the device, **Then** the flashlight toggles.
2. **Given** shake monitoring is enabled and the screen is locked, **When** I shake the device, **Then** the flashlight toggles.

---

### User Story 5 - Settings & Persistence (Priority: P2)

As a user, I want to adjust the shake sensitivity and have my settings saved so that the app works according to my preference every time I open it.

**Why this priority**: Improves user experience and prevents repetitive configuration.

**Independent Test**: Can be tested by changing settings, closing the app, and verifying the settings remain the same upon reopening.

**Acceptance Scenarios**:

1. **Given** the sensitivity is at 50, **When** I move the slider to 80 and restart the app, **Then** the sensitivity remains at 80.
2. **Given** shake monitoring is disabled, **When** I restart the app, **Then** shake monitoring remains disabled.

### Edge Cases

- What happens when the device has no flashlight? (System should gracefully inform the user or disable the toggle).
- How does the system handle rapid multiple shakes? (Should implement a debounce/cooldown period to prevent flickering).
- What happens if the background service is killed by the OS? (Should attempt to restart or notify the user if monitoring is enabled).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST request permissions for Camera (Flashlight), Motion Sensors (Accelerometer), and Background Execution on the first run.
- **FR-002**: System MUST provide a central status icon reflecting the current state of the physical flashlight.
- **FR-003**: System MUST provide a manual button to toggle the flashlight on/off.
- **FR-004**: System MUST provide a global switch to enable or disable the background shake monitoring service.
- **FR-005**: System MUST provide a sensitivity slider (0-100) that maps to the G-force threshold for shake detection.
- **FR-006**: System MUST run a background service to monitor accelerometer data even when the UI is not visible or the device is locked.
- **FR-007**: System MUST persist the "Shake Enabled" state and "Sensitivity Value" locally.
- **FR-008**: System MUST provide no visual or haptic feedback when a shake is successfully detected to confirm the action, relying solely on the physical change in flashlight state.

### Key Entities

- **AppSettings**: Persisted configuration (sensitivity, serviceEnabled).
- **FlashlightState**: Current status of the hardware flashlight.
- **AccelerometerEvent**: Stream of G-force data from the motion sensors.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Flashlight toggles within 200ms of a manual UI interaction.
- **SC-002**: Flashlight toggles within 500ms of a qualifying shake event being detected.
- **SC-003**: Settings (Sensitivity, Toggle) are restored with 100% accuracy upon app restart.
- **SC-004**: Shake detection remains active for at least 24 hours in the background without significant battery drain (measured by OS battery stats).
- **SC-005**: 100% of first-time users receive the mandatory permission prompts.

## Assumptions

- "Background services" on Android will likely require a persistent notification to prevent being killed by the system.
- "Motion sensors" refers primarily to the 3-axis accelerometer.
- Flutter plugins such as `lamp`, `sensors_plus`, and `flutter_background_service` (or similar) will be used.
- The app targets modern iOS and Android versions that support these background capabilities.
