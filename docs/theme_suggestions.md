**Suggestions**
The following code represents suggestions for theming. Do not override any of the core principles of the app. 


import 'package:flutter/material.dart';
import 'dart:ui';

// Theme Service matching your existing structure
class ThemeService {
  // Regular Theme Colors (Modern UI - New)
  static const Color lightPrimary = Color(0xFF7B3FF2);      // Modern purple
  static const Color lightSecondary = Color(0xFF2E3FF2);    // Modern blue
  static const Color darkPrimary = Color(0xFF9B5FFF);       // Lighter purple for dark
  static const Color darkSecondary = Color(0xFF5E7FFF);     // Lighter blue for dark
  
  // Low-Stim Theme Colors (Keeping your existing)
  static const Color lightLowStimPrimary = Color(0xFFC9C9C9);    // Cool grey
  static const Color lightLowStimSecondary = Color(0xFFC9C9C9);  // Same neutral
  static const Color darkLowStimPrimary = Color(0xFFAAAAAA);     // Neutral grey
  static const Color darkLowStimSecondary = Color(0xFFAAAAAA);   // Same neutral
  
  // Background Colors
  static const Color lightBackground = Color(0xFFF9F9F9);
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color lightLowStimBackground = Color(0xFFFAFAFA);
  static const Color darkLowStimBackground = Color(0xFF111113);
  
  // Surface Colors
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color lightLowStimSurface = Color(0xFFFFFFFF);
  static const Color darkLowStimSurface = Color(0xFF1A1A1A);
  
  // Text Colors
  static const Color lightOnSurface = Color(0xFF1C1C1E);
  static const Color darkOnSurface = Color(0xFFEDEDED);
  static const Color lightLowStimOnSurface = Color(0xFF2E2E2E);
  static const Color darkLowStimOnSurface = Color(0xFFDDDDDD);

  // Light Regular Theme (Modern UI)
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      surface: lightSurface,
      background: lightBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: lightOnSurface,
      onBackground: lightOnSurface,
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: lightSurface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: lightOnSurface,
    ),
    splashFactory: InkRipple.splashFactory,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  // Dark Regular Theme (Modern UI)
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      surface: darkSurface,
      background: darkBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: darkOnSurface,
      onBackground: darkOnSurface,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: darkSurface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: darkOnSurface,
    ),
    splashFactory: InkRipple.splashFactory,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  // Light Low-Stim Theme (Your existing)
  static final ThemeData lightLowStimTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightLowStimBackground,
    colorScheme: const ColorScheme.light(
      primary: lightLowStimPrimary,
      secondary: lightLowStimSecondary,
      surface: lightLowStimSurface,
      background: lightLowStimBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: lightLowStimOnSurface,
      onBackground: lightLowStimOnSurface,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: const BorderSide(color: lightLowStimPrimary, width: 1),
      ),
      color: lightLowStimSurface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: lightLowStimPrimary),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: lightLowStimBackground,
      foregroundColor: lightLowStimOnSurface,
    ),
    splashFactory: NoSplash.splashFactory,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );

  // Dark Low-Stim Theme (Your existing)
  static final ThemeData darkLowStimTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkLowStimBackground,
    colorScheme: const ColorScheme.dark(
      primary: darkLowStimPrimary,
      secondary: darkLowStimSecondary,
      surface: darkLowStimSurface,
      background: darkLowStimBackground,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: darkLowStimOnSurface,
      onBackground: darkLowStimOnSurface,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: const BorderSide(color: darkLowStimPrimary, width: 1),
      ),
      color: darkLowStimSurface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: darkLowStimPrimary),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: darkLowStimBackground,
      foregroundColor: darkLowStimOnSurface,
    ),
    splashFactory: NoSplash.splashFactory,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );

  // Helper method to get theme based on settings
  static ThemeData getTheme({required bool isDark, required bool isLowStim}) {
    if (isLowStim) {
      return isDark ? darkLowStimTheme : lightLowStimTheme;
    } else {
      return isDark ? darkTheme : lightTheme;
    }
  }
}

// Modern UI Components for Regular Themes

// Gradient Background Widget
class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool isDark;
  
  const GradientBackground({
    Key? key, 
    required this.child,
    required this.isDark,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isDark 
          ? RadialGradient(
              center: Alignment.topCenter,
              radius: 1.5,
              colors: [
                ThemeService.darkPrimary.withOpacity(0.3),
                ThemeService.darkSecondary.withOpacity(0.2),
                ThemeService.darkBackground,
              ],
            )
          : LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ThemeService.lightBackground,
                ThemeService.lightPrimary.withOpacity(0.05),
                ThemeService.lightSecondary.withOpacity(0.05),
                ThemeService.lightBackground,
              ],
            ),
      ),
      child: child,
    );
  }
}

