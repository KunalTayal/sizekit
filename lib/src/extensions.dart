import 'package:flutter/widgets.dart';
import 'size_kit_widget.dart';

// =============================================================================
// NUMBER EXTENSIONS (Scaling Logic)
// =============================================================================
extension SizeKitNum on num {
  // --- Figma Scaling ---

  /// Scale Width: Maps a Figma width pixel to the current screen width.
  /// Formula: (Input / DesignWidth) * ScreenWidth
  double w(BuildContext context) {
    final designW = SizeKit.of(context).designSize.width;
    final screenW = MediaQuery.sizeOf(context).width;
    return (toDouble() / designW) * screenW;
  }

  /// Scale Height: Maps a Figma height pixel to the current screen height.
  /// Formula: (Input / DesignHeight) * ScreenHeight
  double h(BuildContext context) {
    final designH = SizeKit.of(context).designSize.height;
    final screenH = MediaQuery.sizeOf(context).height;
    return (toDouble() / designH) * screenH;
  }

  /// Smart Font Size (Scalable Pixel).
  /// Scales linearly based on width but clamps to prevent massive text on tablets.
  /// Formula: Input * clampedScaleFactor(0.8 - 1.4)
  double sp(BuildContext context) {
    final designW = SizeKit.of(context).designSize.width;
    final screenW = MediaQuery.sizeOf(context).width;
    final scale = (screenW / designW).clamp(0.8, 1.4);
    return toDouble() * scale;
  }

  /// Radius scale (Alias for .w).
  /// Generally, radii should scale with width to maintain shape.
  double r(BuildContext context) => w(context);

  // --- Percentage Scaling ---

  /// Percentage of Screen Width (0.0 - 1.0).
  /// Example: 0.5.sw(context) = 50% of screen width.
  double sw(BuildContext context) =>
      MediaQuery.sizeOf(context).width * toDouble();

  /// Percentage of Screen Height (0.0 - 1.0).
  /// Example: 0.2.sh(context) = 20% of screen height.
  double sh(BuildContext context) =>
      MediaQuery.sizeOf(context).height * toDouble();

  // --- Spacing Widgets ---

  /// Returns a SizedBox with height = value.
  SizedBox get vSpace => SizedBox(height: toDouble());

  /// Returns a SizedBox with width = value.
  SizedBox get hSpace => SizedBox(width: toDouble());
}

// =============================================================================
// PADDING EXTENSIONS (Helpers)
// =============================================================================
extension SizeKitPadding on num {
  /// EdgeInsets.all(value)
  EdgeInsets get all => EdgeInsets.all(toDouble());

  /// EdgeInsets.symmetric(horizontal: value)
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());

  /// EdgeInsets.symmetric(vertical: value)
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get top => EdgeInsets.only(top: toDouble());
  EdgeInsets get bottom => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get left => EdgeInsets.only(left: toDouble());
  EdgeInsets get right => EdgeInsets.only(right: toDouble());
}

// =============================================================================
// CONTEXT EXTENSIONS (Responsive detection)
// =============================================================================
extension SizeKitContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isMobile => screenWidth < SizeKit.of(this).breakpoints.tablet;

  bool get isTablet =>
      screenWidth >= SizeKit.of(this).breakpoints.tablet &&
      screenWidth < SizeKit.of(this).breakpoints.desktop;

  bool get isDesktop => screenWidth >= SizeKit.of(this).breakpoints.desktop;
}
