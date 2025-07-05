import 'package:flutter/material.dart';
import '../../../../core/widgets/liquid_glass_container.dart';

/// Widget displaying a single HRV score with visual indicators
class ScoreCard extends StatefulWidget {
  final String title;
  final int score;
  final int maxScore;
  final Color color;
  final IconData icon;
  final String subtitle;

  const ScoreCard({
    super.key,
    required this.title,
    required this.score,
    required this.maxScore,
    required this.color,
    required this.icon,
    required this.subtitle,
  });

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scoreAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scoreAnimation = Tween<double>(
      begin: 0.0,
      end: widget.score / widget.maxScore,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ),);

    // Start animation after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void didUpdateWidget(ScoreCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      _scoreAnimation = Tween<double>(
        begin: _scoreAnimation.value,
        end: widget.score / widget.maxScore,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),);
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Use Liquid Glass container for modern glass effect
    return LiquidGlassContainer(
      elevation: 2,
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon and title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                widget.icon,
                color: widget.color,
                size: 24,
              ),
              Text(
                widget.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Circular progress indicator with score
          SizedBox(
            width: 80,
            height: 80,
            child: AnimatedBuilder(
              animation: _scoreAnimation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 6,
                        backgroundColor: widget.color.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.color.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    // Progress circle
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: _scoreAnimation.value,
                        strokeWidth: 6,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                      ),
                    ),
                    // Score text
                    AnimatedBuilder(
                      animation: _scoreAnimation,
                      builder: (context, child) {
                        final animatedScore = (_scoreAnimation.value * widget.score).round();
                        return Text(
                          '$animatedScore',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Subtitle
          Text(
            widget.subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Animated score card with pulse effect for emphasis
class AnimatedScoreCard extends StatefulWidget {
  final String title;
  final int score;
  final int maxScore;
  final Color color;
  final IconData icon;
  final String subtitle;
  final bool isPrimary;

  const AnimatedScoreCard({
    super.key,
    required this.title,
    required this.score,
    required this.maxScore,
    required this.color,
    required this.icon,
    required this.subtitle,
    this.isPrimary = false,
  });

  @override
  State<AnimatedScoreCard> createState() => _AnimatedScoreCardState();
}

class _AnimatedScoreCardState extends State<AnimatedScoreCard>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _scoreController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scoreAnimation;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ),);

    _scoreAnimation = Tween<double>(
      begin: 0.0,
      end: widget.score / widget.maxScore,
    ).animate(CurvedAnimation(
      parent: _scoreController,
      curve: Curves.easeOutCubic,
    ),);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scoreController.forward();
      if (widget.isPrimary) {
        _pulseController.repeat(reverse: true);
      }
    });
  }

  @override
  void didUpdateWidget(AnimatedScoreCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score != widget.score) {
      _scoreAnimation = Tween<double>(
        begin: _scoreAnimation.value,
        end: widget.score / widget.maxScore,
      ).animate(CurvedAnimation(
        parent: _scoreController,
        curve: Curves.easeOutCubic,
      ),);
      _scoreController.forward(from: 0);
    }

    if (oldWidget.isPrimary != widget.isPrimary) {
      if (widget.isPrimary) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isPrimary ? _pulseAnimation.value : 1.0,
          child: LiquidGlassContainer(
            elevation: widget.isPrimary ? 3 : 2, // Higher elevation for primary
            padding: const EdgeInsets.all(16),
            borderRadius: BorderRadius.circular(16),
            color: widget.isPrimary 
                ? widget.color.withValues(alpha: 0.05)
                : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon and title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      widget.icon,
                      color: widget.color,
                      size: 24,
                    ),
                    Text(
                      widget.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Circular progress indicator with score
                SizedBox(
                  width: 80,
                  height: 80,
                  child: AnimatedBuilder(
                    animation: _scoreAnimation,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background circle
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              value: 1.0,
                              strokeWidth: 6,
                              backgroundColor: widget.color.withValues(alpha: 0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.color.withValues(alpha: 0.1),
                              ),
                            ),
                          ),
                          // Progress circle
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              value: _scoreAnimation.value,
                              strokeWidth: 6,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                            ),
                          ),
                          // Score text
                          AnimatedBuilder(
                            animation: _scoreAnimation,
                            builder: (context, child) {
                              final animatedScore = (_scoreAnimation.value * widget.score).round();
                              return Text(
                                '$animatedScore',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  widget.subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}