import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'OneShare'**
  String get appTitle;

  /// No description provided for @navShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get navShare;

  /// No description provided for @navWeb.
  ///
  /// In en, this message translates to:
  /// **'Web'**
  String get navWeb;

  /// No description provided for @navDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get navDownloading;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navDownloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get navDownloads;

  /// No description provided for @trayShow.
  ///
  /// In en, this message translates to:
  /// **'Show OneShare'**
  String get trayShow;

  /// No description provided for @trayExit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get trayExit;

  /// No description provided for @serviceTitle.
  ///
  /// In en, this message translates to:
  /// **'OneShare Service'**
  String get serviceTitle;

  /// No description provided for @serviceContent.
  ///
  /// In en, this message translates to:
  /// **'Initializing OneShare background service'**
  String get serviceContent;

  /// No description provided for @channelName.
  ///
  /// In en, this message translates to:
  /// **'OneShare Foreground Service'**
  String get channelName;

  /// No description provided for @channelDescription.
  ///
  /// In en, this message translates to:
  /// **'This channel is used for important notifications.'**
  String get channelDescription;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get languageSystem;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable dark theme for the application'**
  String get settingsDarkModeSubtitle;

  /// No description provided for @settingsAppFont.
  ///
  /// In en, this message translates to:
  /// **'App Font'**
  String get settingsAppFont;

  /// No description provided for @settingsFontUsageNotice.
  ///
  /// In en, this message translates to:
  /// **'Font Usage Notice'**
  String get settingsFontUsageNotice;

  /// No description provided for @settingsFontUsageContent.
  ///
  /// In en, this message translates to:
  /// **'Dear User:\n\nThis font originates from the game \"THE IDOLM@STER Gakuen\".\n\nThis is a modified version of the font from a GitHub project gakuen-imas-localify, supporting English, Japanese, Chinese and more language.\n\nNo authorization from the developer or Bandai Namco Entertainment Inc. is required to use this font.\n\nThis application uses this font for non-commercial purposes only; please choose carefully.'**
  String get settingsFontUsageContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @settingsDownloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get settingsDownloads;

  /// No description provided for @settingsDownloadFolder.
  ///
  /// In en, this message translates to:
  /// **'Download Folder'**
  String get settingsDownloadFolder;

  /// No description provided for @settingsNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get settingsNotSet;

  /// No description provided for @settingsNetworkConnections.
  ///
  /// In en, this message translates to:
  /// **'Network Connections'**
  String get settingsNetworkConnections;

  /// No description provided for @settingsAddConnection.
  ///
  /// In en, this message translates to:
  /// **'Add Connection'**
  String get settingsAddConnection;

  /// No description provided for @settingsAddConnectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect to OpenList, SMB, SFTP, or WebDAV'**
  String get settingsAddConnectionSubtitle;

  /// No description provided for @settingsNoNetworkConnections.
  ///
  /// In en, this message translates to:
  /// **'No network connections added.'**
  String get settingsNoNetworkConnections;

  /// No description provided for @settingsConnectionType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get settingsConnectionType;

  /// No description provided for @settingsConnectionName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get settingsConnectionName;

  /// No description provided for @settingsConnectionHost.
  ///
  /// In en, this message translates to:
  /// **'Host (IP/Domain)'**
  String get settingsConnectionHost;

  /// No description provided for @settingsConnectionPort.
  ///
  /// In en, this message translates to:
  /// **'Port (0 = default)'**
  String get settingsConnectionPort;

  /// No description provided for @settingsConnectionPath.
  ///
  /// In en, this message translates to:
  /// **'Path (Remote)'**
  String get settingsConnectionPath;

  /// No description provided for @settingsConnectionUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get settingsConnectionUsername;

  /// No description provided for @settingsConnectionPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get settingsConnectionPassword;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsAboutOneShare.
  ///
  /// In en, this message translates to:
  /// **'About OneShare'**
  String get settingsAboutOneShare;

  /// No description provided for @settingsAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Version, Developer, and License'**
  String get settingsAboutSubtitle;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @welcomeSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get welcomeSkip;

  /// No description provided for @welcomeNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get welcomeNext;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to OneShare!'**
  String get welcomeTitle;

  /// No description provided for @welcomeVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String welcomeVersion(String version);

  /// No description provided for @welcomeChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get welcomeChooseLanguage;

  /// No description provided for @welcomeUseSystemLanguage.
  ///
  /// In en, this message translates to:
  /// **'Use System Language'**
  String get welcomeUseSystemLanguage;

  /// No description provided for @welcomeCurrentLocale.
  ///
  /// In en, this message translates to:
  /// **'Currently: {locale}'**
  String welcomeCurrentLocale(String locale);

  /// No description provided for @welcomeSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get welcomeSelectLanguage;

  /// No description provided for @welcomeFeature1Title.
  ///
  /// In en, this message translates to:
  /// **'Cross-Platform Sharing'**
  String get welcomeFeature1Title;

  /// No description provided for @welcomeFeature1Desc.
  ///
  /// In en, this message translates to:
  /// **'Seamlessly transfer files between Android, iOS, Windows, Linux, and macOS.'**
  String get welcomeFeature1Desc;

  /// No description provided for @welcomeFeature2Title.
  ///
  /// In en, this message translates to:
  /// **'Multiple Protocols'**
  String get welcomeFeature2Title;

  /// No description provided for @welcomeFeature2Desc.
  ///
  /// In en, this message translates to:
  /// **'Support for WebDAV, SSH/SFTP, and SMB for flexible file management.'**
  String get welcomeFeature2Desc;

  /// No description provided for @welcomeFeature3Title.
  ///
  /// In en, this message translates to:
  /// **'Responsive Design'**
  String get welcomeFeature3Title;

  /// No description provided for @welcomeFeature3Desc.
  ///
  /// In en, this message translates to:
  /// **'A beautiful, adaptive interface that works perfectly on mobile and desktop.'**
  String get welcomeFeature3Desc;

  /// No description provided for @welcomeAllSet.
  ///
  /// In en, this message translates to:
  /// **'All Set!'**
  String get welcomeAllSet;

  /// No description provided for @welcomeSetupComplete.
  ///
  /// In en, this message translates to:
  /// **'You have completed the setup.'**
  String get welcomeSetupComplete;

  /// No description provided for @welcomeSwipeUp.
  ///
  /// In en, this message translates to:
  /// **'Swipe up to enter App'**
  String get welcomeSwipeUp;

  /// No description provided for @welcomeClickToEnter.
  ///
  /// In en, this message translates to:
  /// **'Press any key or click to enter'**
  String get welcomeClickToEnter;

  /// No description provided for @welcomeWhatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s New'**
  String get welcomeWhatsNew;

  /// No description provided for @welcomeLogPerformance.
  ///
  /// In en, this message translates to:
  /// **'Performance improvements'**
  String get welcomeLogPerformance;

  /// No description provided for @welcomeLogBugFixes.
  ///
  /// In en, this message translates to:
  /// **'Bug fixes and stability enhancements'**
  String get welcomeLogBugFixes;

  /// No description provided for @welcomeLogUI.
  ///
  /// In en, this message translates to:
  /// **'UI refinements for better user experience'**
  String get welcomeLogUI;

  /// No description provided for @welcomeContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get welcomeContinue;

  /// No description provided for @notifyChannelTextName.
  ///
  /// In en, this message translates to:
  /// **'Text Messages'**
  String get notifyChannelTextName;

  /// No description provided for @notifyChannelTextDesc.
  ///
  /// In en, this message translates to:
  /// **'Notifications for received text messages'**
  String get notifyChannelTextDesc;

  /// No description provided for @notifyChannelFileName.
  ///
  /// In en, this message translates to:
  /// **'File Transfers'**
  String get notifyChannelFileName;

  /// No description provided for @notifyChannelFileDesc.
  ///
  /// In en, this message translates to:
  /// **'Notifications for file transfer requests'**
  String get notifyChannelFileDesc;

  /// No description provided for @notifyTitleText.
  ///
  /// In en, this message translates to:
  /// **'{senderName} sent you a text'**
  String notifyTitleText(String senderName);

  /// No description provided for @notifyTitleFile.
  ///
  /// In en, this message translates to:
  /// **'{senderName} sent you a file request'**
  String notifyTitleFile(String senderName);

  /// No description provided for @notifyActionReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get notifyActionReject;

  /// No description provided for @notifyActionCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get notifyActionCopy;

  /// No description provided for @notifyActionShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get notifyActionShare;

  /// No description provided for @notifyActionAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get notifyActionAccept;

  /// No description provided for @bubbleReceiveFile.
  ///
  /// In en, this message translates to:
  /// **'Receive file from {senderName}?'**
  String bubbleReceiveFile(String senderName);

  /// No description provided for @bubbleReceiveText.
  ///
  /// In en, this message translates to:
  /// **'{senderName} sent you a text:'**
  String bubbleReceiveText(String senderName);

  /// No description provided for @bubbleAcceptSaveAs.
  ///
  /// In en, this message translates to:
  /// **'Accept & Save As...'**
  String get bubbleAcceptSaveAs;

  /// No description provided for @bubbleNoFiles.
  ///
  /// In en, this message translates to:
  /// **'No files info'**
  String get bubbleNoFiles;

  /// No description provided for @bubbleMoreFiles.
  ///
  /// In en, this message translates to:
  /// **'+ {count} more file(s)'**
  String bubbleMoreFiles(int count);

  /// No description provided for @bubbleCopied.
  ///
  /// In en, this message translates to:
  /// **'Message copied to clipboard'**
  String get bubbleCopied;

  /// No description provided for @bubbleReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get bubbleReject;

  /// No description provided for @settingsSound.
  ///
  /// In en, this message translates to:
  /// **'Sound Settings'**
  String get settingsSound;

  /// No description provided for @settingsSoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage sound effects'**
  String get settingsSoundSubtitle;

  /// No description provided for @soundDownloadComplete.
  ///
  /// In en, this message translates to:
  /// **'Download Complete'**
  String get soundDownloadComplete;

  /// No description provided for @soundDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Download Failed'**
  String get soundDownloadFailed;

  /// No description provided for @soundError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get soundError;

  /// No description provided for @soundNewEvent.
  ///
  /// In en, this message translates to:
  /// **'New Event'**
  String get soundNewEvent;

  /// No description provided for @soundNotice.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get soundNotice;

  /// No description provided for @soundDeviceFound.
  ///
  /// In en, this message translates to:
  /// **'Device Found'**
  String get soundDeviceFound;

  /// No description provided for @soundShareReceived.
  ///
  /// In en, this message translates to:
  /// **'Share Received'**
  String get soundShareReceived;

  /// No description provided for @soundSystemNotify.
  ///
  /// In en, this message translates to:
  /// **'System Notification'**
  String get soundSystemNotify;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'ko',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
