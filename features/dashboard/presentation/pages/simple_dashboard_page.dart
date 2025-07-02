import 'package:flutter/material.dart';

/// Simple fallback dashboard for testing
class SimpleDashboardPage extends StatelessWidget {
  const SimpleDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PulsePath'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to PulsePath',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Your HRV-based wellbeing tracking app',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Dashboard Loading...',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        'Initializing HRV data and dependencies',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Center(
                child: Text(
                  'App is running successfully!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}