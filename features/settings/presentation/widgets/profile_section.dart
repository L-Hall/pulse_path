import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_preferences.dart';
import '../providers/settings_providers.dart';
import 'settings_section_card.dart';

/// Profile settings section widget
class ProfileSection extends ConsumerWidget {
  final UserPreferences preferences;
  
  const ProfileSection({
    super.key,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSectionCard(
      title: 'Profile',
      icon: Icons.person,
      children: [
        // User Name
        ListTile(
          leading: const Icon(Icons.badge),
          title: const Text('Name'),
          subtitle: preferences.userName.isEmpty 
              ? const Text('Tap to set your name')
              : Text(preferences.userName),
          onTap: () => _showNameDialog(context, ref),
        ),
        
        // Email (optional)
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Email'),
          subtitle: preferences.userEmail?.isEmpty ?? true
              ? const Text('Not set')
              : Text(preferences.userEmail!),
          onTap: () => _showEmailDialog(context, ref),
        ),
        
        const Divider(height: 1),
        
        // Age
        ListTile(
          leading: const Icon(Icons.cake),
          title: const Text('Age'),
          subtitle: Text('${preferences.age} years old'),
          onTap: () => _showAgeDialog(context, ref),
        ),
        
        // Gender
        ListTile(
          leading: const Icon(Icons.wc),
          title: const Text('Gender'),
          subtitle: Text(preferences.gender.displayName),
          onTap: () => _showGenderDialog(context, ref),
        ),
        
        const Divider(height: 1),
        
        // Height
        ListTile(
          leading: const Icon(Icons.height),
          title: const Text('Height'),
          subtitle: Text('${preferences.heightCm.toStringAsFixed(0)} cm'),
          onTap: () => _showHeightDialog(context, ref),
        ),
        
        // Weight
        ListTile(
          leading: const Icon(Icons.monitor_weight),
          title: const Text('Weight'),
          subtitle: Text('${preferences.weightKg.toStringAsFixed(1)} kg'),
          onTap: () => _showWeightDialog(context, ref),
        ),
        
        // Activity Level
        ListTile(
          leading: const Icon(Icons.directions_run),
          title: const Text('Activity Level'),
          subtitle: Text(preferences.activityLevel.displayName),
          onTap: () => _showActivityLevelDialog(context, ref),
        ),
        
        const Divider(height: 1),
        
        // Chronic Conditions
        SwitchListTile(
          secondary: const Icon(Icons.medical_services),
          title: const Text('Chronic Health Conditions'),
          subtitle: const Text('Enable adaptive pacing features'),
          value: preferences.hasChronicConditions,
          onChanged: (value) {
            ref.read(userPreferencesNotifierProvider.notifier).updateProfile(
              hasChronicConditions: value,
            );
          },
        ),
        
        // Medications (if chronic conditions enabled)
        if (preferences.hasChronicConditions)
          ListTile(
            leading: const Icon(Icons.medication),
            title: const Text('Medications'),
            subtitle: preferences.medications.isEmpty
                ? const Text('None listed')
                : Text('${preferences.medications.length} medications'),
            onTap: () => _showMedicationsDialog(context, ref),
          ),
      ],
    );
  }

  void _showNameDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: preferences.userName);
    
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter your name',
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(userPreferencesNotifierProvider.notifier).updateProfile(
                userName: controller.text.trim(),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEmailDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: preferences.userEmail ?? '');
    
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Email Address'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'your@email.com',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(userPreferencesNotifierProvider.notifier).updateProfile(
                userEmail: controller.text.trim(),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAgeDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Age'),
        content: SizedBox(
          height: 200,
          child: ListWheelScrollView.useDelegate(
            physics: const FixedExtentScrollPhysics(),
            itemExtent: 50,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                final age = index + 13; // Start from 13
                if (age > 100) return null;
                
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      ref.read(userPreferencesNotifierProvider.notifier).updateProfile(
                        age: age,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: age == preferences.age
                          ? BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            )
                          : null,
                      child: Text(
                        '$age years',
                        style: TextStyle(
                          fontSize: age == preferences.age ? 18 : 16,
                          fontWeight: age == preferences.age ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showGenderDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gender'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: UserGender.values.map((gender) => 
            RadioListTile<UserGender>(
              title: Text(gender.displayName),
              value: gender,
              groupValue: preferences.gender,
              onChanged: (value) {
                Navigator.of(context).pop();
                if (value != null) {
                  ref.read(userPreferencesNotifierProvider.notifier).updateProfile(
                    gender: value,
                  );
                }
              },
            ),
          ).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showHeightDialog(BuildContext context, WidgetRef ref) {
    double selectedHeight = preferences.heightCm;
    
    showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Height'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${selectedHeight.toStringAsFixed(0)} cm',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Slider(
                value: selectedHeight,
                min: 100,
                max: 250,
                divisions: 150,
                onChanged: (value) {
                  setState(() {
                    selectedHeight = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(userPreferencesNotifierProvider.notifier).updateProfile(
                  heightCm: selectedHeight,
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showWeightDialog(BuildContext context, WidgetRef ref) {
    double selectedWeight = preferences.weightKg;
    
    showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Weight'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${selectedWeight.toStringAsFixed(1)} kg',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Slider(
                value: selectedWeight,
                min: 30,
                max: 200,
                divisions: 170,
                onChanged: (value) {
                  setState(() {
                    selectedWeight = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(userPreferencesNotifierProvider.notifier).updateProfile(
                  weightKg: selectedWeight,
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showActivityLevelDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Activity Level'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ActivityLevel.values.map((level) => 
            RadioListTile<ActivityLevel>(
              title: Text(level.displayName.split(' (')[0]),
              subtitle: Text('(${level.displayName.split(' (')[1]}'),
              value: level,
              groupValue: preferences.activityLevel,
              onChanged: (value) {
                Navigator.of(context).pop();
                if (value != null) {
                  ref.read(userPreferencesNotifierProvider.notifier).updateProfile(
                    activityLevel: value,
                  );
                }
              },
            ),
          ).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showMedicationsDialog(BuildContext context, WidgetRef ref) {
    final medications = List<String>.from(preferences.medications);
    final controller = TextEditingController();
    
    showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Medications'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Add medication',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          setState(() {
                            medications.add(controller.text.trim());
                            controller.clear();
                          });
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: medications.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(medications[index]),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            medications.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(userPreferencesNotifierProvider.notifier).updateProfile(
                  medications: medications,
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}