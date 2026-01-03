import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

/// Information about a file being transferred
class FileTransferInfo {
  final String fileName;
  final int fileSize;
  final String? path; // Source path for sender

  FileTransferInfo({
    required this.fileName,
    required this.fileSize,
    this.path,
  });

  Map<String, dynamic> toJson() => {
    'fileName': fileName,
    'fileSize': fileSize,
  };

  factory FileTransferInfo.fromJson(Map<String, dynamic> json) {
    return FileTransferInfo(
      fileName: json['fileName'],
      fileSize: json['fileSize'],
    );
  }
}

/// Service to handle sending and receiving files via HTTP
class FileTransferService {
  HttpServer? _server;
  int _port = 0; // Ephemeral port
  final Map<String, File> _filesToServe = {};

  int get port => _port;

  /// Start an ephemeral HTTP server to serve specific files
  Future<int> startServer(List<File> files) async {
    await stopServer();
    _filesToServe.clear();

    for (var file in files) {
      _filesToServe[p.basename(file.path)] = file;
    }

    _server = await HttpServer.bind(InternetAddress.anyIPv4, 0);
    _port = _server!.port;

    _server!.listen((HttpRequest request) async {
      final fileName = Uri.decodeComponent(p.basename(request.uri.path));
      final file = _filesToServe[fileName];

      if (file != null && await file.exists()) {
        request.response.headers.contentType = ContentType.binary;
        request.response.headers.add(
          'Content-Disposition',
          'attachment; filename="${Uri.encodeComponent(fileName)}"',
        );
        request.response.contentLength = await file.length();
        
        try {
          await request.response.addStream(file.openRead());
        } catch (e) {
          debugPrint('Error streaming file: $e');
        } finally {
          await request.response.close();
        }
      } else {
        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
      }
    });

    return _port;
  }

  Future<void> stopServer() async {
    await _server?.close(force: true);
    _server = null;
    _port = 0;
  }
}
