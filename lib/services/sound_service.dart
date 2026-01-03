import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:oneshare/models/settings_model.dart';

class SoundService {
  SettingsModel? _settings;

  void updateSettings(SettingsModel settings) {
    _settings = settings;
  }

  Future<void> _playFile(String fileName) async {
    try {
      final player = AudioPlayer();
      await player.play(AssetSource('audio/$fileName'));
      // Clean up player after sound is done
      player.onPlayerComplete.listen((_) {
        player.dispose();
      });
    } catch (e) {
      debugPrint('Error playing sound $fileName: $e');
    }
  }

  Future<void> _playSound(String fileName, String settingKey) async {
    if (_settings != null && (_settings!.soundSettings[settingKey] == false)) {
      return;
    }
    await _playFile(fileName);
  }

  Future<void> previewSound(String key) async {
    String? fileName;
    switch (key) {
      case 'download_complete':
        fileName = 'DownloadComplete.wav';
        break;
      case 'download_failed':
        fileName = 'DownloadFailed.wav';
        break;
      case 'error':
        fileName = 'Error.wav';
        break;
      case 'new_event':
        fileName = 'NewEvent.wav';
        break;
      case 'notice':
        fileName = 'Notice.wav';
        break;
      case 'device_found':
        fileName = 'FoundDevice.wav';
        break;
      case 'share_received':
        fileName = 'ShareReceived.wav';
        break;
      case 'system_notify':
        fileName = 'SystemNotify.wav';
        break;
    }

    if (fileName != null) {
      await _playFile(fileName);
    }
  }

  Future<void> playDownloadComplete() => _playSound('DownloadComplete.wav', 'download_complete');
  Future<void> playDownloadFailed() => _playSound('DownloadFailed.wav', 'download_failed');
  Future<void> playError() => _playSound('Error.wav', 'error');
  Future<void> playNewEvent() => _playSound('NewEvent.wav', 'new_event');
  Future<void> playNotice() => _playSound('Notice.wav', 'notice');
  Future<void> playDeviceFound() => _playSound('FoundDevice.wav', 'device_found');
  Future<void> playShareReceived() => _playSound('ShareReceived.wav', 'share_received');
  Future<void> playSystemNotify() => _playSound('SystemNotify.wav', 'system_notify');
}
