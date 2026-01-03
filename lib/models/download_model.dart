import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:oneshare/services/sound_service.dart';

class DownloadItem {
  final String id;
  final String fileName;
  double progress; // 0.0 to 1.0
  bool isCompleted;
  bool isError;
  String? errorReason;

  DownloadItem({
    required this.id,
    required this.fileName,
    this.progress = 0.0,
    this.isCompleted = false,
    this.isError = false,
    this.errorReason,
  });
}

class DownloadModel extends ChangeNotifier {
  final List<DownloadItem> _downloads = [];
  SoundService? soundService;

  List<DownloadItem> get downloads => _downloads;
  List<DownloadItem> get activeDownloads =>
      _downloads.where((i) => !i.isCompleted).toList();
  List<DownloadItem> get completedDownloads =>
      _downloads.where((i) => i.isCompleted).toList();

  void updateSoundService(SoundService service) {
    soundService = service;
  }

  void removeDownload(String id) {
    _downloads.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> startDownload(
    String senderIp,
    int port,
    List<dynamic> files, {
    String? savePath,
  }) async {
    String targetDir;
    if (savePath != null) {
      targetDir = savePath;
    } else {
      targetDir = await _getDefaultDownloadPath();
    }

    final client = HttpClient();
    bool anyError = false;

    for (var fileInfo in files) {
      final String fileName = fileInfo['fileName'];
      final int fileSize = fileInfo['fileSize'] ?? 0;

      final item = DownloadItem(
        id: DateTime.now().millisecondsSinceEpoch.toString() + fileName,
        fileName: fileName,
      );
      _downloads.insert(0, item);
      notifyListeners();

      try {
        final url = Uri.parse('http://$senderIp:$port/${Uri.encodeComponent(fileName)}');
        debugPrint("Downloading from $url");
        
        final request = await client.getUrl(url);
        final response = await request.close();

        if (response.statusCode != HttpStatus.ok) {
          throw Exception("HTTP ${response.statusCode}");
        }

        final saveFile = File(p.join(targetDir, fileName));
        final sink = saveFile.openWrite();

        int received = 0;
        await response.listen(
          (data) {
            received += data.length;
            sink.add(data);
            if (fileSize > 0) {
              item.progress = received / fileSize;
              notifyListeners();
            }
          },
          onDone: () async {
            await sink.close();
            item.progress = 1.0;
            item.isCompleted = true;
            notifyListeners();
          },
          onError: (e) {
             throw e;
          },
          cancelOnError: true,
        ).asFuture();
        
      } catch (e) {
        debugPrint("Download error: $e");
        item.isError = true;
        item.errorReason = e.toString();
        item.isCompleted = true; // Move to completed tab (but with error state)
        anyError = true;
        notifyListeners();
      }
    }
    
    client.close();

    if (anyError) {
      soundService?.playDownloadFailed();
    } else {
      soundService?.playDownloadComplete();
    }
  }

  Future<String> _getDefaultDownloadPath() async {
    if (Platform.isAndroid) {
      // Try to get external storage download directory
       // path_provider getExternalStorageDirectory usually returns /storage/emulated/0/Android/data/...
       // We prefer public Download folder.
       try {
         // This is a hacky way for Android 10- scoped storage, or use manage external storage.
         // For now, let's use the standard app doc dir if others fail, or try /storage/emulated/0/Download
         final dir = Directory('/storage/emulated/0/Download');
         if (await dir.exists()) {
           return dir.path;
         }
       } catch (e) {
         // ignore
       }
    }
    
    final dir = await getDownloadsDirectory();
    if (dir != null) return dir.path;
    
    final docDir = await getApplicationDocumentsDirectory();
    return docDir.path;
  }
}
