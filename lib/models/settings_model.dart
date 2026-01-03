import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:oneshare/models/network_mount.dart';

class SettingsModel extends ChangeNotifier {
  String? _downloadPath;
  List<NetworkMount> _networkMounts = [];
  Locale? _locale;
  String? _lastVersion;

  String? get downloadPath => _downloadPath;
  List<NetworkMount> get networkMounts => _networkMounts;
  Locale? get locale => _locale;
  String? get lastVersion => _lastVersion;

  // Sound settings
  final Map<String, bool> _soundSettings = {
    'download_complete': true,
    'download_failed': true,
    'error': true,
    'new_event': true,
    'notice': true,
    'device_found': true,
    'share_received': true,
    'system_notify': true,
  };

  Map<String, bool> get soundSettings => Map.unmodifiable(_soundSettings);

  SettingsModel() {
    // Settings are loaded manually via loadSettings() to allow awaiting
  }

  Future<void> setLastVersion(String version) async {
    _lastVersion = version;
    _saveSettings();
    notifyListeners();
  }

  void setSoundEnabled(String key, bool enabled) {
    if (_soundSettings.containsKey(key)) {
      _soundSettings[key] = enabled;
      _saveSettings();
      notifyListeners();
    }
  }

  void setDownloadPath(String path) {
    _downloadPath = path;
    _saveSettings();
    notifyListeners();
  }

  void setLocale(Locale? locale) {
    _locale = locale;
    _saveSettings();
    notifyListeners();
  }

  void addNetworkMount(NetworkMount mount) {
    if (!_networkMounts.any((m) => m.id == mount.id)) {
      _networkMounts.add(mount);
      _saveSettings();
      notifyListeners();
    }
  }

  void removeNetworkMount(String id) {
    _networkMounts.removeWhere((m) => m.id == id);
    _saveSettings();
    notifyListeners();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _downloadPath = prefs.getString('download_path');
    _lastVersion = prefs.getString('last_version');

    // Load sound settings
    for (final key in _soundSettings.keys) {
      final val = prefs.getBool('sound_$key');
      if (val != null) {
        _soundSettings[key] = val;
      }
    }

    // Load locale
    final String? languageCode = prefs.getString('language_code');
    final String? countryCode = prefs.getString('country_code');
    final String? scriptCode = prefs.getString('script_code');

    if (languageCode != null) {
      _locale = Locale.fromSubtags(
        languageCode: languageCode,
        countryCode: countryCode,
        scriptCode: scriptCode,
      );
    } else {
      _locale = null; // System default
    }

    // Set default if not set
    if (_downloadPath == null) {
      if (Platform.isAndroid) {
        _downloadPath = '/storage/emulated/0/Download';
      } else if (Platform.isIOS) {
        final dir = await getApplicationDocumentsDirectory();
        _downloadPath = dir.path;
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        final dir = await getDownloadsDirectory();
        _downloadPath = dir?.path ?? '.'; // Fallback to current dir if null
      }
    }

    // Load network mounts
    final List<String>? mountsJson = prefs.getStringList('network_mounts');
    if (mountsJson != null) {
      _networkMounts = mountsJson
          .map((str) => NetworkMount.fromJson(jsonDecode(str)))
          .toList();
    }

    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (_lastVersion != null) {
      await prefs.setString('last_version', _lastVersion!);
    }
    if (_downloadPath != null) {
      await prefs.setString('download_path', _downloadPath!);
    }

    // Save sound settings
    for (final entry in _soundSettings.entries) {
      await prefs.setBool('sound_${entry.key}', entry.value);
    }

    if (_locale != null) {
      await prefs.setString('language_code', _locale!.languageCode);
      if (_locale!.countryCode != null) {
        await prefs.setString('country_code', _locale!.countryCode!);
      } else {
        await prefs.remove('country_code');
      }
      if (_locale!.scriptCode != null) {
        await prefs.setString('script_code', _locale!.scriptCode!);
      } else {
        await prefs.remove('script_code');
      }
    } else {
      await prefs.remove('language_code');
      await prefs.remove('country_code');
      await prefs.remove('script_code');
    }

    final List<String> mountsJson = _networkMounts
        .map((m) => jsonEncode(m.toJson()))
        .toList();
    await prefs.setStringList('network_mounts', mountsJson);
  }
}
