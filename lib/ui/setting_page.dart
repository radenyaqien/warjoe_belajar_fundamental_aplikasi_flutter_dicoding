import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warjoe/provider/SchedulingProvider.dart';
import 'package:warjoe/provider/preference_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingContent();
  }
}

class SettingContent extends StatelessWidget {
  const SettingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SchedulingProvider>(builder: (context, scheduled, _) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Settings"),
        ),
        body: Column(
          children: [
            ListTile(
                title: const Text('Scheduling News'),
                trailing: Consumer<PreferenceProvider>(
                    builder: (context, provider, _) {
                  return Switch.adaptive(
                    value: provider.isDailyReminderActive,
                    onChanged: (value) async {
                      provider.enableDailyReminder(value);
                      scheduled.scheduledNews(value);
                    },
                  );
                })),
          ],
        ),
      );
    });
  }
}
