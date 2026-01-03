import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneshare/l10n/app_localizations.dart';
import 'package:oneshare/pages/share.dart';
import 'package:oneshare/pages/web.dart';
import 'package:oneshare/pages/downloading.dart';
import 'package:oneshare/pages/settings.dart';
import 'package:oneshare/services/tray_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    SharePage(),
    WebPage(),
    DownloadPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    TrayService().updateContextMenu(AppLocalizations.of(context)!);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile layout
          return Scaffold(
            body: _pages[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: [
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/images/navigation/page.share.svg',
                    width: 24,
                    height: 24,
                  ),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/navigation/page.share.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.navShare,
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/images/navigation/page.web.svg',
                    width: 24,
                    height: 24,
                  ),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/navigation/page.web.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.navWeb,
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/images/navigation/page.downloading.svg',
                    width: 24,
                    height: 24,
                  ),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/navigation/page.downloading.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.navDownloading,
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/images/navigation/page.settings.svg',
                    width: 24,
                    height: 24,
                  ),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/navigation/page.settings.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.navSettings,
                ),
              ],
            ),
          );
        } else {
          // Desktop / Tablet layout
          final bool isExtended = constraints.maxWidth >= 900;

          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  extended: isExtended,
                  minExtendedWidth: 240,
                  selectedIndex: _selectedIndex,
                  groupAlignment: -1.0, // Top aligned
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: isExtended
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.share,
                                size: 32,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                AppLocalizations.of(context)!.appTitle,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'MiSans',
                                    ),
                              ),
                            ],
                          )
                        : const Icon(Icons.share, size: 32, color: Colors.blue),
                  ),
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: isExtended
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  destinations: [
                    NavigationRailDestination(
                      icon: SvgPicture.asset(
                        'assets/images/navigation/page.share.svg',
                        width: 24,
                        height: 24,
                      ),
                      selectedIcon: SvgPicture.asset(
                        'assets/images/navigation/page.share.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: Text(AppLocalizations.of(context)!.navShare),
                    ),
                    NavigationRailDestination(
                      icon: SvgPicture.asset(
                        'assets/images/navigation/page.web.svg',
                        width: 24,
                        height: 24,
                      ),
                      selectedIcon: SvgPicture.asset(
                        'assets/images/navigation/page.web.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: Text(AppLocalizations.of(context)!.navWeb),
                    ),
                    NavigationRailDestination(
                      icon: SvgPicture.asset(
                        'assets/images/navigation/page.downloading.svg',
                        width: 24,
                        height: 24,
                      ),
                      selectedIcon: SvgPicture.asset(
                        'assets/images/navigation/page.downloading.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: Text(AppLocalizations.of(context)!.navDownloads),
                    ),
                    NavigationRailDestination(
                      icon: SvgPicture.asset(
                        'assets/images/navigation/page.settings.svg',
                        width: 24,
                        height: 24,
                      ),
                      selectedIcon: SvgPicture.asset(
                        'assets/images/navigation/page.settings.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: Text(AppLocalizations.of(context)!.navSettings),
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                Expanded(child: _pages[_selectedIndex]),
              ],
            ),
          );
        }
      },
    );
  }
}
