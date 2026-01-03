// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'OneShare';

  @override
  String get navShare => 'Teilen';

  @override
  String get navWeb => 'Web';

  @override
  String get navDownloading => 'Herunterladen';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get navDownloads => 'Downloads';

  @override
  String get trayShow => 'OneShare anzeigen';

  @override
  String get trayExit => 'Beenden';

  @override
  String get serviceTitle => 'OneShare Dienst';

  @override
  String get serviceContent => 'Initialisiere OneShare Hintergrunddienst';

  @override
  String get channelName => 'OneShare Vordergrunddienst';

  @override
  String get channelDescription =>
      'Dieser Kanal wird für wichtige Benachrichtigungen verwendet.';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsDarkModeSubtitle =>
      'Enable dark theme for the application';

  @override
  String get settingsAppFont => 'App Font';

  @override
  String get settingsFontUsageNotice => 'Font Usage Notice';

  @override
  String get settingsFontUsageContent =>
      'Dear User:\n\nThis font originates from the game \"THE IDOLM@STER Gakuen\".\n\nThis is a modified version of the font from a GitHub project gakuen-imas-localify, supporting English, Japanese, Chinese and more language.\n\nNo authorization from the developer or Bandai Namco Entertainment Inc. is required to use this font.\n\nThis application uses this font for non-commercial purposes only; please choose carefully.';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get settingsDownloads => 'Downloads';

  @override
  String get settingsDownloadFolder => 'Download Folder';

  @override
  String get settingsNotSet => 'Not set';

  @override
  String get settingsNetworkConnections => 'Network Connections';

  @override
  String get settingsAddConnection => 'Add Connection';

  @override
  String get settingsAddConnectionSubtitle =>
      'Connect to OpenList, SMB, SFTP, or WebDAV';

  @override
  String get settingsNoNetworkConnections => 'No network connections added.';

  @override
  String get settingsConnectionType => 'Type';

  @override
  String get settingsConnectionName => 'Name';

  @override
  String get settingsConnectionHost => 'Host (IP/Domain)';

  @override
  String get settingsConnectionPort => 'Port (0 = default)';

  @override
  String get settingsConnectionPath => 'Path (Remote)';

  @override
  String get settingsConnectionUsername => 'Username';

  @override
  String get settingsConnectionPassword => 'Password';

  @override
  String get add => 'Add';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsAboutOneShare => 'About OneShare';

  @override
  String get settingsAboutSubtitle => 'Version, Developer, and License';

  @override
  String get required => 'Required';

  @override
  String get welcomeSkip => 'Überspringen';

  @override
  String get welcomeNext => 'Weiter';

  @override
  String get welcomeTitle => 'Willkommen bei OneShare!';

  @override
  String welcomeVersion(String version) {
    return 'Version $version';
  }

  @override
  String get welcomeChooseLanguage => 'Wählen Sie Ihre Sprache';

  @override
  String get welcomeUseSystemLanguage => 'Systemsprache verwenden';

  @override
  String welcomeCurrentLocale(String locale) {
    return 'Aktuell: $locale';
  }

  @override
  String get welcomeSelectLanguage => 'Sprache auswählen';

  @override
  String get welcomeFeature1Title => 'Plattformübergreifendes Teilen';

  @override
  String get welcomeFeature1Desc =>
      'Übertragen Sie Dateien nahtlos zwischen Android, iOS, Windows, Linux und macOS.';

  @override
  String get welcomeFeature2Title => 'Mehrere Protokolle';

  @override
  String get welcomeFeature2Desc =>
      'Unterstützung für WebDAV, SSH/SFTP und SMB für flexibles Dateimanagement.';

  @override
  String get welcomeFeature3Title => 'Responsive Design';

  @override
  String get welcomeFeature3Desc =>
      'Eine schöne, anpassungsfähige Oberfläche, die auf Mobilgeräten und Desktops perfekt funktioniert.';

  @override
  String get welcomeAllSet => 'Alles bereit!';

  @override
  String get welcomeSetupComplete => 'Sie haben die Einrichtung abgeschlossen.';

  @override
  String get welcomeSwipeUp => 'Nach oben wischen, um zu starten';

  @override
  String get welcomeClickToEnter => 'Press any key or click to enter';

  @override
  String get welcomeWhatsNew => 'Was ist neu';

  @override
  String get welcomeLogPerformance => 'Leistungsverbesserungen';

  @override
  String get welcomeLogBugFixes =>
      'Fehlerbehebungen und Stabilitätsverbesserungen';

  @override
  String get welcomeLogUI =>
      'UI-Verbesserungen für ein besseres Benutzererlebnis';

  @override
  String get welcomeContinue => 'Weiter';

  @override
  String get notifyChannelTextName => 'Text Messages';

  @override
  String get notifyChannelTextDesc =>
      'Notifications for received text messages';

  @override
  String get notifyChannelFileName => 'File Transfers';

  @override
  String get notifyChannelFileDesc =>
      'Notifications for file transfer requests';

  @override
  String notifyTitleText(String senderName) {
    return '$senderName sent you a text';
  }

  @override
  String notifyTitleFile(String senderName) {
    return '$senderName sent you a file request';
  }

  @override
  String get notifyActionReject => 'Reject';

  @override
  String get notifyActionCopy => 'Copy';

  @override
  String get notifyActionShare => 'Share';

  @override
  String get notifyActionAccept => 'Accept';

  @override
  String bubbleReceiveFile(String senderName) {
    return 'Receive file from $senderName?';
  }

  @override
  String bubbleReceiveText(String senderName) {
    return '$senderName sent you a text:';
  }

  @override
  String get bubbleAcceptSaveAs => 'Accept & Save As...';

  @override
  String get bubbleNoFiles => 'No files info';

  @override
  String bubbleMoreFiles(int count) {
    return '+ $count more file(s)';
  }

  @override
  String get bubbleCopied => 'Message copied to clipboard';

  @override
  String get bubbleReject => 'Reject';

  @override
  String get settingsSound => 'Sound Settings';

  @override
  String get settingsSoundSubtitle => 'Manage sound effects';

  @override
  String get soundDownloadComplete => 'Download Complete';

  @override
  String get soundDownloadFailed => 'Download Failed';

  @override
  String get soundError => 'Error';

  @override
  String get soundNewEvent => 'New Event';

  @override
  String get soundNotice => 'Notice';

  @override
  String get soundDeviceFound => 'Device Found';

  @override
  String get soundShareReceived => 'Share Received';

  @override
  String get soundSystemNotify => 'System Notification';

  @override
  String get preview => 'Preview';
}
