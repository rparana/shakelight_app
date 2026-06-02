# Phase 1: Data Model

## Entities

### `AppSettings`
Extended configuration entity to persist user preferences.
- **Fields:**
  - `sensitivity` (double, 0-100)
  - `isServiceEnabled` (bool, default: true)
  - `isHapticEnabled` (bool, default: true)
  - `shakeDirection` (enum: `Horizontal`, `Vertical`, default: `Horizontal`)
- **Relationships:** Stored via `SettingsRepository` using `SharedPreferences`.

### `ShakeState` (Internal Logic)
Used within `ShakeDetectionServiceImpl` to track movement state.
- **Fields:**
  - `peakCount` (integer, starts at 0, resets after timeout)
  - `lastPeakTime` (DateTime)
  - `lastPeakSign` (1 for positive, -1 for negative) to ensure alternating shakes.

## Validation Rules
- `sensitivity` must be clamped between 0 and 100.
- Peak counter must detect *alternating* direction peaks (e.g., strong positive X followed by strong negative X) to qualify as consecutive shakes, preventing a single long continuous movement from triggering multiple peaks. Time between peaks must be within a defined window (e.g., < 600ms).
