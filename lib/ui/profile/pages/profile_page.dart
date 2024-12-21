import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../providers/notification/local_notification_provider.dart';
import '../../../providers/theme/app_theme_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<LocalNotificationProvider>().loadReminderState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Consumer<AppThemeProvider>(
            builder: (context, themeProvider, child) {
              final isDark = themeProvider.themeMode == ThemeMode.dark;

              return IconButton(
                icon: SvgPicture.asset(
                  themeProvider.themeMode == ThemeMode.dark
                      ? 'assets/icons/ic_light.svg'
                      : 'assets/icons/ic_dark.svg',
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 19.0,
                  height: 19.0,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Image.asset(
                'assets/images/avatar.png',
                width: 85.0,
                height: 85.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Kurniawan Saputra',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Consumer<LocalNotificationProvider>(
                builder: (context, provider, child) {
                  return ListTile(
                    title: const Text(
                      'Daily Reminder',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Enable to receive daily reminders at 11:00 AM',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Switch(
                      value: provider.isReminderEnabled,
                      onChanged: (value) {
                        provider.toggleReminder(value);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
