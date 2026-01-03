import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

enum TransferType { text, file }

class TransferService {
  ServerSocket? _serverSocket;
  final StreamController<dynamic> _dataController =
      StreamController.broadcast();
  int? _boundPort;

  Stream<dynamic> get dataStream => _dataController.stream;
  int get port => _boundPort ?? 0;

  Future<void> startServer() async {
    try {
      // Bind to an ephemeral port first, or a fixed one if needed.
      // Letting OS choose is better for avoiding conflicts, but discovery needs to know it.
      // We'll try to find a free port or bind multiple times?
      // Simplified: bind to any available port.
      _serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, 0);
      _boundPort = _serverSocket!.port;
      _serverSocket!.listen(_handleConnection);
      debugPrint("Transfer Server listening on port $_boundPort");
    } catch (e) {
      debugPrint("Error starting transfer server: $e");
    }
  }

  void stopServer() {
    _serverSocket?.close();
    _serverSocket = null;
  }

  void _handleConnection(Socket socket) {
    debugPrint(
      "Connection from ${socket.remoteAddress.address}:${socket.remotePort}",
    );
    socket.listen(
      (data) {
        // Simple protocol: Type(1 byte) + Length(4 bytes) + Payload
        // For MVP, assuming small text messages or simple handling.
        // Real implementation needs a proper state machine for buffering.
        // Here we just handle text for simplicity demo, full file transfer needs more code.
        try {
          final message = utf8.decode(data);
          _dataController.add(message);
        } catch (e) {
          // Binary data likely
          debugPrint("Received binary data or error decoding: $e");
        }
      },
      onError: (e) => debugPrint("Socket error: $e"),
      onDone: () => debugPrint("Client disconnected"),
    );
  }

  Future<void> sendText(String ip, int port, String text) async {
    try {
      final socket = await Socket.connect(ip, port);
      socket.write(text);
      await socket.flush();
      socket.close();
    } catch (e) {
      debugPrint("Error sending text: $e");
    }
  }
}
