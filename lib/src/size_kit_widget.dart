import 'package:flutter/widgets.dart';

/// Defines the width boundaries for different device types.
class Breakpoints {
  final double mobile;
  final double tablet;
  final double desktop;

  const Breakpoints({
    this.mobile = 480,
    this.tablet = 768,
    this.desktop = 1024,
  });
}

/// The Root Widget to configure SizeKit.
/// Wrap your MaterialApp/CupertinoApp with this.
class SizeKit extends InheritedWidget {
  final Size designSize;
  final Breakpoints breakpoints;

  const SizeKit({
    super.key,
    required super.child,
    this.designSize = const Size(375, 812), // Default Figma Mobile Frame
    this.breakpoints = const Breakpoints(),
  });

  /// Accessor to get the nearest SizeKit instance.
  static SizeKit of(BuildContext context) {
    final SizeKit? result =
        context.dependOnInheritedWidgetOfExactType<SizeKit>();
    assert(result != null,
        'No SizeKit found in context. Wrap your app in SizeKit().');
    return result!;
  }

  @override
  bool updateShouldNotify(SizeKit oldWidget) =>
      designSize != oldWidget.designSize ||
      breakpoints.mobile != oldWidget.breakpoints.mobile;
}
