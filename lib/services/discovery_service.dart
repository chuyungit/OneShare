import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';

class DiscoveredDevice {
  final String id;
  final String name;
  final String osType; // windows, android, ios, macos, linux, web
  final String deviceType; // desktop, mobile, tablet
  final String ip;
  final int port; // Transfer service port (TCP)
  final int wsPort; // WebSocket port

  DiscoveredDevice({
    required this.id,
    required this.name,
    required this.osType,
    required this.deviceType,
    required this.ip,
    required this.port,
    required this.wsPort,
  });

  factory DiscoveredDevice.fromJson(Map<String, dynamic> json, String ip) {
    return DiscoveredDevice(
      id: json['id'],
      name: json['name'],
      osType: json['osType'],
      deviceType: json['deviceType'],
      port: json['port'],
      wsPort: json['wsPort'] ?? 8080, // Default for backward compatibility
      ip: ip,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'osType': osType,
      'deviceType': deviceType,
      'port': port,
      'wsPort': wsPort,
    };
  }
}

class DiscoveryService {
  static const int _port = 43210;
  RawDatagramSocket? _socket;
  final StreamController<DiscoveredDevice> _deviceController =
      StreamController.broadcast();
  Timer? _broadcastTimer;
  DiscoveredDevice? _me;

  Stream<DiscoveredDevice> get deviceStream => _deviceController.stream;

  Future<void> start(DiscoveredDevice me) async {
    if (_socket != null) {
      debugPrint("Discovery Service already running.");
      return;
    }
    _me = me;
    try {
      _socket = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        _port,
        reuseAddress: true,
      );
      _socket!.broadcastEnabled = true;
      _socket!.listen(_handlePacket);

      _startBroadcasting();
      debugPrint("Discovery Service started on port $_port");
    } catch (e) {
      debugPrint("Error starting discovery service: $e");
    }
  }

  void stop() {
    _broadcastTimer?.cancel();
    _socket?.close();
    _socket = null;
    debugPrint("Discovery Service stopped");
  }

  void _handlePacket(RawSocketEvent event) {
    if (event == RawSocketEvent.read) {
      final datagram = _socket?.receive();
      if (datagram != null) {
        try {
          final message = utf8.decode(datagram.data);
          final json = jsonDecode(message);

          // Ignore own packets
          if (json['id'] == _me?.id) return;

          final device = DiscoveredDevice.fromJson(
            json,
            datagram.address.address,
          );
          _deviceController.add(device);
        } catch (e) {
          // Flatten error
        }
      }
    }
  }

  void _startBroadcasting() {
    _broadcastTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (_socket != null && _me != null) {
        final data = jsonEncode(_me!.toJson());
        final encoded = utf8.encode(data);

        // Broadcast to 255.255.255.255
        try {
          _socket!.send(encoded, InternetAddress("255.255.255.255"), _port);
        } catch (e) {
          debugPrint("Error broadcasting to 255.255.255.255: $e");
        }

        // Broadcast to subnet (assuming /24) for each interface
        try {
          final interfaces = await NetworkInterface.list(
            type: InternetAddressType.IPv4,
          );
          for (final interface in interfaces) {
            for (final address in interface.addresses) {
              if (!address.isLoopback) {
                final ip = address.address;
                final parts = ip.split('.');
                if (parts.length == 4) {
                  parts[3] = '255';
                  final broadcastIp = parts.join('.');
                  try {
                    _socket!.send(encoded, InternetAddress(broadcastIp), _port);
                  } catch (e) {
                    // Ignore send errors for specific addresses
                  }
                }
              }
            }
          }
        } catch (e) {
          debugPrint("Error listing interfaces: $e");
        }
      }
    });
  }
}
