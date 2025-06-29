import 'package:flutter/material.dart';
import '../../../../core/widgets/liquid_glass_container.dart';
import '../../../../core/theme/liquid_glass_theme.dart';

/// Demo page showcasing Liquid Glass UI components
class LiquidGlassDemoPage extends StatefulWidget {
  const LiquidGlassDemoPage({super.key});

  @override
  State<LiquidGlassDemoPage> createState() => _LiquidGlassDemoPageState();
}

class _LiquidGlassDemoPageState extends State<LiquidGlassDemoPage> {
  int selectedElevation = 2;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liquid Glass UI'),
        backgroundColor: LiquidGlassTheme.isLiquidGlassSupported
            ? Colors.transparent
            : null,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: Theme(
        data: isDarkMode 
            ? LiquidGlassMaterial3Theme.darkTheme(null)
            : LiquidGlassMaterial3Theme.lightTheme(null),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode ? [
                const Color(0xFF1a1a2e),
                const Color(0xFF16213e),
                const Color(0xFF0f3460),
              ] : [
                const Color(0xFFe3f2fd),
                const Color(0xFFbbdefb),
                const Color(0xFF90caf9),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  const SizedBox(height: 24),
                  _buildElevationSelector(),
                  const SizedBox(height: 24),
                  _buildGlassContainers(),
                  const SizedBox(height: 24),
                  _buildGlassButtons(),
                  const SizedBox(height: 24),
                  _buildGlassCards(),
                  const SizedBox(height: 24),
                  _buildHRVStyleDemo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return LiquidGlassCard(
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LiquidGlassTheme.isLiquidGlassSupported 
                    ? Icons.check_circle 
                    : Icons.info,
                color: LiquidGlassTheme.isLiquidGlassSupported 
                    ? Colors.green 
                    : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                LiquidGlassTheme.isLiquidGlassSupported 
                    ? 'Native Liquid Glass Active'
                    : 'Fallback Mode Active',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            LiquidGlassTheme.isLiquidGlassSupported
                ? 'Using iOS 26+ UILiquidGlassMaterial for authentic glass effects with dynamic wallpaper tinting.'
                : 'Using BackdropFilter fallback with blur and tint effects for compatibility.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildElevationSelector() {
    return LiquidGlassCard(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Glass Elevation',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: List.generate(7, (index) {
              final isSelected = selectedElevation == index;
              return LiquidGlassButton(
                elevation: isSelected ? 3 : 1,
                onPressed: () {
                  setState(() {
                    selectedElevation = index;
                  });
                },
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                    : null,
                child: Text('$index'),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassContainers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glass Containers',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: LiquidGlassContainer(
                elevation: selectedElevation,
                height: 120,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Heart Rate',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: LiquidGlassContainer(
                elevation: selectedElevation,
                height: 120,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timeline,
                      size: 32,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'HRV Trend',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGlassButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glass Buttons',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            LiquidGlassButton(
              elevation: selectedElevation,
              onPressed: () {},
              child: const Text('Start Capture'),
            ),
            LiquidGlassButton(
              elevation: selectedElevation,
              onPressed: () {},
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              child: const Text('View Results'),
            ),
            LiquidGlassButton(
              elevation: selectedElevation,
              onPressed: () {},
              color: Theme.of(context).colorScheme.error.withValues(alpha: 0.2),
              child: const Text('Stop'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGlassCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glass Cards',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        LiquidGlassCard(
          elevation: selectedElevation,
          onTap: () {},
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              child: const Icon(Icons.person),
            ),
            title: const Text('User Profile'),
            subtitle: const Text('Manage your health profile and preferences'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
        const SizedBox(height: 12),
        LiquidGlassCard(
          elevation: selectedElevation,
          onTap: () {},
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
              child: const Icon(Icons.settings),
            ),
            title: const Text('App Settings'),
            subtitle: const Text('Configure capture methods and preferences'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }

  Widget _buildHRVStyleDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HRV Dashboard Style',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        LiquidGlassCard(
          elevation: selectedElevation + 1,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildScoreCard('Stress', 75, Colors.red),
                  _buildScoreCard('Recovery', 82, Colors.green),
                  _buildScoreCard('Energy', 68, Colors.blue),
                ],
              ),
              const SizedBox(height: 24),
              LiquidGlassContainer(
                elevation: selectedElevation - 1,
                height: 200,
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.show_chart,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'HRV Trend Chart',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Interactive glass-style chart area',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(String title, int score, Color color) {
    return LiquidGlassContainer(
      elevation: selectedElevation,
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Text(
            '$score',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}