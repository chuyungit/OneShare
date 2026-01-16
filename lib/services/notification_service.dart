import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:share_plus/share_plus.dart';
import 'package:oneshare/l10n/app_localizations.dart';

/// Notification types
enum NotificationType { text, fileOffer }

/// Notification action types
enum NotificationAction { reject, copy, share, accept, acceptAndSave }

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print(
    'notification(${notificationResponse.id}) action tapped: '
    '${notificationResponse.actionId} with payload: ${notificationResponse.payload}',
  );
}

/// Notification service for handling in-app and system notifications
class NotificationService with WidgetsBindingObserver {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _isInForeground = true;
  AppLocalizations? _l10n;
  final _bubbleStreamController =
      StreamController<MessageNotification>.broadcast();

  Stream<MessageNotification> get bubbleStream =>
      _bubbleStreamController.stream;

  /// Update localizations
  void updateLocalizations(AppLocalizations l10n) {
    _l10n = l10n;
  }

  /// Initialize notification service
  Future<void> initialize() async {
    if (_initialized) return;

    WidgetsBinding.instance.addObserver(this);

    if (Platform.isAndroid || Platform.isIOS || Platform.isLinux) {
      await _initializeLocalNotifications();
    }

    _initialized = true;
    debugPrint('Notification service initialized');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isInForeground = state == AppLifecycleState.resumed;
    debugPrint(
      'App lifecycle state changed: $state, inForeground: $_isInForeground',
    );
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      linux: linuxSettings,
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _handleNotificationAction,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Request permissions for Android 13+
    if (Platform.isAndroid) {
      await _requestAndroidPermissions();
    }
  }

  /// Request Android notification permissions
  Future<void> _requestAndroidPermissions() async {
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    }
  }

  /// Show in-app bubble notification
  void showBubbleNotification({
    required String senderName,
    required String message,
    required String senderIp,
    NotificationType type = NotificationType.text,
    List<dynamic>? files,
    int? port,
  }) {
    final notification = MessageNotification(
      senderName: senderName,
      message: message,
      senderIp: senderIp,
      timestamp: DateTime.now(),
      type: type,
      files: files,
      port: port,
    );

    _bubbleStreamController.add(notification);
  }

  /// Show system notification (Android/iOS/Linux)
  Future<void> showSystemNotification({
    required String senderName,
    required String message,
    required String senderIp,
    NotificationType type = NotificationType.text,
    bool force = false,
  }) async {
    if (!Platform.isAndroid && !Platform.isIOS && !Platform.isLinux) {
      debugPrint('System notifications only supported on Android/iOS/Linux');
      return;
    }

    if (!force && _isInForeground) {
      debugPrint('App is in foreground, suppressing system notification');
      return;
    }

    String channelId = 'text_messages';
    String channelName = _l10n?.notifyChannelTextName ?? 'Text Messages';
    String channelDescription =
        _l10n?.notifyChannelTextDesc ??
        'Notifications for received text messages';

    if (type == NotificationType.fileOffer) {
      channelId = 'file_transfers';
      channelName = _l10n?.notifyChannelFileName ?? 'File Transfers';
      channelDescription =
          _l10n?.notifyChannelFileDesc ??
          'Notifications for file transfer requests';
    }

    final String title = type == NotificationType.text
        ? (_l10n?.notifyTitleText(senderName) ?? '$senderName ')
        : (_l10n?.notifyTitleFile(senderName) ?? '$senderName ');

    final String contentTitle = '$title:';

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(
        message,
        htmlFormatBigText: true,
        contentTitle: contentTitle,
        htmlFormatContentTitle: true,
      ),
      actions: type == NotificationType.text
          ? [
              AndroidNotificationAction(
                'reject',
                _l10n?.notifyActionReject ?? 'Reject',
                cancelNotification: true,
                showsUserInterface: false,
              ),
              AndroidNotificationAction(
                'copy',
                _l10n?.notifyActionCopy ?? 'Copy',
                showsUserInterface: true,
              ),
              AndroidNotificationAction(
                'share',
                _l10n?.notifyActionShare ?? 'Share',
                showsUserInterface: true,
              ),
            ]
          : [
              AndroidNotificationAction(
                'reject',
                _l10n?.notifyActionReject ?? 'Reject',
                cancelNotification: true,
                showsUserInterface: false,
              ),
              AndroidNotificationAction(
                'accept',
                _l10n?.notifyActionAccept ?? 'Accept',
                showsUserInterface: true,
              ),
            ],
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const linuxDetails = LinuxNotificationDetails();

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      linux: linuxDetails,
    );

    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _notificationsPlugin.show(
      notificationId,
      title,
      message,
      details,
      payload: '$senderName|$message|$senderIp|${type.name}',
    );
  }

  /// Handle notification actions
  void _handleNotificationAction(NotificationResponse response) {
    // Explicitly cancel the notification to ensure it's removed
    if (response.id != null) {
      _notificationsPlugin.cancel(response.id!);
    }

    if (response.payload == null) return;

    final parts = response.payload!.split('|');
    if (parts.length < 2) return;

    final message = parts.length > 1 ? parts[1] : '';
    // We could parse type here if needed

    switch (response.actionId) {
      case 'reject':
        debugPrint('Message rejected');
        break;
      case 'copy':
        _copyToClipboard(message);
        break;
      case 'share':
        _shareMessage(message);
        break;
      case 'accept':
        // For file accept, typically this would open the app and trigger logic.
        // Handling deep link or bringing app to foreground is default behavior for 'showsUserInterface: true'.
        debugPrint('File accepted via notification');
        break;
      default:
        // Notification tapped (no action button)
        debugPrint('Notification tapped');
    }
  }

  /// Copy message to clipboard
  Future<void> _copyToClipboard(String message) async {
    await Clipboard.setData(ClipboardData(text: message));
    debugPrint('Message copied to clipboard');
  }

  /// Share message using system share
  Future<void> _shareMessage(String message) async {
    await Share.share(message);
  }

  /// Dispose notification service
  void dispose() {
    _bubbleStreamController.close();
  }
}

/// Message notification data class
class MessageNotification {
  final String senderName;
  final String message;
  final String senderIp;
  final DateTime timestamp;
  final NotificationType type;
  final List<dynamic>? files; // For file offers
  final int? port; // For file offers

  MessageNotification({
    required this.senderName,
    required this.message,
    required this.senderIp,
    required this.timestamp,
    this.type = NotificationType.text,
    this.files,
    this.port,
  });
}
