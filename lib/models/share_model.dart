import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oneshare/services/discovery_service.dart';
import 'package:oneshare/services/websocket_transfer_service.dart';
import 'package:oneshare/services/file_transfer_service.dart';
import 'package:oneshare/services/notification_service.dart';
import 'package:oneshare/services/sound_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

class ShareModel extends ChangeNotifier {
  final DiscoveryService _discoveryService = DiscoveryService();
  final WebSocketTransferService _transferService = WebSocketTransferService();
  final FileTransferService _fileTransferService = FileTransferService();
  final NotificationService _notificationService = NotificationService();
  SoundService? soundService;

  final List<DiscoveredDevice> _peers = [];
  final Map<String, DateTime> _lastSeen = {};
  bool _isScanning = false;
  DiscoveredDevice? _me;
  String? _persistentDeviceId;

  StreamSubscription? _discoverySubscription;
  Timer? _cleanupTimer;
  Future<void>? _initFuture;

  List<DiscoveredDevice> get peers => List.unmodifiable(_peers);
  bool get isScanning => _isScanning;
  DiscoveredDevice? get me => _me;
  Stream<MessageNotification> get notificationStream =>
      _notificationService.bubbleStream;

  ShareModel() {
    _initFuture = _init();
  }

  void updateSoundService(SoundService service) {
    soundService = service;
  }

  Future<void> _init() async {
    // Initialize notification service
    await _notificationService.initialize();

    // Load persistent ID
    final prefs = await SharedPreferences.getInstance();
    _persistentDeviceId = prefs.getString('device_id');
    if (_persistentDeviceId == null) {
      // Generate a semi-persistent ID
      _persistentDeviceId =
          '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(9999)}';
      await prefs.setString('device_id', _persistentDeviceId!);
    }
  }

  Future<void> startScanning() async {
    if (_isScanning) return;

    // Ensure init is done so we have ID
    if (_initFuture != null) {
      await _initFuture;
    }

    _isScanning = true;
    _peers.clear();
    _lastSeen.clear();
    notifyListeners();

    String deviceName = Platform.localHostname;
    try {
      deviceName = await _getDeviceName();
    } catch (e) {
      debugPrint("Error fetching device name: $e");
    }

    // Start WebSocket server first
    await _transferService.startServer(deviceName: deviceName);

    // Set up callbacks
    _transferService.onMessageReceived = _handleMessageReceived;
    _transferService.onFileOfferReceived = _handleFileOfferReceived;

    _me = DiscoveredDevice(
      id: _persistentDeviceId!,
      name: deviceName,
      osType: Platform.operatingSystem,
      deviceType: _getDeviceType(),
      ip: '', // Service fills valid IP of interface
      port: 61045, // Legacy TCP port for compatibility
      wsPort: _transferService.port, // WebSocket port
    );

    // Provide immediate feedback on me
    notifyListeners();

    await _discoveryService.start(_me!);

    _discoverySubscription?.cancel();
    _discoverySubscription = _discoveryService.deviceStream.listen(
      _handleDeviceDiscovered,
    );

    _startCleanupTimer();
  }

  void _handleMessageReceived(
    String senderName,
    String message,
    String senderIp,
  ) {
    debugPrint('Message received from $senderName: $message');

    // Show bubble notification
    _notificationService.showBubbleNotification(
      senderName: senderName,
      message: message,
      senderIp: senderIp,
    );

    // Show system notification (Android/iOS)
    _notificationService.showSystemNotification(
      senderName: senderName,
      message: message,
      senderIp: senderIp,
    );

    // Play sound
    soundService?.playShareReceived();
  }

  void _handleFileOfferReceived(
    String senderName,
    List<dynamic> files,
    String senderIp,
    int port,
  ) {
    debugPrint('File offer received from $senderName: ${files.length} files');
    
    // Show bubble notification with file offer
    _notificationService.showBubbleNotification(
      senderName: senderName,
      message: 'Offered ${files.length} file(s)',
      senderIp: senderIp,
      type: NotificationType.fileOffer,
      files: files,
      port: port,
    );

    // Show system notification
    _notificationService.showSystemNotification(
      senderName: senderName,
      message: 'Offered ${files.length} file(s)',
      senderIp: senderIp,
      type: NotificationType.fileOffer,
    );
    
    soundService?.playNewEvent();
  }

