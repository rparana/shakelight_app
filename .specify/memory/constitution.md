<!--
<sync_impact_report>
- Version change: [CONSTITUTION_VERSION] -> 1.0.0
- List of modified principles:
  - [PRINCIPLE_1_NAME] -> I. Modular Flutter Architecture
  - [PRINCIPLE_2_NAME] -> II. Technical Excellence (Clean Code & SOLID)
  - [PRINCIPLE_3_NAME] -> III. Testing Discipline (95% Coverage)
  - [PRINCIPLE_4_NAME] -> IV. Material Design 3 & Native Integration
  - [PRINCIPLE_5_NAME] -> V. Resource & State Optimization
- Added sections: Technical Standards, Development Workflow
- Removed sections: None
- Templates requiring updates:
  - .specify/templates/tasks-template.md (✅ updated)
- Follow-up TODOs: None
</sync_impact_report>
-->

# ShakeLight Constitution

## Core Principles

### I. Modular Flutter Architecture
Strictly separate UI from business logic following Clean Architecture principles. All code, variables, comments, and internal documentation MUST be in English. Maintain a clean, modular structure where the UI layer is decoupled from the domain and data layers.

### II. Technical Excellence (Clean Code & SOLID)
Strictly adhere to Clean Code best practices and SOLID principles. Prioritize maintainability and readability. Every class and function should have a single responsibility. Use dependency injection to manage dependencies and improve testability.

### III. Testing Discipline (95% Coverage)
All code MUST include automated tests. Maintain a minimum test coverage of 95%. No code is considered complete or ready for merge without passing unit and integration tests that verify the requested behavior and edge cases.

### IV. Material Design 3 & Native Integration
Follow Material Design 3 guidelines for all UI components to ensure a modern and consistent user experience. Implement rigorous native error handling (e.g., PlatformException) especially when dealing with hardware permissions (camera, flashlight, motion sensors) and background services.

### V. Resource & State Optimization
Prioritize battery efficiency in all hardware interactions. Implement robust state management for the accelerometer background listener to ensure reliable hardware interaction without draining device resources.

## Technical Standards

- **Framework**: Flutter (Current stable)
- **Language**: Dart (English naming conventions only)
- **UI System**: Material Design 3
- **Error Handling**: Rigorous use of `PlatformException` for native interop and hardware access.
- **Hardware Focus**: Camera (Flashlight), Accelerometer, Motion Sensors.

## Development Workflow

- **Testing Gate**: Minimum 95% test coverage is mandatory for all new features.
- **Code Language**: English-only for all identifiers, comments, and documentation.
- **Architectural Separation**: Strict separation of UI (Widgets) from Business Logic (BLoCs/Controllers/Services).
- **Native Services**: Background services must be optimized for battery life and resource usage.

## Governance

This constitution supersedes all other practices and informal agreements. Amendments require a formal specification update, version bump, and documentation of the rationale. Versioning follows Semantic Versioning (SemVer). All pull requests and code reviews must verify compliance with these principles.

**Version**: 1.0.0 | **Ratified**: 2026-06-01 | **Last Amended**: 2026-06-01
