# Data Model: ShakeLight Flashlight Control

## AppSettings (Persisted)

| Field | Type | Default | Validation |
|-------|------|---------|------------|
| `sensitivity` | double | 50.0 | 0.0 to 100.0 |
| `isServiceEnabled` | bool | false | N/A |

## FlashlightState (Runtime)

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `isActive` | bool | false | True if the physical torch is on |
| `error` | String? | null | Last error message if hardware fails |

## AccelerometerData (Runtime)

| Field | Type | Description |
|-------|------|-------------|
| `x`, `y`, `z` | double | Raw G-force values from sensors_plus |
| `magnitude` | double | Calculated as `sqrt(x^2 + y^2 + z^2)` |
