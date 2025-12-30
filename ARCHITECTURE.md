# SizeKit : Simplified Architecture & Implementation

## 1. Overview

SizeKit is a **4-file structure** which provides pixel perfect UI designs in flutter. This approach prioritizes compile-time performance, developer ergonomics (less typing), and strict adherence to Figma design tokens without the overhead of wrapper widgets.

### Key Features

*   **Performance:** Uses `MediaQuery.sizeOf(context)` to prevent unnecessary rebuilds.
*   **Figma-First:** Direct mapping of Figma pixels to screen pixels via `.w` and `.h`.
*   **Minimalism:** No custom containers; strictly extension methods on standard Flutter types.
*   **Global Config:** `InheritedWidget` based configuration for Design Size and Breakpoints.

---

## 2. Directory Structure

```text
lib/
├── sizekit.dart                 # Main export file
└── src/
    ├── size_kit_widget.dart      # Global Configuration (InheritedWidget)
    ├── extensions.dart           # Core Scaling Logic (.w, .h, .sp)
    └── responsive_layout.dart    # Breakpoint Layout Builder
```

---

## 3. Implementation Code

### File: `lib/src/size_kit_widget.dart`

**Purpose:** Stores global settings (Figma dimensions & Breakpoints) and injects them into the widget tree.

**Key Components:**
- `Breakpoints` - Defines width boundaries for device types
- `SizeKit` - InheritedWidget for global configuration

**Features:**
- Default design size: 375x812 (Figma Mobile Frame)
- Default breakpoints: Mobile (480), Tablet (768), Desktop (1024)
- Efficient update detection (only rebuilds when design size or breakpoints change)

### File: `lib/src/extensions.dart`

**Purpose:** The primary interaction layer. Extends `num` for scaling and `BuildContext` for device detection.

#### Number Extensions (SizeKitNum)

**Figma Scaling:**
- `.w(context)` - Scale Width: Maps Figma width pixel to current screen width
- `.h(context)` - Scale Height: Maps Figma height pixel to current screen height
- `.sp(context)` - Smart Font Size: Scales with clamp (0.8x - 1.4x)
- `.r(context)` - Radius Scale: Alias for `.w()` (radii scale with width)

**Percentage Scaling:**
- `.sw(context)` - Screen Width Percentage (0.0 - 1.0)
- `.sh(context)` - Screen Height Percentage (0.0 - 1.0)

**Spacing Widgets:**
- `.vSpace` - SizedBox with height
- `.hSpace` - SizedBox with width

#### Padding Extensions (SizeKitPadding)

- `.all` - EdgeInsets.all(value)
- `.horizontal` - EdgeInsets.symmetric(horizontal: value)
- `.vertical` - EdgeInsets.symmetric(vertical: value)
- `.top`, `.bottom`, `.left`, `.right` - EdgeInsets.only(...)

#### Context Extensions (SizeKitContext)

- `context.screenWidth` - Get screen width
- `context.screenHeight` - Get screen height
- `context.isMobile` - Check if mobile breakpoint
- `context.isTablet` - Check if tablet breakpoint
- `context.isDesktop` - Check if desktop breakpoint

### File: `lib/src/responsive_layout.dart`

**Purpose:** A utility widget to switch layouts entirely based on breakpoints.

**Features:**
- Falls back to mobile if tablet/desktop not provided
- Uses context extensions for breakpoint detection
- Simple, declarative API

---

## 4. Usage Guide

### Step 1: Initialization

Run this command on terminal to install the `sizekit` package

```bash
flutter pub add sizekit
```

Wrap your root app widget with `SizeKit`. Define the `designSize` found in your Figma file (usually the mobile frame size).

```dart
import 'package:sizekit/sizekit.dart';

void main() {
  runApp(
    SizeKit(
      // The dimensions of the frame in your Figma file
      designSize: const Size(375, 812), 
      child: const MyApp(),
    ),
  );
}
```

### Step 2: Basic Usage

Convert Figma pixel values directly using extensions.

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding: 16px in Figma -> Scaled to screen
      padding: 16.w(context).all, 
      
      // Width: 100px in Figma -> Scaled
      width: 100.w(context), 
      
      // Height: 50px in Figma -> Scaled
      height: 50.h(context),
      
      child: Column(
        children: [
          Text(
            "Hello World", 
            // Font: 18px in Figma -> Scaled Smartly (Clamped)
            style: TextStyle(fontSize: 18.sp(context)), 
          ),
          
          // Spacing: 20px gap
          20.vSpace,
        ],
      ),
    );
  }
}
```

### Step 3: Responsive Layouts

Use `ResponsiveLayout` when scaling isn't enough and the structure needs to change (e.g., Column on Mobile vs Row on Desktop).

```dart
ResponsiveLayout(
  mobile: Column(children: [BoxA(), BoxB()]),
  desktop: Row(children: [BoxA(), BoxB()]),
)
```

---

## 5. Scaling Formulas

### Width Scaling (.w)
```
scaledWidth = (figmaWidth / designWidth) * screenWidth
```

### Height Scaling (.h)
```
scaledHeight = (figmaHeight / designHeight) * screenHeight
```

### Smart Font Size (.sp)
```
scaleFactor = (screenWidth / designWidth).clamp(0.8, 1.4)
scaledFontSize = figmaFontSize * scaleFactor
```

### Percentage Scaling
```
sw = screenWidth * percentage  // 0.0 - 1.0
sh = screenHeight * percentage // 0.0 - 1.0
```

---

## 6. Architecture Principles

### 1. Performance First
- Uses `MediaQuery.sizeOf(context)` instead of `MediaQuery.of(context)`
- Prevents unnecessary rebuilds when keyboard appears or system UI changes
- InheritedWidget only rebuilds when design size or breakpoints change

### 2. Figma-First Design
- Direct 1:1 mapping from Figma pixels to screen pixels
- Linear scaling maintains design proportions
- No complex calculations or quadratic scaling

### 3. Minimal API Surface
- Only 4 files total
- Extension methods on standard Flutter types
- No wrapper widgets (use standard Flutter widgets)

### 4. Developer Ergonomics
- Short, intuitive method names (`.w`, `.h`, `.sp`)
- 60% less typing compared to V1
- Consistent API across all extensions

---

## 7. Module Dependencies

```
sizekit.dart
    │
    ├── src/
    │   ├── size_kit_widget.dart (no dependencies)
    │   ├── extensions.dart (depends on: size_kit_widget.dart)
    │   └── responsive_layout.dart (depends on: extensions.dart)
