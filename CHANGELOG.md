# 1.0.0

## Added
- Initial release of SizeKit
- **Core Features:**
  - `SizeKit` InheritedWidget for global configuration
  - `Breakpoints` class for customizable breakpoint definitions
  - Extension methods on `num` type:
    - `.w(context)` - Scale width from Figma design
    - `.h(context)` - Scale height from Figma design
    - `.sp(context)` - Smart font size scaling (clamped 0.8x - 1.4x)
    - `.r(context)` - Border radius scaling (alias for `.w()`)
    - `.sw(context)` - Screen width percentage (0.0 - 1.0)
    - `.sh(context)` - Screen height percentage (0.0 - 1.0)
    - `.vSpace` - SizedBox with height
    - `.hSpace` - SizedBox with width
  - Padding extension methods:
    - `.all` - EdgeInsets.all()
    - `.horizontal` - EdgeInsets.symmetric(horizontal:)
    - `.vertical` - EdgeInsets.symmetric(vertical:)
    - `.top`, `.bottom`, `.left`, `.right` - EdgeInsets.only()
  - BuildContext extensions:
    - `context.screenWidth` - Get screen width
    - `context.screenHeight` - Get screen height
    - `context.isMobile` - Check if mobile breakpoint
    - `context.isTablet` - Check if tablet breakpoint
    - `context.isDesktop` - Check if desktop breakpoint
  - `ResponsiveLayout` widget for breakpoint-based layout switching

- Uses `MediaQuery.sizeOf(context)` instead of `MediaQuery.of(context)` to prevent unnecessary rebuilds
- InheritedWidget only rebuilds when design size or breakpoints change
- Zero-cost extension method abstractions
- Comprehensive README with usage examples
- Detailed ARCHITECTURE.md documentation
- Complete example app demonstrating all features
- Inline code documentation

- Minimal 4-file structure:
  - `size_kit_widget.dart` - InheritedWidget configuration
  - `extensions.dart` - Extension methods
  - `responsive_layout.dart` - Layout builder
  - `sizekit.dart` - Main export file

---

