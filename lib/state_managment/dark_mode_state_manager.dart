import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final darkModeStateManagerProvider =
    StateNotifierProvider<DarkModeStateManager, bool>((ref) {
  return DarkModeStateManager(ref);
});

class DarkModeStateManager extends StateNotifier<bool> {
  DarkModeStateManager(this.ref, [state]) : super(state ?? false) {
    _init();
  }

  final Ref ref;

  void _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = false;
    var jsonData = prefs.getString('darkMode') ?? '';
    if (jsonData != '') {
      darkMode = json.decode(jsonData)['mode'];
    }
    state = darkMode;
  }

  Future<void> switchDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    state = !state;
    prefs.setString('darkMode', jsonEncode({'mode': state}));
    state = state;
  }
}
