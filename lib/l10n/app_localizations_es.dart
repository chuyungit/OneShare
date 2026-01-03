// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'OneShare';

  @override
  String get navShare => 'Compartir';

  @override
  String get navWeb => 'Web';

  @override
  String get navDownloading => 'Descargando';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get navDownloads => 'Descargas';

  @override
  String get trayShow => 'Mostrar OneShare';

  @override
  String get trayExit => 'Salir';

  @override
  String get serviceTitle => 'Servicio OneShare';

  @override
  String get serviceContent =>
      'Inicializando servicio en segundo plano de OneShare';

  @override
  String get channelName => 'Servicio en primer plano de OneShare';

  @override
  String get channelDescription =>
      'Este canal se utiliza para notificaciones importantes.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get languageSystem => 'Predeterminado';

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
  String get welcomeSkip => 'Omitir';

  @override
  String get welcomeNext => 'Siguiente';

  @override
  String get welcomeTitle => '¡Bienvenido a OneShare!';

  @override
  String welcomeVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get welcomeChooseLanguage => 'Elige tu idioma';

  @override
  String get welcomeUseSystemLanguage => 'Usar idioma del sistema';

  @override
  String welcomeCurrentLocale(String locale) {
    return 'Actualmente: $locale';
  }

  @override
  String get welcomeSelectLanguage => 'Seleccionar idioma';

  @override
  String get welcomeFeature1Title => 'Intercambio multiplataforma';

  @override
  String get welcomeFeature1Desc =>
      'Transfiere archivos sin problemas entre Android, iOS, Windows, Linux y macOS.';

  @override
  String get welcomeFeature2Title => 'Múltiples protocolos';

  @override
  String get welcomeFeature2Desc =>
      'Soporte para WebDAV, SSH/SFTP y SMB para una gestión flexible de archivos.';

  @override
  String get welcomeFeature3Title => 'Diseño responsivo';

  @override
  String get welcomeFeature3Desc =>
      'Una interfaz hermosa y adaptativa que funciona perfectamente en móviles y escritorio.';

  @override
  String get welcomeAllSet => '¡Todo listo!';

  @override
  String get welcomeSetupComplete => 'Has completado la configuración.';

  @override
  String get welcomeSwipeUp => 'Desliza hacia arriba para entrar';

  @override
  String get welcomeClickToEnter => 'Press any key or click to enter';

  @override
  String get welcomeWhatsNew => 'Novedades';

  @override
  String get welcomeLogPerformance => 'Mejoras de rendimiento';

  @override
  String get welcomeLogBugFixes =>
      'Corrección de errores y mejoras de estabilidad';

  @override
  String get welcomeLogUI => 'Mejoras en la interfaz de usuario';

  @override
  String get welcomeContinue => 'Continuar';

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
