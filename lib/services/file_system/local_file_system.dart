import 'dart:io';
import 'package:path/path.dart' as p;
import 'file_system_interface.dart';

class LocalFileSystem implements FileSystem {
  @override
  Future<List<FileItem>> list(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      throw FileSystemException('Directory not found', path);
    }

    final entities = await dir.list().toList();
    final items = <FileItem>[];

    for (var entity in entities) {
      final stat = await entity.stat();
      items.add(
        FileItem(
          path: entity.path,
          name: p.basename(entity.path),
          isDirectory: stat.type == FileSystemEntityType.directory,
          size: stat.size,
          modified: stat.modified,
        ),
      );
    }

    // Sort: Directories first, then files
    items.sort((a, b) {
      if (a.isDirectory && !b.isDirectory) return -1;
      if (!a.isDirectory && b.isDirectory) return 1;
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    return items;
  }

  @override
  Future<void> createDirectory(String path) async {
    await Directory(path).create(recursive: true);
  }

  @override
  Future<void> delete(String path) async {
    final type = await FileSystemEntity.type(path);
    if (type == FileSystemEntityType.file) {
      await File(path).delete();
    } else if (type == FileSystemEntityType.directory) {
      await Directory(path).delete(recursive: true);
    }
  }

  @override
  Future<void> copy(String source, String destination) async {
    // Basic copy implementation
    final file = File(source);
    if (await file.exists()) {
      await file.copy(destination);
    }
  }

  @override
  Future<void> move(String source, String destination) async {
    final file = File(source);
    if (await file.exists()) {
      await file.rename(destination);
    }
  }

  @override
  Future<void> upload(File localFile, String remotePath) async {
    // For local FS, upload is just a copy
    await localFile.copy(remotePath);
  }

  @override
  Future<void> download(String remotePath, String localPath) async {
    // For local FS, download is just a copy
    await File(remotePath).copy(localPath);
  }
}
