# SizeKit

A simplified, high-performance Flutter package for building responsive layouts from Figma designs with pixel perfection. SizeKit provides a minimal 4-file architecture with extension methods that make responsive design effortless.

## Features

- 🚀 **Performance First** - Uses `MediaQuery.sizeOf` to prevent unnecessary rebuilds
- 🎨 **Figma-First Design** - Direct 1:1 mapping from Figma pixels to screen pixels
- 📱 **Multi-Platform** - Works seamlessly on mobile, tablet, and desktop
- 🎯 **Simple API** - Just `.w()`, `.h()`, `.sp()` - 80% less typing than using MediaQuery
- 📦 **Minimal** - Only 4 files, easy to understand and maintain
- 🔧 **Standard Widgets** - No wrapper widgets, use standard Flutter widgets

## Installation

Run this command on terminal to install the `sizekit` package

```bash
flutter pub add sizekit
```

Or Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  sizekit: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Step 1: Initialize SizeKit

Wrap your root app widget with `SizeKit`:

```dart
import 'package:sizekit/sizekit.dart';

void main() {
  runApp(
    SizeKit(
      // The dimensions of the frame in your Figma file
      designSize: const Size(375, 812), // Default Figma Mobile Frame
      child: const MyApp(),
    ),
  );
}
```

### Step 2: Use Extension Methods

Convert Figma pixel values directly:

```dart
Container(
  // Padding: 16px in Figma -> Scaled to screen
  padding: 16.w(context).all, 
  
  // Width: 100px in Figma -> Scaled
  width: 100.w(context), 
  
  // Height: 50px in Figma -> Scaled
  height: 50.h(context),
  
  // Border radius: 8px in Figma -> Scaled
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8.r(context)),
  ),
  
  child: Text(
    "Hello World", 
    // Font: 18px in Figma -> Scaled Smartly (Clamped 0.8x - 1.4x)
    style: TextStyle(fontSize: 18.sp(context)), 
  ),
)
```

## Core Extension Methods

### Figma Scaling

```dart
100.w(context)    // Scale width from Figma design
50.h(context)     // Scale height from Figma design
18.sp(context)    // Smart font size (clamped 0.8x - 1.4x)
8.r(context)      // Scale radius (alias for .w())
```

### Percentage Scaling

```dart
0.5.sw(context)   // 50% of screen width
0.2.sh(context)   // 20% of screen height
```

### Spacing Widgets

```dart
20.vSpace         // SizedBox(height: 20)
10.hSpace        // SizedBox(width: 10)
```

### Padding Helpers

```dart
16.w(context).all         // EdgeInsets.all(16.w(context))
16.w(context).horizontal  // EdgeInsets.symmetric(horizontal: 16.w(context))
16.w(context).vertical    // EdgeInsets.symmetric(vertical: 16.w(context))
16.w(context).top         // EdgeInsets.only(top: 16.w(context))
```

### Context Extensions

```dart
context.screenWidth   // Get screen width
context.screenHeight  // Get screen height
context.isMobile      // Check if mobile breakpoint
context.isTablet      // Check if tablet breakpoint
context.isDesktop     // Check if desktop breakpoint
```

## Responsive Layouts

### Using ResponsiveLayout Widget

When you need to change the layout structure based on breakpoints:

```dart
ResponsiveLayout(
  mobile: Column(
    children: [
      BoxA(),
      BoxB(),
    ],
  ),
  tablet: Row(
    children: [
      BoxA(),
      BoxB(),
    ],
  ),
  desktop: Row(
    children: [
      Expanded(child: BoxA()),
      Expanded(child: BoxB()),
    ],
  ),
)
```

### Using Context Extensions

For simple conditional rendering:

```dart
if (context.isMobile) {
  return MobileLayout();
} else if (context.isTablet) {
  return TabletLayout();
} else {
  return DesktopLayout();
}
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:sizekit/sizekit.dart';

void main() {
  runApp(
    SizeKit(
      designSize: const Size(375, 812),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SizeKit Example',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SizeKit',
          style: TextStyle(fontSize: 20.sp(context)),
        ),
      ),
      body: SingleChildScrollView(
        padding: 16.w(context).all,
        child: Column(
          children: [
            // Responsive card
            Container(
              width: double.infinity,
              padding: 16.w(context).all,
              margin: EdgeInsets.only(bottom: 16.h(context)),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12.r(context)),
              ),
              child: Text(
                'Responsive Card',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Spacing
            20.vSpace,
            
            // Responsive grid
            ResponsiveLayout(
              mobile: Column(
                children: [
                  _buildBox(context, Colors.red),
                  16.vSpace,
                  _buildBox(context, Colors.green),
                ],
              ),
              desktop: Row(
                children: [
                  Expanded(child: _buildBox(context, Colors.red)),
                  16.hSpace,
                  Expanded(child: _buildBox(context, Colors.green)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(BuildContext context, Color color) {
    return Container(
      height: 100.h(context),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r(context)),
      ),
      child: Center(
        child: Text(
          'Box',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp(context),
          ),
        ),
      ),
    );
  }
}
```

## Breakpoints

Default breakpoints (customizable via `SizeKit` widget):

- **Mobile**: < 480px
- **Tablet**: 768px - 1024px
- **Desktop**: ≥ 1024px

Custom breakpoints:

```dart
SizeKit(
  designSize: const Size(375, 812),
  breakpoints: const Breakpoints(
    mobile: 480,
    tablet: 768,
    desktop: 1024,
  ),
  child: MyApp(),
)
```

## Scaling Formulas

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

## Why SizeKit?

### Comparsion between SizeKit and Other Packages
| Features |  | `SizeKit` package  | Benefit |
| :--- | :--- | :--- | :--- |
| **Files** | several files(scattered or spreaded) | 4 files | Easier to maintain |
| **Performance** | `MediaQuery.of(context)` | `MediaQuery.sizeOf` | Prevents unnecessary rebuilds |
| **Syntax** | `MediaQuery.of(context).size.width * 0.20` | `20.w(context)` | 80% less typing |
| **Widgets** | Custom wrappers | Standard widgets | Full Flutter API access |
| **Setup** | Per-call params | InheritedWidget | Configure once |

## Best Practices

1. **Always wrap your app with SizeKit**
   ```dart
   void main() {
     runApp(SizeKit(designSize: Size(375, 812), child: MyApp()));
   }
   ```

2. **Use appropriate extension methods**
   - `.w()` for widths, padding, margins
   - `.h()` for heights
   - `.sp()` for font sizes (prevents oversized text)
   - `.r()` for border radius

3. **Use standard Flutter widgets**
   ```dart
   // Good
   Container(
     padding: 16.w(context).all,
     child: Text('Hello', style: TextStyle(fontSize: 18.sp(context))),
   )
   ```

4. **Leverage quick extensions**
   ```dart
   Column(
     children: [
       Widget1(),
       20.vSpace,  // Quick spacing
       Widget2(),
     ],
   )
   ```

5. **Use ResponsiveLayout for structure changes**
   ```dart
   ResponsiveLayout(
     mobile: Column(...),
     desktop: Row(...),
   )
   ```

## Architecture

SizeKit follows a minimal 4-file architecture:

```
lib/
├── sizekit.dart                 # Main export
└── src/
    ├── size_kit_widget.dart      # InheritedWidget configuration
    ├── extensions.dart           # Extension methods
    └── responsive_layout.dart    # Layout builder
```

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed documentation.

## Example App

Check out the [example](example/) directory for a complete working example demonstrating all features.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

## Support

For issues, questions, or contributions, please open an issue on GitHub.

---

**Version**: 1.0.0
