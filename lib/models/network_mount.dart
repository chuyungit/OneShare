import 'package:flutter/material.dart';

enum MountType { openList, smb, sftp, webDav }

class NetworkMount {
  final String id;
  final String name;
  final MountType type;
  final String host;
  final int port;
  final String path; // Remote path
  final String username;
  final String password;

  NetworkMount({
    required this.id,
    required this.name,
    required this.type,
    required this.host,
    this.port = 0, // 0 means default for protocol
    this.path = '/',
    this.username = '',
    this.password = '',
  });

  // Serialization for SharedPrefs
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'host': host,
      'port': port,
      'path': path,
      'username': username,
      'password': password,
    };
  }

  factory NetworkMount.fromJson(Map<String, dynamic> json) {
    return NetworkMount(
      id: json['id'],
      name: json['name'],
      type: MountType.values[json['type']],
      host: json['host'],
      port: json['port'],
      path: json['path'] ?? '/',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  IconData get icon {
    switch (type) {
      case MountType.openList:
        return Icons.cloud_queue;
      case MountType.smb:
        return Icons.storage;
      case MountType.sftp:
        return Icons.terminal;
      case MountType.webDav:
        return Icons.language;
    }
  }
}
