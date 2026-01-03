import 'package:flutter/material.dart';
import 'package:oneshare/models/settings_model.dart';
import 'package:oneshare/models/network_mount.dart';
import 'package:oneshare/services/file_system/file_system_interface.dart';
import 'package:oneshare/services/file_system/file_system_factory.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  FileSystem? _currentFs; // Null means "My Computer" / Overview?
  NetworkMount? _currentMount;
  String _currentPath = '/';
  List<FileItem> _files = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Default to first mount or empty state
  }

  Future<void> _loadFiles(String path) async {
    if (_currentFs == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final files = await _currentFs!.list(path);
      setState(() {
        _files = files;
        _currentPath = path;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _selectMount(NetworkMount mount) {
    setState(() {
      _currentMount = mount;
      _currentFs = FileSystemFactory.create(mount);
      _currentPath = '/';
      _files = [];
      _error = null;
    });
    _loadFiles('/');
  }

  void _navigateTo(String path) {
    _loadFiles(path);
  }

  void _navigateUp() {
    if (_currentPath == '/' || _currentPath == '.') return;
    final parent = p.dirname(_currentPath);
    _navigateTo(parent);
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();
    final mounts = settings.networkMounts;

    return Scaffold(
      body: Row(
        children: [
          // SIDEBAR
          Container(
            width: 250,
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            child: Column(
              children: [
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.computer),
                  title: const Text(
                    "My Connections",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: mounts.length,
                    itemBuilder: (context, index) {
                      final mount = mounts[index];
                      final isSelected = _currentMount?.id == mount.id;
                      return ListTile(
                        leading: Icon(
                          mount.icon,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        title: Text(mount.name),
                        selected: isSelected,
                        onTap: () => _selectMount(mount),
                      );
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Configure Mounts"),
                  onTap: () {
                    // Could navigate to settings or show dialog here
                    // For now, assume user knows to go to Settings tab
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Go to Settings > Network Connections to add mounts.",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          // MAIN CONTENT
          Expanded(
            child: _currentFs == null
                ? const Center(
                    child: Text("Select a connection to browse files."),
                  )
                : Column(
                    children: [
                      // TOOLBAR / BREADCRUMBS
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_upward),
                              onPressed: _currentPath == '/'
                                  ? null
                                  : _navigateUp,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _currentPath,
                                style: Theme.of(context).textTheme.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => _loadFiles(_currentPath),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      // FILE LIST
                      Expanded(
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : _error != null
                            ? Center(child: Text("Error: $_error"))
                            : _buildFileList(),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileList() {
    if (_files.isEmpty) {
      return const Center(child: Text("Empty folder"));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _files.length,
      itemBuilder: (context, index) {
        final item = _files[index];
        return InkWell(
          onTap: () {
            if (item.isDirectory) {
              _navigateTo(item.path);
            } else {
              // Handle file open/download
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Selected: ${item.name}")));
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.isDirectory ? Icons.folder : Icons.insert_drive_file,
                size: 48,
                color: item.isDirectory ? Colors.amber : Colors.blueGrey,
              ),
              const SizedBox(height: 8),
              Text(
                item.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
