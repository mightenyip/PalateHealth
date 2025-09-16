import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/health_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<HealthProvider>(
        builder: (context, healthProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Health Enthusiast',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Member since 2024',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Health Summary
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Health Summary',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow(
                          context,
                          'Health Score',
                          '${healthProvider.healthScore}/100',
                          _getHealthScoreColor(healthProvider.healthScore),
                          Icons.health_and_safety,
                        ),
                        const Divider(),
                        _buildSummaryRow(
                          context,
                          'BMI',
                          healthProvider.bmi.toStringAsFixed(1),
                          _getBMIColor(healthProvider.bmi),
                          Icons.monitor_weight,
                        ),
                        const Divider(),
                        _buildSummaryRow(
                          context,
                          'Weight',
                          '${healthProvider.weight.toStringAsFixed(1)} kg',
                          Colors.blue,
                          Icons.scale,
                        ),
                        const Divider(),
                        _buildSummaryRow(
                          context,
                          'Height',
                          '${healthProvider.height.toStringAsFixed(0)} cm',
                          Colors.green,
                          Icons.height,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Today's Progress
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today\'s Progress',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildProgressItem(
                          context,
                          'Steps',
                          '${healthProvider.steps}',
                          '10,000',
                          healthProvider.steps / 10000,
                          Icons.directions_walk,
                          Colors.blue,
                        ),
                        const SizedBox(height: 12),
                        _buildProgressItem(
                          context,
                          'Water Intake',
                          '${healthProvider.waterIntake}ml',
                          '2,000ml',
                          healthProvider.waterIntake / 2000,
                          Icons.water_drop,
                          Colors.cyan,
                        ),
                        const SizedBox(height: 12),
                        _buildProgressItem(
                          context,
                          'Calories',
                          '${healthProvider.caloriesConsumed}',
                          '2,000',
                          healthProvider.caloriesConsumed / 2000,
                          Icons.local_fire_department,
                          Colors.orange,
                        ),
                        const SizedBox(height: 12),
                        _buildProgressItem(
                          context,
                          'Sleep',
                          '${healthProvider.sleepHours}h',
                          '8h',
                          healthProvider.sleepHours / 8,
                          Icons.bedtime,
                          Colors.purple,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Settings
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Settings',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSettingsItem(
                          context,
                          'Notifications',
                          'Manage your notification preferences',
                          Icons.notifications,
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Notifications settings coming soon!'),
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        _buildSettingsItem(
                          context,
                          'Data Export',
                          'Export your health data',
                          Icons.download,
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Data export feature coming soon!'),
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        _buildSettingsItem(
                          context,
                          'Privacy',
                          'Manage your privacy settings',
                          Icons.privacy_tip,
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Privacy settings coming soon!'),
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        _buildSettingsItem(
                          context,
                          'About',
                          'App version and information',
                          Icons.info,
                          () {
                            showAboutDialog(
                              context: context,
                              applicationName: 'PalateHealth',
                              applicationVersion: '1.0.0',
                              applicationIcon: Icon(
                                Icons.health_and_safety,
                                size: 48,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              children: [
                                const Text(
                                  'A comprehensive health and wellness tracking app built with Flutter.',
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Reset Data Button
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.refresh,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Reset All Data',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This will reset all your health data to default values.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _showResetDialog(context, healthProvider);
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset Data'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildSummaryRow(
    BuildContext context,
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProgressItem(
    BuildContext context,
    String title,
    String current,
    String goal,
    double progress,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '$current / $goal',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
  
  Color _getHealthScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }
  
  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }
  
  void _showResetDialog(BuildContext context, HealthProvider healthProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset All Data'),
          content: const Text(
            'Are you sure you want to reset all your health data? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Reset all data to default values
                healthProvider.updateWeight(70.0);
                healthProvider.updateHeight(170.0);
                healthProvider.updateSteps(0);
                healthProvider.updateCaloriesBurned(0);
                healthProvider.updateWaterIntake(0);
                healthProvider.updateSleepHours(8);
                healthProvider.updateCaloriesConsumed(0);
                healthProvider.updateProtein(0.0);
                healthProvider.updateCarbs(0.0);
                healthProvider.updateFat(0.0);
                
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All data has been reset successfully!'),
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}
