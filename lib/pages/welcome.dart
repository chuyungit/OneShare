import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:oneshare/models/settings_model.dart';
import 'package:oneshare/l10n/app_localizations.dart';
import 'package:oneshare/pages/main_page.dart';

enum WelcomeType {
  install,
  update
}

class WelcomePage extends StatefulWidget {
  final WelcomeType type;
  final String currentVersion;

  const WelcomePage({
    super.key,
    required this.type,
    required this.currentVersion,
  });

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  // Flattens features into the main flow for Install type
  late final int _totalPages; 

  @override
  void initState() {
    super.initState();
    // 0: Welcome, 1: Language, 2,3,4: Features, 5: Complete
    _totalPages = 6; 
  }

  @override
  Widget build(BuildContext context) {
    // If it's an update, we use a simpler layout (or the existing one).
    // The prompt specifically described a setup wizard which implies 'install'.
    // For 'update', I'll keep the logic simple or reuse parts.
    if (widget.type == WelcomeType.update) {
       return Scaffold(body: SafeArea(child: _buildUpdateContent(context)));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(), // Allow swiping
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildWelcomeStep(context),
                  _buildLanguageStep(context),
                  _buildFeatureSlide(
                    context,
                    icon: Icons.share,
                    title: AppLocalizations.of(context)!.welcomeFeature1Title,
                    description:
                        AppLocalizations.of(context)!.welcomeFeature1Desc,
                  ),
                  _buildFeatureSlide(
                    context,
                    icon: Icons.cloud_queue,
                    title: AppLocalizations.of(context)!.welcomeFeature2Title,
                    description:
                        AppLocalizations.of(context)!.welcomeFeature2Desc,
                  ),
                  _buildFeatureSlide(
                    context,
                    icon: Icons.devices,
                    title: AppLocalizations.of(context)!.welcomeFeature3Title,
                    description:
                        AppLocalizations.of(context)!.welcomeFeature3Desc,
                  ),
                  _buildCompletionStep(context),
                ],
              ),
            ),
            // Bottom navigation/indicators (hide on last page if we want full focus, but usually good to keep)
            if (_currentPage < _totalPages - 1)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Skip button (optional, maybe only for features)
                    _currentPage > 1 
                        ? TextButton(
                            onPressed: () => _pageController.animateToPage(
                              _totalPages - 1, 
                              duration: const Duration(milliseconds: 300), 
                              curve: Curves.easeInOut
                            ),
                            child: Text(AppLocalizations.of(context)!.welcomeSkip),
                          )
                        : const SizedBox(width: 64), // Placeholder for spacing

                    // Indicators
                    Row(
                      children: List.generate(_totalPages, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentPage == index ? 24.0 : 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _currentPage == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surfaceContainerHighest,
                          ),
                        );
                      }),
                    ),

                    // Next Button
                    FilledButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.welcomeNext),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // STEP 1: Welcome & Version
  Widget _buildWelcomeStep(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo could go here
        Icon(Icons.rocket_launch, size: 80, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 40),
        Text(
          AppLocalizations.of(context)!.welcomeTitle,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            AppLocalizations.of(context)!.welcomeVersion(widget.currentVersion),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ],
    );
  }

  // STEP 2: Language Settings
  Widget _buildLanguageStep(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.settingsLanguage,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.welcomeChooseLanguage,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 40),
          Consumer<SettingsModel>(
            builder: (context, settings, child) {
              final isSystem = settings.locale == null;
              // Ensure we have a valid locale to display for the "Manual" selector
              // If settings.locale is null, we show the first supported one (or current system one if we could get it easily)
              // For the dropdown value, it must match an item in the list.
              final displayLocale = settings.locale ?? AppLocalizations.supportedLocales.first;

              return Column(
                children: [
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.welcomeUseSystemLanguage),
                    subtitle: Text(
                      AppLocalizations.of(context)!.welcomeCurrentLocale(Localizations.localeOf(context).toString()),
                    ),
                    value: isSystem,
                    onChanged: (bool value) {
                      if (value) {
                        settings.setLocale(null);
                      } else {
                        // When turning off system, default to current resolved locale if supported, else first supported
                        // Since we can't easily check if resolved is in supported list without logic:
                        settings.setLocale(AppLocalizations.supportedLocales.first); 
                      }
                    },
                  ),
                  const Divider(),
                  AnimatedOpacity(
                    opacity: isSystem ? 0.5 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: IgnorePointer(
                      ignoring: isSystem,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.welcomeSelectLanguage,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.language),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Locale>(
                            isDense: true,
                            isExpanded: true,
                            value: isSystem 
                                ? (AppLocalizations.supportedLocales.contains(settings.locale) ? settings.locale : AppLocalizations.supportedLocales.first) 
                                : displayLocale,
                            items: AppLocalizations.supportedLocales.map((locale) {
                              return DropdownMenuItem(
                                value: locale,
                                child: Text(_getLocaleName(locale)),
                              );
                            }).toList(),
                            onChanged: (Locale? newLocale) {
                              settings.setLocale(newLocale);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
  
  String _getLocaleName(Locale locale) {
    // Simple mapping, ideally this would be localized too
    switch (locale.languageCode) {
      case 'en': return 'English';
      case 'zh': return '中文 (Chinese)';
      case 'ja': return '日本語 (Japanese)';
      case 'ko': return '한국어 (Korean)';
      case 'de': return 'Deutsch';
      case 'fr': return 'Français';
      case 'es': return 'Español';
      default: return locale.toString();
    }
  }

  // STEP 3, 4, 5: Features (Reusable)
  Widget _buildFeatureSlide(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 80, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // STEP 6: Completion
  Widget _buildCompletionStep(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isMobile = platform == TargetPlatform.android || platform == TargetPlatform.iOS;

    if (isMobile) {
      return GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < -500) { // Swipe Up
            _completeWelcome();
          }
        },
        child: Container(
          color: Colors.transparent, // Ensure hits are detected
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 32),
              Text(
                AppLocalizations.of(context)!.welcomeAllSet,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.welcomeSetupComplete,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Column(
                children: [
                  Icon(Icons.keyboard_arrow_up, 
                    size: 40, 
                    color: Theme.of(context).colorScheme.secondary
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.welcomeSwipeUp,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40), 
            ],
          ),
        ),
      );
    } else {
      // Desktop: Click or Key press
      return GestureDetector(
        onTap: _completeWelcome,
        behavior: HitTestBehavior.opaque,
        child: Focus(
          autofocus: true,
          onKeyEvent: (node, event) {
             if (event is KeyDownEvent) {
                 _completeWelcome();
                 return KeyEventResult.handled;
             }
             return KeyEventResult.ignored;
          },
          child: Container(
            color: Colors.transparent, 
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, size: 100, color: Colors.green),
                const SizedBox(height: 32),
                Text(
                  AppLocalizations.of(context)!.welcomeAllSet,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.welcomeSetupComplete,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Column(
                  children: [
                    Icon(Icons.touch_app, 
                      size: 40, 
                      color: Theme.of(context).colorScheme.secondary
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.welcomeClickToEnter,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40), 
              ],
            ),
          ),
        ),
      );
    }
  }

  // --- Update Content (Existing logic preserved mostly) ---
  Widget _buildUpdateContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            AppLocalizations.of(context)!.welcomeWhatsNew,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          Text(
            AppLocalizations.of(context)!.welcomeVersion(widget.currentVersion),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChangeLogItem(context, AppLocalizations.of(context)!.welcomeLogPerformance),
                  _buildChangeLogItem(context, AppLocalizations.of(context)!.welcomeLogBugFixes),
                  _buildChangeLogItem(context, AppLocalizations.of(context)!.welcomeLogUI),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _completeWelcome,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Center(child: Text(AppLocalizations.of(context)!.welcomeContinue)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeLogItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, 
              size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  void _completeWelcome() async {
    final settings = Provider.of<SettingsModel>(context, listen: false);
    await settings.setLastVersion(widget.currentVersion);
    
    if (mounted) {
      // Animate transition upwards
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    }
  }
}