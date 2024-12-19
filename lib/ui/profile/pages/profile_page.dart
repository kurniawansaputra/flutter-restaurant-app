import 'package:flutter/material.dart';

import '../../../core/components/message_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Message(
        imagePath: 'assets/images/fly.png',
        title: 'Under Development',
        subtitle: 'This feature is under development',
      ),
    );
  }
}
