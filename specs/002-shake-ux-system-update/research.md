# Phase 0: Outline & Research

## Dependencies
- **Decision:** Use `vibration` package for haptic feedback.
- **Rationale:** Standard, reliable package for basic vibration across iOS and Android. Matches requirement for "slight haptic feedback".
- **Alternatives considered:** `haptic_feedback` package (often used for more nuanced UI haptics, but `vibration` is more robust for background/system-level events).

- **Decision:** Use `quick_settings` package.
- **Rationale:** Explicitly requested to implement the OS Quick Settings Tile in the notification bar. Provides native Android tile support.
- **Alternatives considered:** Writing custom platform channels (rejected due to complexity and existence of a supported package).

## Architecture Updates
- **Decision:** Filter `sensors_plus` data by specific axis based on user preference (X for Horizontal, Y/Z for Vertical) and implement a peak counter (minimum 2 alternating peaks over threshold).
- **Rationale:** Addresses the "2 consecutive shake movements" requirement and direction preference.

## Constitution Alignment
- All updates align with strict Clean Architecture (services separate from UI) and battery optimization (efficient axis-filtering rather than complex math in the event loop).
