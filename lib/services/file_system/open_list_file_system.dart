import 'dart:convert';
import 'dart:io';
import 'package:oneshare/models/network_mount.dart';
import 'file_system_interface.dart';
import 'package:path/path.dart' as p;

class OpenListFileSystem implements FileSystem {
  final NetworkMount mount;

  OpenListFileSystem(this.mount);

  Future<dynamic> _post(String endpoint, Map<String, dynamic> body) async {
    final client = HttpClient();
    final url = Uri.parse('${mount.host}:${mount.port}$endpoint');

    try {
      final request = await client.postUrl(url);
      request.headers.set('Content-Type', 'application/json');
      // Add auth token if we implemented login
      // request.headers.set('Authorization', mount.password);

      request.write(jsonEncode(body));
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        return jsonDecode(responseBody);
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<List<FileItem>> list(String path) async {
    try {
      final effectivePath = path.isEmpty ? mount.path : path;
      final body = {
        "path": effectivePath,
        "password": "", // Directory password if needed
        "page": 1,
        "per_page": 0,
        "refresh": false,
      };

      final json = await _post('/api/fs/list', body);

      if (json['code'] == 200) {
        final content = json['data']['content'] as List;
        return content.map((item) {
          return FileItem(
            path: p.join(effectivePath, item['name']),
            name: item['name'],
            isDirectory: item['is_dir'],
            size: item['size'],
            modified: DateTime.fromMillisecondsSinceEpoch(
              item['modified'] * 1000,
            ),
          );
        }).toList();
      } else {
        throw Exception('OpenList API Error: ${json['message']}');
      }
    } catch (e) {
      throw Exception('Failed to list files: $e');
    }
  }

  @override
  Future<void> createDirectory(String path) async {
    await _post('/api/fs/mkdir', {"path": path});
  }

  @override
  Future<void> delete(String path) async {
    // Usually /api/fs/remove with list of dir/names
    final dir = p.dirname(path);
    final name = p.basename(path);
    await _post('/api/fs/remove', {
      "dir": dir,
      "names": [name],
    });
  }

  @override
  Future<void> copy(String source, String destination) async {
    // Implement if API supports it
  }

  @override
  Future<void> move(String source, String destination) async {
    final dir = p.dirname(source);
    final name = p.basename(source);
    // OpenList move usually implies renaming or moving
    // API: /api/fs/move or /api/fs/rename
    // Let's assume standard Alist /api/fs/move
    await _post('/api/fs/move', {
      "src_dir": dir,
      "src_names": [name],
      "dst_dir": destination,
    });
  }

  @override
  Future<void> upload(File localFile, String remotePath) async {
    // Alist upload is complex, usually involves PUT to a specific URL or form upload.
    // Simplified: PUT /api/fs/put
    final url = Uri.parse('${mount.host}:${mount.port}/api/fs/put');
    final client = HttpClient();
    try {
      final request = await client.putUrl(url);
      request.headers.set(
        'File-Path',
        remotePath,
      ); // Alist specific header often used, or needing pre-signed URL
      // For Alist v3: PUT /api/fs/put
      // headers: File-Path: <path>
      // headers: Password: <password> if needed
      // headers: Authorization: <token>

      request.headers.set('File-Path', Uri.encodeFull(remotePath));
      // Token handling should be here if we had full login flow

      final fileStream = localFile.openRead();
      await request.addStream(fileStream);
      final response = await request.close();

      if (response.statusCode != 200) {
        throw Exception('Upload failed: ${response.statusCode}');
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<void> download(String remotePath, String localPath) async {
    // POST /api/fs/get to get download URL, then GET
    final body = {"path": remotePath, "password": ""};
    final json = await _post('/api/fs/get', body);
    if (json['code'] == 200) {
      final downloadUrl = json['data']['raw_url'];
      // Now download content
      // Handle relative URL if needed
      final targetUrl = downloadUrl.toString().startsWith('http')
          ? Uri.parse(downloadUrl)
          : Uri.parse('${mount.host}:${mount.port}$downloadUrl');

      final client = HttpClient();
      try {
        final request = await client.getUrl(targetUrl);
        final response = await request.close();
        final file = File(localPath);
        await response.pipe(file.openWrite());
      } finally {
        client.close();
      }
    } else {
      throw Exception('Failed to get download URL: ${json['message']}');
    }
  }
}
