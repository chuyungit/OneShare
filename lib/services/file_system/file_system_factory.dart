import 'package:oneshare/models/network_mount.dart';
import 'package:oneshare/services/file_system/file_system_interface.dart';
import 'package:oneshare/services/file_system/local_file_system.dart';
import 'package:oneshare/services/file_system/open_list_file_system.dart';
import 'package:oneshare/services/file_system/sftp_file_system.dart';
import 'package:oneshare/services/file_system/smb_file_system.dart';
import 'package:oneshare/services/file_system/webdav_file_system.dart';

class FileSystemFactory {
  static FileSystem create(NetworkMount mount) {
    switch (mount.type) {
      case MountType.openList:
        return OpenListFileSystem(mount);
      case MountType.smb:
        return SmbFileSystem(mount);
      case MountType.sftp:
        return SftpFileSystem(mount);
      case MountType.webDav:
        return WebDavFileSystem(mount);
    }
  }

  static FileSystem createLocal() {
    return LocalFileSystem();
  }
}
