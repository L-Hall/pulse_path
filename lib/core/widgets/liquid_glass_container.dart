import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import '../theme/liquid_glass_theme.dart';

/// A container that applies Liquid Glass visual effects
/// 
/// On iOS 26+, uses native UILiquidGlassMaterial for authentic glass effect.
/// On older iOS and Android, falls back to BackdropFilter with blur and tint.
class LiquidGlassContainer extends StatefulWidget {
  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.elevation = 1,
    this.borderRadius,
    this.color,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.clipBehavior = Clip.antiAlias,
    this.animateOnTap = true,
  });

  final Widget child;
  final int elevation;
  final BorderRadius? borderRadius;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Clip clipBehavior;
  final bool animateOnTap;

  @override
  State<LiquidGlassContainer> createState() => _LiquidGlassContainerState();
}

class _LiquidGlassContainerState extends State<LiquidGlassContainer>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  
  static const MethodChannel _channel = MethodChannel('liquid_glass');

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _scaleController = AnimationController(
      duration: LiquidGlassTheme.animationDuration,
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: LiquidGlassTheme.animationCurve,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  Future<void> _updateNativeTint() async {
    if (!LiquidGlassTheme.isLiquidGlassSupported) return;
    
    try {
      final tintColor = LiquidGlassTheme.getDynamicTint(context);
      await _channel.invokeMethod('setTint', {
        'red': (tintColor.r * 255.0).round(),
        'green': (tintColor.g * 255.0).round(),
        'blue': (tintColor.b * 255.0).round(),
        'alpha': (tintColor.a * 255.0).round(),
      });
    } catch (e) {
      // Fallback silently if native bridge fails
      debugPrint('LiquidGlass native tint update failed: $e');
    }
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.animateOnTap) return;
    _scaleController.forward();
    _glowController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.animateOnTap) return;
    _scaleController.reverse();
    _glowController.reverse();
  }

  void _onTapCancel() {
    if (!widget.animateOnTap) return;
    _scaleController.reverse();
    _glowController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _glowAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: _buildGlassEffect(context),
          );
        },
      ),
    );
  }

  Widget _buildGlassEffect(BuildContext context) {
    final borderRadius = widget.borderRadius ?? 
        BorderRadius.circular(LiquidGlassTheme.borderRadius);
    
    if (LiquidGlassTheme.isLiquidGlassSupported && !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return _buildNativeGlassEffect(borderRadius);
    } else {
      return _buildFallbackGlassEffect(context, borderRadius);
    }
  }

  Widget _buildNativeGlassEffect(BorderRadius borderRadius) {
    // Use native iOS UILiquidGlassMaterial via platform view
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: widget.clipBehavior,
      child: Stack(
        children: [
          UiKitView(
            viewType: 'liquid_glass_view',
            creationParams: {
              'elevation': widget.elevation,
              'borderRadius': LiquidGlassTheme.borderRadius,
            },
            creationParamsCodec: const StandardMessageCodec(),
          ),
          GestureDetector(
            onTapDown: widget.onTap != null ? _onTapDown : null,
            onTapUp: widget.onTap != null ? _onTapUp : null,
            onTapCancel: widget.onTap != null ? _onTapCancel : null,
            onTap: widget.onTap,
            child: _buildChildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackGlassEffect(BuildContext context, BorderRadius borderRadius) {
    final elevationConfig = LiquidGlassTheme.elevationFor(widget.elevation);
    final dynamicTint = LiquidGlassTheme.getDynamicTint(context);
    final glassOverlay = LiquidGlassTheme.getGlassOverlay(context, widget.elevation);
    
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: widget.clipBehavior,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: elevationConfig.blur,
          sigmaY: elevationConfig.blur,
        ),
        child: AnimatedContainer(
          duration: LiquidGlassTheme.animationDuration,
          curve: LiquidGlassTheme.animationCurve,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: widget.color ?? glassOverlay,
            border: Border.all(
              color: dynamicTint.withValues(alpha: 0.2),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: dynamicTint.withValues(alpha: 0.1 * _glowAnimation.value),
                blurRadius: elevationConfig.shadowElevation + (8 * _glowAnimation.value),
                offset: Offset(0, elevationConfig.shadowElevation / 2),
              ),
            ],
          ),
          child: GestureDetector(
            onTapDown: widget.onTap != null ? _onTapDown : null,
            onTapUp: widget.onTap != null ? _onTapUp : null,
            onTapCancel: widget.onTap != null ? _onTapCancel : null,
            onTap: widget.onTap,
            child: _buildChildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildChildContent() {
    Widget content = widget.child;
    
    if (widget.padding != null) {
      content = Padding(
        padding: widget.padding!,
        child: content,
      );
    }
    
    return content;
  }
}

/// Specialized Liquid Glass button with enhanced interaction
class LiquidGlassButton extends StatelessWidget {
  const LiquidGlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.elevation = 2,
    this.borderRadius,
    this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  final VoidCallback? onPressed;
  final Widget child;
  final int elevation;
  final BorderRadius? borderRadius;
  final Color? color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      elevation: elevation,
      borderRadius: borderRadius,
      color: color,
      padding: padding,
      onTap: onPressed,
      animateOnTap: true,
      child: child,
    );
  }
}

/// Liquid Glass card for content containers
class LiquidGlassCard extends StatelessWidget {
  const LiquidGlassCard({
    super.key,
    required this.child,
    this.elevation = 1,
    this.borderRadius,
    this.color,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.onTap,
  });

  final Widget child;
  final int elevation;
  final BorderRadius? borderRadius;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      elevation: elevation,
      borderRadius: borderRadius,
      color: color,
      padding: padding,
      margin: margin,
      onTap: onTap,
      child: child,
    );
  }
}

/// Performance monitoring widget for Liquid Glass effects
class LiquidGlassPerformanceMonitor extends StatefulWidget {
  const LiquidGlassPerformanceMonitor({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<LiquidGlassPerformanceMonitor> createState() => 
      _LiquidGlassPerformanceMonitorState();
}

class _LiquidGlassPerformanceMonitorState 
    extends State<LiquidGlassPerformanceMonitor> {
  int _activeGlassLayers = 0;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _incrementGlassLayers() {
    setState(() {
      _activeGlassLayers++;
      if (_activeGlassLayers > LiquidGlassTheme.maxSimultaneousLayers) {
        debugPrint(
          'Warning: ${_activeGlassLayers} Liquid Glass layers active. '
          'Consider reducing for performance.'
        );
      }
    });
  }

  void _decrementGlassLayers() {
    setState(() {
      _activeGlassLayers = (_activeGlassLayers - 1).clamp(0, double.infinity).toInt();
    });
  }
}