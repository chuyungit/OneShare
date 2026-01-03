// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'OneShare';

  @override
  String get navShare => '共有';

  @override
  String get navWeb => 'Web';

  @override
  String get navDownloading => 'ダウンロード中';

  @override
  String get navSettings => '設定';

  @override
  String get navDownloads => 'ダウンロード';

  @override
  String get trayShow => 'OneShareを表示';

  @override
  String get trayExit => '終了';

  @override
  String get serviceTitle => 'OneShare サービス';

  @override
  String get serviceContent => 'OneShare バックグラウンドサービスを初期化中';

  @override
  String get channelName => 'OneShare フォアグラウンドサービス';

  @override
  String get channelDescription => 'このチャンネルは重要な通知に使用されます。';

  @override
  String get settingsLanguage => '言語';

  @override
  String get languageSystem => 'システムデフォルト';

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
  String get welcomeSkip => 'スキップ';

  @override
  String get welcomeNext => '次へ';

  @override
  String get welcomeTitle => 'OneShareへようこそ！';

  @override
  String welcomeVersion(String version) {
    return 'バージョン $version';
  }

  @override
  String get welcomeChooseLanguage => '言語を選択してください';

  @override
  String get welcomeUseSystemLanguage => 'システム言語を使用';

  @override
  String welcomeCurrentLocale(String locale) {
    return '現在: $locale';
  }

  @override
  String get welcomeSelectLanguage => '言語を選択';

  @override
  String get welcomeFeature1Title => 'クロスプラットフォーム共有';

  @override
  String get welcomeFeature1Desc =>
      'Android、iOS、Windows、Linux、macOS間でファイルをシームレスに転送します。';

  @override
  String get welcomeFeature2Title => '複数のプロトコル';

  @override
  String get welcomeFeature2Desc => 'WebDAV、SSH/SFTP、SMBをサポートし、柔軟なファイル管理が可能です。';

  @override
  String get welcomeFeature3Title => 'レスポンシブデザイン';

  @override
  String get welcomeFeature3Desc => 'モバイルとデスクトップの両方で完璧に動作する美しく適応性のあるインターフェース。';

  @override
  String get welcomeAllSet => '準備完了！';

  @override
  String get welcomeSetupComplete => 'セットアップが完了しました。';

  @override
  String get welcomeSwipeUp => '上にスワイプしてアプリを開始';

  @override
  String get welcomeClickToEnter => 'Press any key or click to enter';

  @override
  String get welcomeWhatsNew => '新機能';

  @override
  String get welcomeLogPerformance => 'パフォーマンスの向上';

  @override
  String get welcomeLogBugFixes => 'バグ修正と安定性の向上';

  @override
  String get welcomeLogUI => 'UI改善';

  @override
  String get welcomeContinue => '続ける';

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

  @override
  String get settingsNotification => 'Notification';

  @override
  String get settingsInAppNotifyTest => 'In-App Notification Test';

  @override
  String get settingsSystemNotifyTest => 'System Notification Test';

  @override
  String get settingsSystemNotifyMobileOnly =>
      'This feature is only available on mobile devices (Android/iOS).';
}
