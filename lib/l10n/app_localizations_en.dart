// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'OneShare';

  @override
  String get navShare => 'Share';

  @override
  String get navWeb => 'Web';

  @override
  String get navDownloading => 'Downloading';

  @override
  String get navSettings => 'Settings';

  @override
  String get navDownloads => 'Downloads';

  @override
  String get trayShow => 'Show OneShare';

  @override
  String get trayExit => 'Exit';

  @override
  String get serviceTitle => 'OneShare Service';

  @override
  String get serviceContent => 'Initializing OneShare background service';

  @override
  String get channelName => 'OneShare Foreground Service';

  @override
  String get channelDescription =>
      'This channel is used for important notifications.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSystem => 'System Default';

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
  String get welcomeSkip => 'Skip';

  @override
  String get welcomeNext => 'Next';

  @override
  String get welcomeTitle => 'Welcome to OneShare!';

  @override
  String welcomeVersion(String version) {
    return 'Version $version';
  }

  @override
  String get welcomeChooseLanguage => 'Choose your preferred language';

  @override
  String get welcomeUseSystemLanguage => 'Use System Language';

  @override
  String welcomeCurrentLocale(String locale) {
    return 'Currently: $locale';
  }

  @override
  String get welcomeSelectLanguage => 'Select Language';

  @override
  String get welcomeFeature1Title => 'Cross-Platform Sharing';

  @override
  String get welcomeFeature1Desc =>
      'Seamlessly transfer files between Android, iOS, Windows, Linux, and macOS.';

  @override
  String get welcomeFeature2Title => 'Multiple Protocols';

  @override
  String get welcomeFeature2Desc =>
      'Support for WebDAV, SSH/SFTP, and SMB for flexible file management.';

  @override
  String get welcomeFeature3Title => 'Responsive Design';

  @override
  String get welcomeFeature3Desc =>
      'A beautiful, adaptive interface that works perfectly on mobile and desktop.';

  @override
  String get welcomeAllSet => 'All Set!';

  @override
  String get welcomeSetupComplete => 'You have completed the setup.';

  @override
  String get welcomeSwipeUp => 'Swipe up to enter App';

  @override
  String get welcomeClickToEnter => 'Press any key or click to enter';

  @override
  String get welcomeWhatsNew => 'What\'s New';

  @override
  String get welcomeLogPerformance => 'Performance improvements';

  @override
  String get welcomeLogBugFixes => 'Bug fixes and stability enhancements';

  @override
  String get welcomeLogUI => 'UI refinements for better user experience';

  @override
  String get welcomeContinue => 'Continue';

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
