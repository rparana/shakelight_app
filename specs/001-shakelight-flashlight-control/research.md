# Research: ShakeLight Flashlight Control

## Background Service Implementation

- **Decision**: Use `flutter_background_service` with a dedicated `onStart` entry point.
- **Rationale**: Provides a unified API for Android Foreground Services (with notifications) and iOS background execution.
- **Alternatives considered**: `workmanager` (rejected because it's for periodic tasks, not continuous sensor monitoring).

## Shake Detection Algorithm

- **Decision**: Implement a G-force calculation using `sensors_plus` AccelerometerEvents: `sqrt(x*x + y*y + z*z)`. Toggling occurs when the delta between consecutive readings exceeds the user-defined threshold.
- **Rationale**: Simple, effective, and allows for the requested 0-100 sensitivity mapping.
- **Alternatives considered**: `shake` package (rejected to ensure precise control over threshold mapping and background performance).

## Flashlight Control

- **Decision**: Use `torch_light` for cross-platform flashlight toggling.
- **Rationale**: Lightweight, widely used, and specifically handles `PlatformException` for unavailable hardware.
- **Alternatives considered**: `camera` package (rejected as it's too heavy for a simple flashlight utility).

## State Management & Persistence

- **Decision**: `Riverpod` for reactive UI state. `shared_preferences` for persisting `sensitivity` and `serviceEnabled` boolean.
- **Rationale**: RIVERPOD is the project's standard for predictable state. `shared_preferences` is the industry standard for simple key-value persistence in Flutter.
- **Alternatives considered**: `hive` or `sqflite` (rejected as overkill for 2 simple settings).
