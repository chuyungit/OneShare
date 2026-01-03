import 'dart:io';

class FileItem {
  final String path;
  final String name;
  final bool isDirectory;
  final int size;
  final DateTime modified;

  FileItem({
    required this.path,
    required this.name,
    required this.isDirectory,
    required this.size,
    required this.modified,
  });
}

abstract class FileSystem {
  Future<List<FileItem>> list(String path);
  Future<void> createDirectory(String path);
  Future<void> delete(String path);
  Future<void> copy(String source, String destination);
  Future<void> move(String source, String destination);
  Future<void> upload(File localFile, String remotePath);
  Future<void> download(String remotePath, String localPath);
}
