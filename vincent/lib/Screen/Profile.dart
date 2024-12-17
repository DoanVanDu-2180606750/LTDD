import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/200/300'),
            ),
            const SizedBox(height: 16),
            const Text('Username'),
            const SizedBox(height: 16),
            const Text('Email'),
          ],
        ),
      ),
    );
  }
}