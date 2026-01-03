// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'OneShare';

  @override
  String get navShare => 'Поделиться';

  @override
  String get navWeb => 'Веб';

  @override
  String get navDownloading => 'Скачивание';

  @override
  String get navSettings => 'Настройки';

  @override
  String get navDownloads => 'Загрузки';

  @override
  String get trayShow => 'Показать OneShare';

  @override
  String get trayExit => 'Выход';

  @override
  String get serviceTitle => 'Служба OneShare';

  @override
  String get serviceContent => 'Инициализация фоновой службы OneShare';

  @override
  String get channelName => 'Служба переднего плана OneShare';

  @override
  String get channelDescription =>
      'Этот канал используется для важных уведомлений.';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get languageSystem => 'По умолчанию';

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
  String get welcomeSkip => 'Пропустить';

  @override
  String get welcomeNext => 'Далее';

  @override
  String get welcomeTitle => 'Добро пожаловать в OneShare!';

  @override
  String welcomeVersion(String version) {
    return 'Версия $version';
  }

  @override
  String get welcomeChooseLanguage => 'Выберите язык';

  @override
  String get welcomeUseSystemLanguage => 'Использовать язык системы';

  @override
  String welcomeCurrentLocale(String locale) {
    return 'Сейчас: $locale';
  }

  @override
  String get welcomeSelectLanguage => 'Выберите язык';

  @override
  String get welcomeFeature1Title => 'Кроссплатформенный обмен';

  @override
  String get welcomeFeature1Desc =>
      'Беспрепятственная передача файлов между Android, iOS, Windows, Linux и macOS.';

  @override
  String get welcomeFeature2Title => 'Несколько протоколов';

  @override
  String get welcomeFeature2Desc =>
      'Поддержка WebDAV, SSH/SFTP и SMB для гибкого управления файлами.';

  @override
  String get welcomeFeature3Title => 'Адаптивный дизайн';

  @override
  String get welcomeFeature3Desc =>
      'Красивый, адаптивный интерфейс, который отлично работает на мобильных и настольных устройствах.';

  @override
  String get welcomeAllSet => 'Готово!';

  @override
  String get welcomeSetupComplete => 'Вы завершили настройку.';

  @override
  String get welcomeSwipeUp => 'Смахните вверх, чтобы войти';

  @override
  String get welcomeClickToEnter => 'Press any key or click to enter';

  @override
  String get welcomeWhatsNew => 'Что нового';

  @override
  String get welcomeLogPerformance => 'Улучшения производительности';

  @override
  String get welcomeLogBugFixes =>
      'Исправление ошибок и повышение стабильности';

  @override
  String get welcomeLogUI => 'Улучшения интерфейса для лучшего опыта';

  @override
  String get welcomeContinue => 'Продолжить';

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