  void _handleDeviceDiscovered(DiscoveredDevice device) {
    // Already filtered by service hopefully, but double check
    if (device.id == _me?.id) return;

    _lastSeen[device.id] = DateTime.now();

    final index = _peers.indexWhere((p) => p.id == device.id);
    if (index != -1) {
      // Update existing if details changed
      final existing = _peers[index];
      if (existing.ip != device.ip ||
          existing.port != device.port ||
          existing.wsPort != device.wsPort ||
          existing.name != device.name) {
        _peers[index] = device;
        notifyListeners();
      }
    } else {
      _peers.add(device);
      notifyListeners();
      soundService?.playDeviceFound();
    }
  }

  void _startCleanupTimer() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final now = DateTime.now();
      bool removed = false;
      _peers.removeWhere((p) {
        final last = _lastSeen[p.id];
        // If not seen for 5 seconds, remove (broadcast is every 2s)
        // Reduced from 8 to 5 seconds for faster disconnect detection
        if (last == null || now.difference(last).inSeconds > 5) {
          removed = true;
          return true;
        }
        return false;
      });

      if (removed) {
        notifyListeners();
      }
    });
  }

  void stopScanning() {
    _isScanning = false;
    _discoveryService.stop();
    _discoverySubscription?.cancel();
    _cleanupTimer?.cancel();
    _transferService.stopServer();
    _fileTransferService.stopServer();
    notifyListeners();
  }

  Future<bool> sendText(DiscoveredDevice peer, String text) async {
    if (text.isEmpty) {
      return false;
    }

    if (text.length > 2048) {
      throw Exception('Message exceeds 2048 character limit');
    }

    debugPrint("Sending text to ${peer.ip}:${peer.wsPort} -> $text");

    try {
      final success = await _transferService.sendTextMessage(
        peer.ip,
        peer.wsPort,
        text,
      );

      if (success) {
        debugPrint("Message sent successfully");
      } else {
        debugPrint("Failed to send message");
      }

      return success;
    } catch (e) {
      debugPrint("Error sending text: $e");
      return false;
    }
  }

  Future<bool> sendFiles(DiscoveredDevice peer) async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result == null || result.files.isEmpty) return false;

      final files = result.paths.where((p) => p != null).map((p) => File(p!)).toList();
      if (files.isEmpty) return false;

      // Start HTTP server to serve these files
      final serverPort = await _fileTransferService.startServer(files);

      // Prepare file list for offer
      final fileList = result.files.map((f) => {
        'fileName': f.name,
        'fileSize': f.size,
      }).toList();

      // Send offer via WebSocket
      final success = await _transferService.sendFileOffer(
        peer.ip,
        peer.wsPort,
        fileList,
        serverPort,
      );

      return success;
    } catch (e) {
      debugPrint("Error sending files: $e");
      return false;
    }
  }

  String _getDeviceType() {
    if (Platform.isAndroid || Platform.isIOS) return 'mobile';
    return 'desktop';
  }

  Future<String> _getDeviceName() async {
    if (Platform.isAndroid) {
      // Android 12+ (SDK 31) requires BLUETOOTH_CONNECT to get the user-set device name.
      // Earlier versions might just return model or market name.
      if (await Permission.bluetoothConnect.status.isDenied) {
        try {
          await Permission.bluetoothConnect.request();
        } catch (e) {
          debugPrint("Failed to request bluetooth permission: $e");
        }
      }

      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      // 'model' is the hardware model (e.g. Pixel 6).
      // 'device' is the device name.
      // If we want the user-friendly name, typically we need more, but 'model' is safe.
      // Let's try to combine them or just use model as it's reliable.
      return "${deviceInfo.brand} ${deviceInfo.model}";
    } else if (Platform.isIOS) {
      // iOS usually prompts for permission if we access the name
      final deviceInfo = await DeviceInfoPlugin().iosInfo;
      return deviceInfo.name;
    } else if (Platform.isLinux) {
      return Platform.localHostname;
    } else if (Platform.isMacOS) {
      final deviceInfo = await DeviceInfoPlugin().macOsInfo;
      return deviceInfo.computerName;
    } else if (Platform.isWindows) {
      final deviceInfo = await DeviceInfoPlugin().windowsInfo;
      return deviceInfo.computerName;
    }

    return Platform.localHostname;
  }

  @override
  void dispose() {
    stopScanning();
    _notificationService.dispose();
    super.dispose();
  }
}
