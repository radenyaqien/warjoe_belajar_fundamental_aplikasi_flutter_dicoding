import 'package:flutter/material.dart';

import '../data/preference/preference_helper.dart';

class PreferenceProvider extends ChangeNotifier {

  final PreferenceHelper preferenceHelper;

  PreferenceProvider({required this.preferenceHelper});

  bool _isDailyReminderActive = false;
  bool get isDailyReminderActive => _isDailyReminderActive;

  void _getDailyReminderPreferences() async {
    _isDailyReminderActive = await preferenceHelper.isDailyReminderActive;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferenceHelper.setDailyReminder(value);
    _getDailyReminderPreferences();
  }

}