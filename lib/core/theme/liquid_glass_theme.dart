import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Liquid Glass design tokens for iOS 26+ with graceful fallbacks
class LiquidGlassTheme {
  // Design tokens from Figma
  static const double _blurRadius = 28.0;
  static const double _borderRadius = 8.0;
  static const Duration _animationDuration = Duration(milliseconds: 250);
  static const Curve _animationCurve = Curves.easeOut;
  
  // Elevation scale for Glass-00 through Glass-06
  static const Map<int, LiquidGlassElevation> _elevationScale = {
    0: LiquidGlassElevation(blur: 8.0, opacity: 0.08, shadowElevation: 0),
    1: LiquidGlassElevation(blur: 12.0, opacity: 0.12, shadowElevation: 1),
    2: LiquidGlassElevation(blur: 16.0, opacity: 0.16, shadowElevation: 2),
    3: LiquidGlassElevation(blur: 20.0, opacity: 0.20, shadowElevation: 4),
    4: LiquidGlassElevation(blur: 24.0, opacity: 0.24, shadowElevation: 6),
    5: LiquidGlassElevation(blur: 28.0, opacity: 0.28, shadowElevation: 8),
    6: LiquidGlassElevation(blur: 32.0, opacity: 0.32, shadowElevation: 12),
  };

  /// Check if device supports native Liquid Glass
  static bool get isLiquidGlassSupported {
    if (kIsWeb) return false; // Web doesn't support native glass
    
    // Check if running on iOS
    if (defaultTargetPlatform != TargetPlatform.iOS) return false;
    
    // TODO: Add actual iOS version check when iOS 26 is available
    // For now, simulate support on iOS devices
    return true;
  }

  /// Get elevation configuration for glass level
  static LiquidGlassElevation elevationFor(int level) {
    return _elevationScale[level.clamp(0, 6)] ?? _elevationScale[1]!;
  }

  /// Get dynamic tint color based on system theme and wallpaper
  static Color getDynamicTint(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primaryColor = theme.colorScheme.primary;
    
    if (isLiquidGlassSupported) {
      // On iOS 26+, this would sample from wallpaper
      // For now, derive from primary color
      return brightness == Brightness.light
          ? primaryColor.withValues(alpha: 0.12)
          : primaryColor.withValues(alpha: 0.18);
    }
    
    // Fallback tint for older devices
    return brightness == Brightness.light
        ? Colors.white.withValues(alpha: 0.12)
        : Colors.black.withValues(alpha: 0.18);
  }

  /// Get glass overlay color for light/dark mode
  static Color getGlassOverlay(BuildContext context, int elevation) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final elevationConfig = elevationFor(elevation);
    
    return brightness == Brightness.light
        ? Colors.white.withValues(alpha: elevationConfig.opacity)
        : Colors.black.withValues(alpha: elevationConfig.opacity);
  }

  /// Animation configuration for liquid glass effects
  static const Duration animationDuration = _animationDuration;
  static const Curve animationCurve = _animationCurve;
  static const double blurRadius = _blurRadius;
  static const double borderRadius = _borderRadius;
  
  /// Specular highlight configuration
  static const double maxParallaxOffset = 6.0;
  static const double springDamping = 0.8;
  
  /// Performance limits
  static const int maxSimultaneousLayers = 3;
  static const String minRequiredChip = 'A14';
  
  /// Accessibility contrast ratios
  static const double minContrastRatio = 4.5;
}

/// Configuration for a specific glass elevation level
class LiquidGlassElevation {
  const LiquidGlassElevation({
    required this.blur,
    required this.opacity,
    required this.shadowElevation,
  });

  final double blur;
  final double opacity;
  final double shadowElevation;
}

/// Liquid Glass color scheme extensions
extension LiquidGlassColorScheme on ColorScheme {
  /// Liquid primary color with dynamic tint
  Color get liquidPrimary => primary.withValues(alpha: 0.85);
  
  /// Liquid secondary color with dynamic tint
  Color get liquidSecondary => secondary.withValues(alpha: 0.75);
  
  /// Glass surface color for containers
  Color get glassSurface => surface.withValues(alpha: 0.9);
  
  /// Glass background for elevated surfaces
  Color get glassBackground => surface.withValues(alpha: 0.95);
}

/// Material 3 theme with Liquid Glass integration
class LiquidGlassMaterial3Theme {
  static ThemeData lightTheme(ColorScheme? colorScheme) {
    final scheme = colorScheme ?? _defaultLightColorScheme;
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // Enhanced glass-like surfaces
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.glassSurface,
        surfaceTintColor: scheme.liquidPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LiquidGlassTheme.borderRadius),
        ),
      ),
      // Navigation bars with glass effect
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.glassSurface,
        surfaceTintColor: scheme.liquidPrimary,
        indicatorColor: scheme.liquidPrimary,
        elevation: 0,
      ),
      // App bars with glass background
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.glassBackground,
        surfaceTintColor: scheme.liquidPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      // Elevated buttons with glass effect
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.liquidPrimary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LiquidGlassTheme.borderRadius),
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme(ColorScheme? colorScheme) {
    final scheme = colorScheme ?? _defaultDarkColorScheme;
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // Enhanced glass-like surfaces for dark mode
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.glassSurface,
        surfaceTintColor: scheme.liquidPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LiquidGlassTheme.borderRadius),
        ),
      ),
      // Navigation bars with glass effect
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.glassSurface,
        surfaceTintColor: scheme.liquidPrimary,
        indicatorColor: scheme.liquidPrimary,
        elevation: 0,
      ),
      // App bars with glass background
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.glassBackground,
        surfaceTintColor: scheme.liquidPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      // Elevated buttons with glass effect
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.liquidPrimary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LiquidGlassTheme.borderRadius),
          ),
        ),
      ),
    );
  }

  static const ColorScheme _defaultLightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6750A4),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF625B71),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFFFEFBFF),
    onSurface: Color(0xFF1C1B1F),
  );

  static const ColorScheme _defaultDarkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFD0BCFF),
    onPrimary: Color(0xFF381E72),
    secondary: Color(0xFFCCC2DC),
    onSecondary: Color(0xFF332D41),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    surface: Color(0xFF1C1B1F),
    onSurface: Color(0xFFE6E1E5),
  );
}