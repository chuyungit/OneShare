import 'dart:io';
import 'package:webdav_client/webdav_client.dart' as webdav;
import 'package:oneshare/models/network_mount.dart';
import 'file_system_interface.dart';

class WebDavFileSystem implements FileSystem {
  final NetworkMount mount;
  late webdav.Client _client;

  WebDavFileSystem(this.mount) {
    _client = webdav.newClient(
      mount.host + (mount.port != 0 ? ':${mount.port}' : ''),
      user: mount.username,
      password: mount.password,
      debug: false,
    );
    // Workaround for some WebDAV servers needing specific path handling
    _client.setHeaders({'depth': '1'});
  }

  @override
  Future<List<FileItem>> list(String path) async {
    final effectivePath = path.isEmpty ? mount.path : path;
    try {
      final list = await _client.readDir(effectivePath);
      return list.map((info) {
        return FileItem(
          path: info.path ?? '', // path usually includes file name
          name: info.name ?? '',
          isDirectory: info.isDir ?? false,
          size: info.size ?? 0,
          modified: info.mTime ?? DateTime.now(),
        );
      }).toList();
    } catch (e) {
      throw Exception('WebDAV Error: $e');
    }
  }

  @override
  Future<void> createDirectory(String path) async {
    await _client.mkdir(path);
  }

  @override
  Future<void> delete(String path) async {
    await _client.removeAll(path);
  }

  @override
  Future<void> copy(String source, String destination) async {
    await _client.copy(source, destination, true); // true = overwrite
  }

  @override
  Future<void> move(String source, String destination) async {
    await _client.rename(source, destination, true); // overwrite
  }

  @override
  Future<void> upload(File localFile, String remotePath) async {
    await _client.writeFromFile(localFile.path, remotePath);
  }

  @override
  Future<void> download(String remotePath, String localPath) async {
    await _client.read2File(remotePath, localPath);
  }
}
