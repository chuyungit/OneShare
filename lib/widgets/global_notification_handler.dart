import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oneshare/models/share_model.dart';
import 'package:oneshare/services/notification_service.dart';
import 'package:oneshare/widgets/message_bubble.dart';
import 'package:oneshare/widgets/linux_message_bubble.dart';
import 'package:oneshare/l10n/app_localizations.dart';

class GlobalNotificationHandler extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const GlobalNotificationHandler({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  @override
  State<GlobalNotificationHandler> createState() =>
      _GlobalNotificationHandlerState();
}

class _GlobalNotificationHandlerState extends State<GlobalNotificationHandler> {
  StreamSubscription<MessageNotification>? _notificationSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        debugPrint('GlobalNotificationHandler: Subscribing to notifications');
        // Listen for bubble notifications globally
        _notificationSubscription = context
            .read<ShareModel>()
            .notificationStream
            .listen((notification) {
          debugPrint('GlobalNotificationHandler: Received notification: ${notification.message}');
          if (mounted) {
            // Use the local context to find the Overlay. 
            // Since this widget is in MaterialApp.builder, it has access to the root overlay.
            if (Platform.isLinux) {
              LinuxMessageBubbleOverlay.show(context, notification);
            } else {
              MessageBubbleOverlay.show(context, notification);
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Update localizations for system notifications
    // We use the context from the navigator to ensure we get the correct locale from the app tree
    // providing that the navigator is mounted. If not, we fall back to this context.
    final navContext = widget.navigatorKey.currentState?.context;
    if (navContext != null) {
       final l10n = AppLocalizations.of(navContext);
       if (l10n != null) {
         NotificationService().updateLocalizations(l10n);
       }
    }
    
    return widget.child;
  }
}
