import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oneshare/models/theme_model.dart';
import 'package:oneshare/models/settings_model.dart';
import 'package:oneshare/models/network_mount.dart';
import 'package:file_picker/file_picker.dart';
import 'package:oneshare/services/sound_service.dart';
import 'package:oneshare/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:oneshare/pages/sound_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: Consumer2<ThemeModel, SettingsModel>(
        builder: (context, themeModel, settingsModel, child) {
          return ListView(
            children: [
              _buildSectionHeader(context, l10n.settingsAppearance),
              SwitchListTile(
                title: Text(l10n.settingsDarkMode),
                subtitle: Text(l10n.settingsDarkModeSubtitle),
                value: themeModel.themeMode == ThemeMode.dark,
                onChanged: (bool value) {
                  themeModel.toggleTheme(value);
                },
                secondary: const Icon(Icons.dark_mode),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.font_download),
                title: Text(l10n.settingsAppFont),
                trailing: DropdownButton<String>(
                  value: themeModel.fontFamily,
                  onChanged: (String? newValue) {
                    if (newValue == null) return;
                    if (newValue == 'Gakumas Font') {
                      context.read<SoundService>().playNotice();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(l10n.settingsFontUsageNotice),
                          content: Text(l10n.settingsFontUsageContent),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(l10n.cancel),
                            ),
                            FilledButton(
                              onPressed: () {
                                themeModel.setFontFamily(newValue);
                                Navigator.pop(context);
                              },
                              child: Text(l10n.confirm),
                            ),
                          ],
                        ),
                      );
                    } else {
                      themeModel.setFontFamily(newValue);
                    }
                  },
                  items:
                      <String>[
                        'HarmonyOS Sans SC',
                        'MiSans',
                        'Gakumas Font',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(l10n.settingsLanguage),
                trailing: DropdownButton<Locale?>(
                  value: settingsModel.locale,
                  onChanged: (Locale? newValue) {
                    settingsModel.setLocale(newValue);
                  },
                  items: [
                    DropdownMenuItem<Locale?>(
                      value: null,
                      child: Text(l10n.languageSystem),
                    ),
                    ...AppLocalizations.supportedLocales.map((Locale locale) {
                      String label;
                      switch (locale.languageCode) {
                        case 'en':
                          label = 'English';
                          break;
                        case 'zh':
                          label = locale.scriptCode == 'Hant' ? '繁體中文' : '简体中文';
                          break;
                        case 'ja':
                          label = '日本語';
                          break;
                        case 'ko':
                          label = '한국어';
                          break;
                        case 'fr':
                          label = 'Français';
                          break;
                        case 'de':
                          label = 'Deutsch';
                          break;
                        case 'es':
                          label = 'Español';
                          break;
                        case 'ru':
                          label = 'Русский';
                          break;
                        default:
                          label = locale.languageCode;
                      }
                      return DropdownMenuItem<Locale?>(
                        value: locale,
                        child: Text(label),
                      );
                    }),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.volume_up),
                title: Text(l10n.settingsSound),
                subtitle: Text(l10n.settingsSoundSubtitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SoundSettingsPage(),
                    ),
                  );
                },
              ),
              const Divider(),
              _buildSectionHeader(context, l10n.settingsDownloads),
              ListTile(
                leading: const Icon(Icons.folder),
                title: Text(l10n.settingsDownloadFolder),
                subtitle: Text(settingsModel.downloadPath ?? l10n.settingsNotSet),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    String? selectedDirectory = await FilePicker.platform
                        .getDirectoryPath();
                    if (selectedDirectory != null) {
                      settingsModel.setDownloadPath(selectedDirectory);
                    }
                  },
                ),
                onTap: () async {
                  String? selectedDirectory = await FilePicker.platform
                      .getDirectoryPath();
                  if (selectedDirectory != null) {
                    settingsModel.setDownloadPath(selectedDirectory);
                  }
                },
              ),
              const Divider(),
              _buildSectionHeader(context, l10n.settingsNetworkConnections),
              ListTile(
                leading: const Icon(Icons.add_link),
                title: Text(l10n.settingsAddConnection),
                subtitle: Text(l10n.settingsAddConnectionSubtitle),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const _AddMountDialog(),
                  );
                },
              ),
              if (settingsModel.networkMounts.isNotEmpty)
                ...settingsModel.networkMounts.map((mount) {
                  return ListTile(
                    leading: Icon(mount.icon),
                    title: Text(mount.name),
                    subtitle: Text('${mount.host}:${mount.port}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        settingsModel.removeNetworkMount(mount.id);
                      },
                    ),
                  );
                }),
              if (settingsModel.networkMounts.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    l10n.settingsNoNetworkConnections,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              const Divider(),
              _buildSectionHeader(context, l10n.settingsAbout),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.settingsAboutOneShare),
                subtitle: Text(l10n.settingsAboutSubtitle),
                onTap: () async {
                  final packageInfo = await PackageInfo.fromPlatform();
                  if (context.mounted) {
                    showAboutDialog(
                      context: context,
                      applicationName: 'OneShare',
                      applicationVersion:
                          '${packageInfo.version}+${packageInfo.buildNumber}',
                      applicationIcon: const Image(
                        image: AssetImage('assets/images/tray_icon.png'),
                        width: 48,
                        height: 48,
                      ),
                      applicationLegalese:
                          'Developer: OneNext Group in iMikufans\nLicense: MIT',
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _AddMountDialog extends StatefulWidget {
  const _AddMountDialog();

  @override
  State<_AddMountDialog> createState() => _AddMountDialogState();
}

class _AddMountDialogState extends State<_AddMountDialog> {
  final _formKey = GlobalKey<FormState>();
  MountType _type = MountType.openList;
  String _name = '';
  String _host = '';
  int _port = 0;
  String _path = '/';
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.settingsAddConnection),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<MountType>(
                value: _type,
                decoration: InputDecoration(labelText: l10n.settingsConnectionType),
                items: MountType.values.map((type) {
                  String label;
                  switch (type) {
                    case MountType.openList:
                      label = 'OpenList';
                      break;
                    case MountType.smb:
                      label = 'SMB';
                      break;
                    case MountType.sftp:
                      label = 'SFTP (SSH)';
                      break;
                    case MountType.webDav:
                      label = 'WebDAV';
                      break;
                  }
                  return DropdownMenuItem(value: type, child: Text(label));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _type = val);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: l10n.settingsConnectionName),
                initialValue: _name,
                onSaved: (val) => _name = val ?? '',
                validator: (val) =>
                    val == null || val.isEmpty ? l10n.required : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.settingsConnectionHost,
                ),
                onSaved: (val) => _host = val ?? '',
                validator: (val) =>
                    val == null || val.isEmpty ? l10n.required : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.settingsConnectionPort,
                ),
                keyboardType: TextInputType.number,
                initialValue: '0',
                onSaved: (val) => _port = int.tryParse(val ?? '0') ?? 0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: l10n.settingsConnectionPath),
                initialValue: '/',
                onSaved: (val) => _path = val ?? '/',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: l10n.settingsConnectionUsername),
                onSaved: (val) => _username = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: l10n.settingsConnectionPassword),
                obscureText: true,
                onSaved: (val) => _password = val ?? '',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final mount = NetworkMount(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: _name,
                type: _type,
                host: _host,
                port: _port,
                path: _path,
                username: _username,
                password: _password,
              );
              context.read<SettingsModel>().addNetworkMount(mount);
              Navigator.pop(context);
            }
          },
          child: Text(l10n.add),
        ),
      ],
    );
  }
}
