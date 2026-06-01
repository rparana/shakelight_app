# UI Contract: ShakeLight

The ShakeLight app follows Material Design 3 guidelines. The main interface is a single-screen utility.

## Components

### 1. Status Icon (Central)
- **State: Off**: Large circular icon with a "Flashlight Off" symbol (e.g., `Icons.flashlight_off`). Subdued color.
- **State: On**: Large circular icon with a "Flashlight On" symbol (e.g., `Icons.flashlight_on`). Bright/Glowing color (e.g., Amber).

### 2. Manual Toggle Button
- **Type**: Filled Button or Large FAB.
- **Action**: Immediately toggles the hardware flashlight and updates the Status Icon.

### 3. Service Switch
- **Type**: List Tile with Switch.
- **Label**: "Enable Shake Detection".
- **Action**: Starts/Stops the background motion monitoring service.

### 4. Sensitivity Slider
- **Range**: 0 (Very Insensitive) to 100 (Very Sensitive).
- **Label**: "Shake Sensitivity".
- **Behavior**: Updates the threshold used by the background accelerometer listener.

## Navigation
- Single Screen app. No bottom navigation or drawer required for MVP.
