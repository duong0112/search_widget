import 'dart:ui';

extension ColorOpacityExtension on Color {
  /// Chuyển opacity (0.0 - 1.0) sang alpha (0 - 255)
  static int opacityToAlpha(double opacity) {
    return (opacity.clamp(0.0, 1.0) * 255).round();
  }

  /// Tạo Color mới từ opacity
  Color withOpacityAlpha(double opacity) {
    return withAlpha(opacityToAlpha(opacity));
  }
}