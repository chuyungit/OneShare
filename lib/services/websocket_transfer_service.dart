import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Message types for WebSocket communication
enum MessageType { textMessage, acknowledgment, ping, pong, fileOffer }

/// WebSocket message structure
class WebSocketMessage {
  final MessageType type;
  final String sender;
  final String content;
  final int timestamp;
  final Map<String, dynamic>? extra;

  WebSocketMessage({
    required this.type,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.extra,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'sender': sender,
    'content': content,
    'timestamp': timestamp,
    if (extra != null) 'extra': extra,
  };

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) {
    return WebSocketMessage(
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.textMessage,
      ),
      sender: json['sender'] ?? '',
      content: json['content'] ?? '',
      timestamp: json['timestamp'] ?? DateTime.now().millisecondsSinceEpoch,
      extra: json['extra'],
    );
  }
}

/// Callback for received messages
typedef OnMessageReceived =
    void Function(String senderName, String message, String senderIp);

/// Callback for received file offers
typedef OnFileOfferReceived =
    void Function(
      String senderName,
      List<dynamic> files,
      String senderIp,
      int port,
    );

/// WebSocket-based transfer service for real-time text transmission
class WebSocketTransferService {
  HttpServer? _server;
  int _port = 8080;
  final List<WebSocket> _activeConnections = [];
  OnMessageReceived? onMessageReceived;
  OnFileOfferReceived? onFileOfferReceived;
  String? _deviceName;

  int get port => _port;
  bool get isRunning => _server != null;

  /// Start WebSocket server
  Future<void> startServer({String? deviceName}) async {
    if (_server != null) {
      debugPrint('WebSocket server already running on port $_port');
      return;
    }

    _deviceName = deviceName ?? Platform.localHostname;

    try {
      // Try to start server on preferred port, or find available port
      for (int portAttempt = _port; portAttempt < _port + 10; portAttempt++) {
        try {
          _server = await HttpServer.bind(InternetAddress.anyIPv4, portAttempt);
          _port = portAttempt;
          debugPrint('WebSocket server started on port $_port');
          break;
        } catch (e) {
          if (portAttempt == _port + 9) {
            throw Exception(
              'Could not find available port for WebSocket server',
            );
          }
        }
      }

      _server!.listen(_handleConnection);
    } catch (e) {
      debugPrint('Failed to start WebSocket server: $e');
      rethrow;
    }
  }

  /// Handle incoming WebSocket connections
  void _handleConnection(HttpRequest request) async {
    if (request.uri.path != '/ws') {
      request.response.statusCode = HttpStatus.notFound;
      request.response.close();
      return;
    }

    // Store remote address before upgrading
    final remoteAddress =
        request.connectionInfo?.remoteAddress.address ?? 'unknown';

    try {
      final socket = await WebSocketTransformer.upgrade(request);
      _activeConnections.add(socket);
      debugPrint(
        'New WebSocket connection from $remoteAddress. Total: ${_activeConnections.length}',
      );

      socket.listen(
        (data) => _handleMessage(socket, data, remoteAddress),
        onError: (error) {
          debugPrint('WebSocket error: $error');
          _removeConnection(socket);
        },
        onDone: () {
          debugPrint('WebSocket connection closed');
          _removeConnection(socket);
        },
      );

      // Send initial ping
      _sendPing(socket);
    } catch (e) {
      debugPrint('Failed to upgrade to WebSocket: $e');
    }
  }

  /// Handle received messages
  void _handleMessage(WebSocket socket, dynamic data, String senderIp) {
    try {
      final json = jsonDecode(data as String);
      final message = WebSocketMessage.fromJson(json);

      switch (message.type) {
        case MessageType.textMessage:
          debugPrint('Received text message from ${message.sender}');

          // Trigger callback
          if (onMessageReceived != null) {
            onMessageReceived!(message.sender, message.content, senderIp);
          }

          // Send acknowledgment
          _sendAcknowledgment(socket, message.sender);
          break;

        case MessageType.fileOffer:
          debugPrint('Received file offer from ${message.sender}');
          final files = message.extra?['files'] as List<dynamic>?;
          final port = message.extra?['port'] as int?;

          if (files != null && port != null && onFileOfferReceived != null) {
            onFileOfferReceived!(message.sender, files, senderIp, port);
          }
          break;

        case MessageType.acknowledgment:
          debugPrint('Received acknowledgment from ${message.sender}');
          break;

        case MessageType.ping:
          _sendPong(socket);
          break;

        case MessageType.pong:
          // Keep-alive received
          break;
      }
    } catch (e) {
      debugPrint('Error handling message: $e');
    }
  }

