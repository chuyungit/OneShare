import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oneshare/models/settings_model.dart';
import 'package:oneshare/l10n/app_localizations.dart';
import 'package:oneshare/services/sound_service.dart';

class SoundSettingsPage extends StatelessWidget {
  const SoundSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    final Map<String, String> soundNames = {
      'download_complete': l10n.soundDownloadComplete,
      'download_failed': l10n.soundDownloadFailed,
      'error': l10n.soundError,
      'new_event': l10n.soundNewEvent,
      'notice': l10n.soundNotice,
      'device_found': l10n.soundDeviceFound,
      'share_received': l10n.soundShareReceived,
      'system_notify': l10n.soundSystemNotify,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsSound),
      ),
      body: Consumer<SettingsModel>(
        builder: (context, settings, child) {
          return ListView(
            children: soundNames.entries.map((entry) {
              final key = entry.key;
              final title = entry.value;
              final value = settings.soundSettings[key] ?? true;

              return SwitchListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.play_circle_outline),
                      onPressed: () {
                        context.read<SoundService>().previewSound(key);
                      },
                      tooltip: l10n.preview,
                    ),
                  ],
                ),
                value: value,
                onChanged: (bool newValue) {
                  settings.setSoundEnabled(key, newValue);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
