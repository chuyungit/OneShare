import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oneshare/models/download_model.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Downloads'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Consumer<DownloadModel>(
              builder: (context, model, _) {
                return TabBar(
                  tabs: [
                    Tab(
                      child: Badge(
                        label: Text('${model.activeDownloads.length}'),
                        isLabelVisible: model.activeDownloads.isNotEmpty,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.downloading),
                            SizedBox(width: 8),
                            Text("Downloading"),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Badge(
                        label: Text('${model.completedDownloads.length}'),
                        isLabelVisible: model.completedDownloads.isNotEmpty,
                        backgroundColor:
                            Colors.green, // Differentiate completed
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline),
                            SizedBox(width: 8),
                            Text("Completed"),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        body: Consumer<DownloadModel>(
          builder: (context, downloadModel, child) {
            return TabBarView(
              children: [
                _buildDownloadList(
                  context,
                  downloadModel.activeDownloads,
                  downloadModel,
                  isCompleted: false,
                ),
                _buildDownloadList(
                  context,
                  downloadModel.completedDownloads,
                  downloadModel,
                  isCompleted: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDownloadList(
    BuildContext context,
    List<DownloadItem> items,
    DownloadModel model, {
    required bool isCompleted,
  }) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isCompleted ? Icons.check_circle_outline : Icons.download_done,
              size: 64,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              isCompleted ? 'No completed downloads' : 'No active downloads',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(
            0.3,
          ), // Material 3 subtle card
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isCompleted
                  ? Colors.green.withOpacity(0.2)
                  : Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                isCompleted ? Icons.check : Icons.downloading,
                color: isCompleted
                    ? Colors.green
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(
              item.fileName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                if (!isCompleted)
                  LinearProgressIndicator(
                    value: item.progress,
                    borderRadius: BorderRadius.circular(4),
                  ),
                if (isCompleted)
                  Text(
                    'Size: 24 MB • Completed just now', // Placeholder info
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  model.removeDownload(item.id);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