  /// Send file offer to another device
  Future<bool> sendFileOffer(
    String recipientIp,
    int recipientPort,
    List<Map<String, dynamic>> files,
    int serverPort, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    WebSocketChannel? channel;

    try {
      final uri = Uri.parse('ws://$recipientIp:$recipientPort/ws');
      channel = WebSocketChannel.connect(uri);

      final msg = WebSocketMessage(
        type: MessageType.fileOffer,
        sender: _deviceName ?? 'Unknown',
        content: 'I want to share ${files.length} file(s) with you',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        extra: {'files': files, 'port': serverPort},
      );

      channel.sink.add(jsonEncode(msg.toJson()));

      // For file offer, we might not wait for ACK in the same way
      // as text if the UI handles the next steps (like auto-download)
      return true;
    } catch (e) {
      debugPrint('Failed to send file offer: $e');
      return false;
    } finally {
      // Keep channel open or close? Typically we send and close for simple RPC
      await channel?.sink.close();
    }
  }

  /// Send acknowledgment
  void _sendAcknowledgment(WebSocket socket, String recipient) {
    final ack = WebSocketMessage(
      type: MessageType.acknowledgment,
      sender: _deviceName ?? 'Unknown',
      content: 'Message received',
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      socket.add(jsonEncode(ack.toJson()));
    } catch (e) {
      debugPrint('Failed to send acknowledgment: $e');
    }
  }

  /// Send ping
  void _sendPing(WebSocket socket) {
    final ping = WebSocketMessage(
      type: MessageType.ping,
      sender: _deviceName ?? 'Unknown',
      content: '',
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      socket.add(jsonEncode(ping.toJson()));
    } catch (e) {
      debugPrint('Failed to send ping: $e');
    }
  }

  /// Send pong
  void _sendPong(WebSocket socket) {
    final pong = WebSocketMessage(
      type: MessageType.pong,
      sender: _deviceName ?? 'Unknown',
      content: '',
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      socket.add(jsonEncode(pong.toJson()));
    } catch (e) {
      debugPrint('Failed to send pong: $e');
    }
  }

  /// Remove disconnected connection
  void _removeConnection(WebSocket socket) {
    _activeConnections.remove(socket);
    try {
      socket.close();
    } catch (e) {
      debugPrint('Error closing socket: $e');
    }
  }

  /// Send text message to another device
  Future<bool> sendTextMessage(
    String recipientIp,
    int recipientPort,
    String message, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    if (message.length > 2048) {
      throw Exception('Message exceeds 2048 character limit');
    }

    WebSocketChannel? channel;
    final completer = Completer<bool>();
    StreamSubscription? subscription;

    try {
      final uri = Uri.parse('ws://$recipientIp:$recipientPort/ws');
      debugPrint('Connecting to $uri');

      channel = WebSocketChannel.connect(uri);

      // Send message
      final msg = WebSocketMessage(
        type: MessageType.textMessage,
        sender: _deviceName ?? 'Unknown',
        content: message,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      channel.sink.add(jsonEncode(msg.toJson()));
      debugPrint('Message sent, waiting for acknowledgment...');

      // Listen for acknowledgment
      subscription = channel.stream
          .timeout(timeout)
          .listen(
            (data) {
              try {
                final json = jsonDecode(data as String);
                final response = WebSocketMessage.fromJson(json);

                if (response.type == MessageType.acknowledgment) {
                  debugPrint('Acknowledgment received');
                  if (!completer.isCompleted) {
                    completer.complete(true);
                  }
                }
              } catch (e) {
                debugPrint('Error parsing acknowledgment: $e');
              }
            },
            onError: (error) {
              debugPrint('WebSocket send error: $error');
              if (!completer.isCompleted) {
                completer.completeError(error);
              }
            },
            onDone: () {
              if (!completer.isCompleted) {
                completer.complete(false);
              }
            },
          );

      final result = await completer.future;
      return result;
    } catch (e) {
      debugPrint('Failed to send message: $e');
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
      return false;
    } finally {
      await subscription?.cancel();
      await channel?.sink.close();
    }
  }

  /// Stop WebSocket server
  Future<void> stopServer() async {
    if (_server == null) return;

    // Close all active connections
    for (final socket in _activeConnections) {
      try {
        await socket.close();
      } catch (e) {
        debugPrint('Error closing connection: $e');
      }
    }
    _activeConnections.clear();

    // Close server
    await _server?.close();
    _server = null;
    debugPrint('WebSocket server stopped');
  }
}
