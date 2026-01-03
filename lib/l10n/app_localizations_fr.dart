// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'OneShare';

  @override
  String get navShare => 'Partager';

  @override
  String get navWeb => 'Web';

  @override
  String get navDownloading => 'Téléchargement';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get navDownloads => 'Téléchargements';

  @override
  String get trayShow => 'Afficher OneShare';

  @override
  String get trayExit => 'Quitter';

  @override
  String get serviceTitle => 'Service OneShare';

  @override
  String get serviceContent =>
      'Initialisation du service d\'arrière-plan OneShare';

  @override
  String get channelName => 'Service de premier plan OneShare';

  @override
  String get channelDescription =>
      'Ce canal est utilisé pour les notifications importantes.';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get languageSystem => 'Par défaut';

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
  String get welcomeSkip => 'Passer';

  @override
  String get welcomeNext => 'Suivant';

  @override
  String get welcomeTitle => 'Bienvenue sur OneShare !';

  @override
  String welcomeVersion(String version) {
    return 'Version $version';
  }

  @override
  String get welcomeChooseLanguage => 'Choisissez votre langue';

  @override
  String get welcomeUseSystemLanguage => 'Utiliser la langue du système';

  @override
  String welcomeCurrentLocale(String locale) {
    return 'Actuellement : $locale';
  }

  @override
  String get welcomeSelectLanguage => 'Sélectionner la langue';

  @override
  String get welcomeFeature1Title => 'Partage multiplateforme';

  @override
  String get welcomeFeature1Desc =>
      'Transférez des fichiers en toute transparence entre Android, iOS, Windows, Linux et macOS.';

  @override
  String get welcomeFeature2Title => 'Protocoles multiples';

  @override
  String get welcomeFeature2Desc =>
      'Prise en charge de WebDAV, SSH/SFTP et SMB pour une gestion flexible des fichiers.';

  @override
  String get welcomeFeature3Title => 'Design réactif';

  @override
  String get welcomeFeature3Desc =>
      'Une interface belle et adaptative qui fonctionne parfaitement sur mobile et bureau.';

  @override
  String get welcomeAllSet => 'Tout est prêt !';

  @override
  String get welcomeSetupComplete => 'Vous avez terminé la configuration.';

  @override
  String get welcomeSwipeUp => 'Glissez vers le haut pour entrer';

  @override
  String get welcomeClickToEnter => 'Press any key or click to enter';

  @override
  String get welcomeWhatsNew => 'Quoi de neuf';

  @override
  String get welcomeLogPerformance => 'Améliorations des performances';

  @override
  String get welcomeLogBugFixes =>
      'Corrections de bugs et améliorations de la stabilité';

  @override
  String get welcomeLogUI => 'Améliorations de l\'interface utilisateur';

  @override
  String get welcomeContinue => 'Continuer';

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
