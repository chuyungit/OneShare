import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:oneshare/l10n/app_localizations.dart';

class TrayService with TrayListener, WindowListener {
  // Singleton instance
  static final TrayService _instance = TrayService._internal();

  factory TrayService() {
    return _instance;
  }

  TrayService._internal();

  Future<void> init() async {
    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      await windowManager.ensureInitialized();
      await trayManager.setIcon(
        Platform.isWindows
            ? 'assets/images/tray_icon.png' // Windows might prefer .ico but .png often works or uses fallback
            : 'assets/images/tray_icon.png',
      );

      Menu menu = Menu(
        items: [
          MenuItem(key: 'show_window', label: 'Show OneShare'),
          MenuItem.separator(),
          MenuItem(key: 'exit_app', label: 'Exit'),
        ],
      );

      await trayManager.setContextMenu(menu);
      trayManager.addListener(this);
      windowManager.addListener(this);

      // Configure window to not close but hide
      await windowManager.setPreventClose(true);
    }
  }

  Future<void> updateContextMenu(AppLocalizations l10n) async {
    if (!kIsWeb &&
        (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      Menu menu = Menu(
        items: [
          MenuItem(key: 'show_window', label: l10n.trayShow),
          MenuItem.separator(),
          MenuItem(key: 'exit_app', label: l10n.trayExit),
        ],
      );
      await trayManager.setContextMenu(menu);
    }
  }

  @override
  void onTrayIconMouseDown() {
    windowManager.show();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'show_window') {
      windowManager.show();
    } else if (menuItem.key == 'exit_app') {
      windowManager.destroy();
    }
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      windowManager.hide();
    }
  }

  void dispose() {
    trayManager.removeListener(this);
    windowManager.removeListener(this);
  }
}
