// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'OneShare';

  @override
  String get navShare => '공유';

  @override
  String get navWeb => '웹';

  @override
  String get navDownloading => '다운로드 중';

  @override
  String get navSettings => '설정';

  @override
  String get navDownloads => '다운로드';

  @override
  String get trayShow => 'OneShare 표시';

  @override
  String get trayExit => '종료';

  @override
  String get serviceTitle => 'OneShare 서비스';

  @override
  String get serviceContent => 'OneShare 백그라운드 서비스 초기화 중';

  @override
  String get channelName => 'OneShare 포그라운드 서비스';

  @override
  String get channelDescription => '이 채널은 중요한 알림에 사용됩니다。';

  @override
  String get settingsLanguage => '언어';

  @override
  String get languageSystem => '시스템 기본값';

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
  String get welcomeSkip => '건너뛰기';

  @override
  String get welcomeNext => '다음';

  @override
  String get welcomeTitle => 'OneShare에 오신 것을 환영합니다!';

  @override
  String welcomeVersion(String version) {
    return '버전 $version';
  }

  @override
  String get welcomeChooseLanguage => '언어를 선택하세요';

  @override
  String get welcomeUseSystemLanguage => '시스템 언어 사용';

  @override
  String welcomeCurrentLocale(String locale) {
    return '현재: $locale';
  }

  @override
  String get welcomeSelectLanguage => '언어 선택';

  @override
  String get welcomeFeature1Title => '크로스 플랫폼 공유';

  @override
  String get welcomeFeature1Desc =>
      'Android, iOS, Windows, Linux, macOS 간에 파일을 원활하게 전송하세요.';

  @override
  String get welcomeFeature2Title => '다양한 프로토콜';

  @override
  String get welcomeFeature2Desc =>
      'WebDAV, SSH/SFTP, SMB를 지원하여 유연한 파일 관리가 가능합니다.';

  @override
  String get welcomeFeature3Title => '반응형 디자인';

  @override
  String get welcomeFeature3Desc =>
      '모바일과 데스크톱 모두에서 완벽하게 작동하는 아름답고 적응력 있는 인터페이스.';

  @override
  String get welcomeAllSet => '준비 완료!';

  @override
  String get welcomeSetupComplete => '설정이 완료되었습니다.';

  @override
  String get welcomeSwipeUp => '위로 스와이프하여 앱 시작';

  @override
  String get welcomeClickToEnter => 'Press any key or click to enter';

  @override
  String get welcomeWhatsNew => '새로운 기능';

  @override
  String get welcomeLogPerformance => '성능 향상';

  @override
  String get welcomeLogBugFixes => '버그 수정 및 안정성 향상';

  @override
  String get welcomeLogUI => 'UI 개선';

  @override
  String get welcomeContinue => '계속';

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
