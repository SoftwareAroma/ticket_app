import 'package:flutter/material.dart';

const accent = Color(0xFFEFE1E1);
const shade = Color(0xFF7C7C7C);
const gray = Color(0xFFD9D9D9);
const surface = Color(0xFF2F80ED);

CustomColors lightCustomColors = const CustomColors(
  sourceAccent: Color(0xFFEFE1E1),
  accent: Color(0xFF9C404D),
  onAccent: Color(0xFFFFFFFF),
  accentContainer: Color(0xFFFFDADB),
  onAccentContainer: Color(0xFF40000F),
  sourceShade: Color(0xFF7C7C7C),
  shade: Color(0xFF006874),
  onShade: Color(0xFFFFFFFF),
  shadeContainer: Color(0xFF97F0FF),
  onShadeContainer: Color(0xFF001F24),
  sourceGray: Color(0xFFD9D9D9),
  gray: Color(0xFF006874),
  onGray: Color(0xFFFFFFFF),
  grayContainer: Color(0xFF97F0FF),
  onGrayContainer: Color(0xFF001F24),
  sourceSurface: Color(0xFF2F80ED),
  surface: Color(0xFF005CBA),
  onSurface: Color(0xFFFFFFFF),
  surfaceContainer: Color(0xFFD7E3FF),
  onSurfaceContainer: Color(0xFF001B3F),
);

CustomColors darkCustomColors = const CustomColors(
  sourceAccent: Color(0xFFEFE1E1),
  accent: Color(0xFFFFB2B9),
  onAccent: Color(0xFF5F1222),
  accentContainer: Color(0xFF7D2937),
  onAccentContainer: Color(0xFFFFDADB),
  sourceShade: Color(0xFF7C7C7C),
  shade: Color(0xFF4FD8EB),
  onShade: Color(0xFF00363D),
  shadeContainer: Color(0xFF004F58),
  onShadeContainer: Color(0xFF97F0FF),
  sourceGray: Color(0xFFD9D9D9),
  gray: Color(0xFF4FD8EB),
  onGray: Color(0xFF00363D),
  grayContainer: Color(0xFF004F58),
  onGrayContainer: Color(0xFF97F0FF),
  sourceSurface: Color(0xFF2F80ED),
  surface: Color(0xFFABC7FF),
  onSurface: Color(0xFF002F65),
  surfaceContainer: Color(0xFF00458E),
  onSurfaceContainer: Color(0xFFD7E3FF),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceAccent,
    required this.accent,
    required this.onAccent,
    required this.accentContainer,
    required this.onAccentContainer,
    required this.sourceShade,
    required this.shade,
    required this.onShade,
    required this.shadeContainer,
    required this.onShadeContainer,
    required this.sourceGray,
    required this.gray,
    required this.onGray,
    required this.grayContainer,
    required this.onGrayContainer,
    required this.sourceSurface,
    required this.surface,
    required this.onSurface,
    required this.surfaceContainer,
    required this.onSurfaceContainer,
  });

  final Color? sourceAccent;
  final Color? accent;
  final Color? onAccent;
  final Color? accentContainer;
  final Color? onAccentContainer;
  final Color? sourceShade;
  final Color? shade;
  final Color? onShade;
  final Color? shadeContainer;
  final Color? onShadeContainer;
  final Color? sourceGray;
  final Color? gray;
  final Color? onGray;
  final Color? grayContainer;
  final Color? onGrayContainer;
  final Color? sourceSurface;
  final Color? surface;
  final Color? onSurface;
  final Color? surfaceContainer;
  final Color? onSurfaceContainer;

  @override
  CustomColors copyWith({
    Color? sourceAccent,
    Color? accent,
    Color? onAccent,
    Color? accentContainer,
    Color? onAccentContainer,
    Color? sourceShade,
    Color? shade,
    Color? onShade,
    Color? shadeContainer,
    Color? onShadeContainer,
    Color? sourceGray,
    Color? gray,
    Color? onGray,
    Color? grayContainer,
    Color? onGrayContainer,
    Color? sourceSurface,
    Color? surface,
    Color? onSurface,
    Color? surfaceContainer,
    Color? onSurfaceContainer,
  }) {
    return CustomColors(
      sourceAccent: sourceAccent ?? this.sourceAccent,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      accentContainer: accentContainer ?? this.accentContainer,
      onAccentContainer: onAccentContainer ?? this.onAccentContainer,
      sourceShade: sourceShade ?? this.sourceShade,
      shade: shade ?? this.shade,
      onShade: onShade ?? this.onShade,
      shadeContainer: shadeContainer ?? this.shadeContainer,
      onShadeContainer: onShadeContainer ?? this.onShadeContainer,
      sourceGray: sourceGray ?? this.sourceGray,
      gray: gray ?? this.gray,
      onGray: onGray ?? this.onGray,
      grayContainer: grayContainer ?? this.grayContainer,
      onGrayContainer: onGrayContainer ?? this.onGrayContainer,
      sourceSurface: sourceSurface ?? this.sourceSurface,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      onSurfaceContainer: onSurfaceContainer ?? this.onSurfaceContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceAccent: Color.lerp(sourceAccent, other.sourceAccent, t),
      accent: Color.lerp(accent, other.accent, t),
      onAccent: Color.lerp(onAccent, other.onAccent, t),
      accentContainer: Color.lerp(accentContainer, other.accentContainer, t),
      onAccentContainer: Color.lerp(onAccentContainer, other.onAccentContainer, t),
      sourceShade: Color.lerp(sourceShade, other.sourceShade, t),
      shade: Color.lerp(shade, other.shade, t),
      onShade: Color.lerp(onShade, other.onShade, t),
      shadeContainer: Color.lerp(shadeContainer, other.shadeContainer, t),
      onShadeContainer: Color.lerp(onShadeContainer, other.onShadeContainer, t),
      sourceGray: Color.lerp(sourceGray, other.sourceGray, t),
      gray: Color.lerp(gray, other.gray, t),
      onGray: Color.lerp(onGray, other.onGray, t),
      grayContainer: Color.lerp(grayContainer, other.grayContainer, t),
      onGrayContainer: Color.lerp(onGrayContainer, other.onGrayContainer, t),
      sourceSurface: Color.lerp(sourceSurface, other.sourceSurface, t),
      surface: Color.lerp(surface, other.surface, t),
      onSurface: Color.lerp(onSurface, other.onSurface, t),
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t),
      onSurfaceContainer: Color.lerp(onSurfaceContainer, other.onSurfaceContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith();
  }
}