// Glassmorphic Card Widget
class GlassCard extends StatelessWidget {
  final Widget child;
  final bool isDark;
  final bool isLowStim;
  final double? blur;
  final double? opacity;
  final EdgeInsets padding;
  final double? borderRadius;
  
  const GlassCard({
    Key? key,
    required this.child,
    required this.isDark,
    this.isLowStim = false,
    this.blur,
    this.opacity,
    this.padding = const EdgeInsets.all(20),
    this.borderRadius,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // For low-stim modes, return a simple bordered container
    if (isLowStim) {
      return Container(
        padding: padding,
        decoration: BoxDecoration(
          color: isDark ? ThemeService.darkLowStimSurface : ThemeService.lightLowStimSurface,
          border: Border.all(
            color: isDark ? ThemeService.darkLowStimPrimary : ThemeService.lightLowStimPrimary,
            width: 1,
          ),
        ),
        child: child,
      );
    }
    
    // Modern glassmorphic effect for regular themes
    final effectiveBlur = blur ?? (isDark ? 10.0 : 20.0);
    final effectiveOpacity = opacity ?? (isDark ? 0.1 : 0.7);
    final effectiveBorderRadius = borderRadius ?? 20.0;
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: isDark 
              ? Colors.white.withOpacity(effectiveOpacity)
              : Colors.white.withOpacity(effectiveOpacity),
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            border: Border.all(
              color: isDark 
                ? Colors.white.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: isDark ? [] : [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// Custom Gradient Button
class ModernButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDark;
  final bool isLowStim;
  final bool isOutlined;
  
  const ModernButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isDark,
    this.isLowStim = false,
    this.isOutlined = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Low-stim button (always outlined with square edges)
    if (isLowStim) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          side: BorderSide(
            color: isDark ? ThemeService.darkLowStimPrimary : ThemeService.lightLowStimPrimary,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isDark ? ThemeService.darkLowStimOnSurface : ThemeService.lightLowStimOnSurface,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    
    // Regular theme button
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    
    // Gradient filled button for regular themes
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(isDark ? 0.3 : 0.2),
              blurRadius: isDark ? 20 : 15,
              offset: Offset(0, isDark ? 10 : 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// Example Screen showing all themes
class ExampleScreen extends StatelessWidget {
  final bool isDark;
  final bool isLowStim;
  
  const ExampleScreen({
    Key? key,
    required this.isDark,
    required this.isLowStim,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Low-stim mode: simple, no gradients or glass effects
    if (isLowStim) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Low-Stim Mode'),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Minimal Stimulation Design',
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Neutral colors, no animations, flat design',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ModernButton(
                text: 'Low-Stim Button',
                onPressed: () {},
                isDark: isDark,
                isLowStim: true,
              ),
            ],
          ),
        ),
      );
    }
    
    // Regular theme: modern UI with gradients and glass
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: GradientBackground(
        isDark: isDark,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppBar(
                  title: const Text('Modern UI Theme'),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                const SizedBox(height: 32),
                GlassCard(
                  isDark: isDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Glassmorphic Design',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Modern UI with blur effects and gradients',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ModernButton(
                  text: 'Gradient Button',
                  onPressed: () {},
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                ModernButton(
                  text: 'Outlined Button',
                  onPressed: () {},
                  isDark: isDark,
                  isOutlined: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Example app with theme switching
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;
  bool _isLowStim = false;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Flutter UI',
      theme: ThemeService.getTheme(isDark: _isDark, isLowStim: _isLowStim),
      home: Scaffold(
        body: ExampleScreen(isDark: _isDark, isLowStim: _isLowStim),
        bottomNavigationBar: Container(
          color: _isDark 
            ? (_isLowStim ? ThemeService.darkLowStimBackground : ThemeService.darkBackground)
            : (_isLowStim ? ThemeService.lightLowStimBackground : ThemeService.lightBackground),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () => setState(() => _isDark = !_isDark),
                    icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
                    label: Text(_isDark ? 'Light' : 'Dark'),
                  ),
                  TextButton.icon(
                    onPressed: () => setState(() => _isLowStim = !_isLowStim),
                    icon: Icon(_isLowStim ? Icons.visibility : Icons.visibility_off),
                    label: Text(_isLowStim ? 'Regular' : 'Low-Stim'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}