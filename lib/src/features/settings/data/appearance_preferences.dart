import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the user's preferred [ThemeMode] on the device.
class AppearancePreferences {
  /// Creates the appearance preferences store.
  const AppearancePreferences();

  static const String _key = 'appearance.themeMode';

  /// Loads the saved theme mode, defaulting to [ThemeMode.system].
  Future<ThemeMode> load() async {
    final prefs = await SharedPreferences.getInstance();
    return _decode(prefs.getString(_key));
  }

  /// Persists the selected theme mode.
  Future<void> save(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _encode(mode));
  }

  ThemeMode _decode(String? raw) => switch (raw) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  String _encode(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };
}
