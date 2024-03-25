import 'package:flutter/material.dart';

class YourHomeScreen extends StatelessWidget {
 const YourHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Organizer App'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Your Task Organizer!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
