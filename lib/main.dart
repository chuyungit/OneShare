import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:oneshare/l10n/app_localizations.dart';
import 'package:oneshare/models/share_model.dart';
import 'package:oneshare/models/download_model.dart';
import 'package:oneshare/models/theme_model.dart';
import 'package:oneshare/models/settings_model.dart';
import 'package:oneshare/services/sound_service.dart';
import 'package:oneshare/services/background_service.dart';
import 'package:oneshare/services/tray_service.dart';
import 'package:oneshare/pages/main_page.dart';
import 'package:oneshare/pages/welcome.dart';
import 'package:oneshare/widgets/global_notification_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeBackgroundService();
  await TrayService().init();

  final themeModel = ThemeModel();
  await themeModel.loadTheme();

  final settingsModel = SettingsModel();
  await settingsModel.loadSettings();

  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;
  final lastVersion = settingsModel.lastVersion;

  Widget initialWidget;
  if (lastVersion == null) {
    initialWidget = WelcomePage(
      type: WelcomeType.install,
      currentVersion: currentVersion,
    );
  } else if (lastVersion != currentVersion) {
    initialWidget = WelcomePage(
      type: WelcomeType.update,
      currentVersion: currentVersion,
    );
  } else {
    initialWidget = const MainPage();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeModel),
        ChangeNotifierProvider.value(value: settingsModel),
        ProxyProvider<SettingsModel, SoundService>(
          create: (_) => SoundService(),
          update: (_, settings, soundService) =>
              soundService!..updateSettings(settings),
        ),
        ChangeNotifierProxyProvider<SoundService, DownloadModel>(
          create: (_) => DownloadModel(),
          update: (_, soundService, downloadModel) =>
              downloadModel!..updateSoundService(soundService),
        ),
        ChangeNotifierProxyProvider<SoundService, ShareModel>(
          create: (_) => ShareModel(),
          update: (_, soundService, shareModel) =>
              shareModel!..updateSoundService(soundService),
        ),
      ],
      child: OneShareApp(home: initialWidget),
    ),
  );
}

class OneShareApp extends StatelessWidget {

  final Widget home;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();



  const OneShareApp({super.key, required this.home});



  @override

  Widget build(BuildContext context) {

    return Consumer2<ThemeModel, SettingsModel>(

      builder: (context, themeModel, settingsModel, child) {

        return MaterialApp(

          navigatorKey: navigatorKey,

          locale: settingsModel.locale,

          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,

          localizationsDelegates: const [

            AppLocalizations.delegate,

            GlobalMaterialLocalizations.delegate,

            GlobalWidgetsLocalizations.delegate,

            GlobalCupertinoLocalizations.delegate,

          ],

          supportedLocales: AppLocalizations.supportedLocales,

          localeResolutionCallback: (locale, supportedLocales) {

            if (settingsModel.locale != null) {

              return settingsModel.locale;

            }

            if (locale != null) {

              for (var supportedLocale in supportedLocales) {

                if (supportedLocale.languageCode == locale.languageCode &&

                    supportedLocale.scriptCode == locale.scriptCode) {

                  return supportedLocale;

                }

              }

            }

            return supportedLocales.first;

          },

          theme: ThemeData(

            useMaterial3: true,

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

            fontFamily: themeModel.fontFamily,

          ),

          darkTheme: ThemeData(

            useMaterial3: true,

            colorScheme: ColorScheme.fromSeed(

              seedColor: Colors.blue,

              brightness: Brightness.dark,

            ),

            fontFamily: themeModel.fontFamily,

          ),

          themeMode: themeModel.themeMode,

          builder: (context, child) {

            return GlobalNotificationHandler(

              navigatorKey: navigatorKey,

              child: child!,

            );

          },

          home: home,

        );

      },

    );

  }

}