```

**Dependency Graph:**
- `size_kit_widget.dart` - No dependencies (base)
- `extensions.dart` - Depends on `size_kit_widget.dart`
- `responsive_layout.dart` - Depends on `extensions.dart`

---

## 8. Data Flow

### Scaling Flow

```
User Input (Figma Value: 100px)
    │
    ▼
NumExtension.w(context)
    │
    ▼
SizeKit.of(context).designSize.width
    │
    ▼
MediaQuery.sizeOf(context).width
    │
    ▼
Calculation: (100 / 375) * screenWidth
    │
    ▼
Scaled Value (Responsive)
```

### Breakpoint Detection Flow

```
BuildContext
    │
    ▼
MediaQuery.sizeOf(context).width
    │
    ▼
SizeKit.of(context).breakpoints
    │
    ▼
Compare width with breakpoints
    │
    ▼
Return: isMobile, isTablet, or isDesktop
```

### InheritedWidget Update Flow

```
SizeKit Widget
    │
    ▼
updateShouldNotify(oldWidget)
    │
    ▼
Check: designSize != oldWidget.designSize
    │
    ▼
Check: breakpoints.mobile != oldWidget.breakpoints.mobile
    │
    ▼
Return true/false (rebuild or not)
```

---

## 9. Best Practices

### 1. Always Wrap App with SizeKit

```dart
// Good
void main() {
  runApp(
    SizeKit(
      designSize: const Size(375, 812),
      child: MyApp(),
    ),
  );
}

// Bad - Will throw assertion error
void main() {
  runApp(MyApp()); // Missing SizeKit wrapper
}
```

### 2. Use Appropriate Extension Method

```dart
// For Figma designs
100.w(context)    // Use .w() for widths
50.h(context)     // Use .h() for heights
18.sp(context)    // Use .sp() for font sizes
8.r(context)      // Use .r() for border radius

// For percentage-based layouts
0.5.sw(context)   // 50% of screen width
0.2.sh(context)   // 20% of screen height
```

### 3. Use Standard Flutter Widgets

```dart
// Good - Use standard Widgets for adaptive scaling 
Container(
  padding: 16.w(context).all,
  width: 100.w(context),
  child: Text('Hello', style: TextStyle(fontSize: 18.sp(context))),
)
```

### 4. Leverage Quick Extensions

```dart
// Good - Quick spacing
Column(
  children: [
    Widget1(),
    20.vSpace,  // Quick SizedBox
    Widget2(),
  ],
)

// Good - Quick padding
Container(
  padding: 16.w(context).all,  // Quick EdgeInsets
  child: YourWidget(),
)
```

### 5. Use ResponsiveLayout for Structure Changes

```dart
// Good - When layout structure changes
ResponsiveLayout(
  mobile: Column(children: [...]),
  desktop: Row(children: [...]),
)

// Good - For simple conditional rendering
if (context.isMobile) {
  return MobileWidget();
} else {
  return DesktopWidget();
}
```

### 6. Configure Design Size Correctly

```dart
// Good - Match your Figma frame size
SizeKit(
  designSize: const Size(375, 812),  // Mobile frame
  child: MyApp(),
)

// For desktop designs
SizeKit(
  designSize: const Size(1440, 900),  // Desktop frame
  child: MyApp(),
)
```

---

## 10. Performance Considerations

### 1. MediaQuery.sizeOf vs MediaQuery.of

**SizeKit uses `MediaQuery.sizeOf(context)`:**
- Only listens to size changes
- Does NOT rebuild when keyboard appears
- Does NOT rebuild when system UI changes
- **Critical performance improvement**

**`MediaQuery.of(context)`:**
- Listens to ALL MediaQuery changes
- Rebuilds on keyboard appearance
- Rebuilds on system UI changes
- Unnecessary rebuilds

### 2. InheritedWidget Efficiency

- Only rebuilds when `designSize` or `breakpoints.mobile` changes
- Uses `updateShouldNotify` for precise control
- Minimal rebuild overhead

### 3. Extension Method Performance

- Zero-cost abstractions
- Compile-time inlined
- No runtime overhead

---

## 11. Testing Strategy

### Unit Tests
- Scaling calculations (`.w()`, `.h()`, `.sp()`)
- Breakpoint detection logic
- Percentage calculations (`.sw()`, `.sh()`)
- InheritedWidget update logic

### Widget Tests
- ResponsiveLayout behavior
- Context extensions
- Extension method calculations

### Integration Tests
- End-to-end responsive behavior
- Design size configuration
- Breakpoint transitions

---

## 12. Contributing

When contributing to SizeKit:

1. Follow the 4-file structure
2. Maintain extension method pattern
3. Use `MediaQuery.sizeOf` for performance
4. Add comprehensive documentation
5. Include unit tests for new features
6. Update this architecture document for significant changes

---

## 13. License

This project is licensed under the MIT License.

---

**Version**: 1.0.0  
**Last Updated**: 2026
