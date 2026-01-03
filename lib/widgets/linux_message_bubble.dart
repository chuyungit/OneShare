import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:oneshare/services/notification_service.dart';
import 'package:oneshare/models/download_model.dart';
import 'package:oneshare/l10n/app_localizations.dart';

/// Linux specific in-app bubble notification widget
class LinuxMessageBubble extends StatefulWidget {
  final MessageNotification notification;
  final VoidCallback onDismiss;

  const LinuxMessageBubble({
    super.key,
    required this.notification,
    required this.onDismiss,
  });

  @override
  State<LinuxMessageBubble> createState() => _LinuxMessageBubbleState();
}

class _LinuxMessageBubbleState extends State<LinuxMessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Slide from bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    // Auto-dismiss after 30 seconds
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  void _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.notification.message));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.bubbleCopied),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    _dismiss();
  }

  void _shareMessage() {
    Share.share(widget.notification.message);
    _dismiss();
  }

  void _acceptFile({String? savePath}) {
    final notif = widget.notification;
    if (notif.files != null && notif.port != null) {
      context.read<DownloadModel>().startDownload(
            notif.senderIp,
            notif.port!,
            notif.files!,
            savePath: savePath,
          );
      _dismiss();
    }
  }

  void _acceptFileAndSaveAs() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      _acceptFile(savePath: selectedDirectory);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isFileOffer = widget.notification.type == NotificationType.fileOffer;
    final l10n = AppLocalizations.of(context)!;

    // Hardcoded styling for Linux bubble to ensure visibility
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(16),
              color: colorScheme.surface,
              // Add border for better contrast on Linux desktops
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: colorScheme.outlineVariant, width: 1),
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Icon(
                          isFileOffer ? Icons.file_download_outlined : Icons.message_outlined,
                          color: colorScheme.primary,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            isFileOffer
                                ? l10n.bubbleReceiveFile(widget.notification.senderName)
                                : l10n.bubbleReceiveText(widget.notification.senderName),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _dismiss,
                          tooltip: 'Close',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Content
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                      ),
                      child: isFileOffer 
                          ? _buildFileList(theme, l10n)
                          : SelectableText( // Use SelectableText for Linux
                              widget.notification.message,
                              style: theme.textTheme.bodyLarge,
                              maxLines: 8,
                            ),
                    ),
                    const SizedBox(height: 20),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: isFileOffer 
                          ? [
                              TextButton(
                                onPressed: _dismiss,
                                child: Text(l10n.bubbleReject),
                              ),
                              const SizedBox(width: 12),
                              FilledButton.tonal(
                                onPressed: _acceptFileAndSaveAs,
                                child: Text(l10n.bubbleAcceptSaveAs),
                              ),
                              const SizedBox(width: 12),
                              FilledButton(
                                onPressed: () => _acceptFile(),
                                child: Text(l10n.notifyActionAccept),
                              ),
                            ]
                          : [
                              TextButton(
                                onPressed: _dismiss,
                                child: Text(l10n.bubbleReject),
                              ),
                              const SizedBox(width: 12),
                              FilledButton.tonal(
                                onPressed: _copyToClipboard,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.copy, size: 18),
                                    const SizedBox(width: 8),
                                    Text(l10n.notifyActionCopy),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              FilledButton(
                                onPressed: _shareMessage,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.share, size: 18),
                                    const SizedBox(width: 8),
                                    Text(l10n.notifyActionShare),
                                  ],
                                ),
                              ),
                            ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileList(ThemeData theme, AppLocalizations l10n) {
    final files = widget.notification.files ?? [];
    if (files.isEmpty) return Text(l10n.bubbleNoFiles);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...files.take(3).map((f) {
          final name = f['fileName'] ?? 'Unknown file';
          final size = f['fileSize'];
          final sizeStr = size != null ? "(${_formatBytes(size)})" : "";
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.insert_drive_file_outlined, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "$name $sizeStr",
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }),
        if (files.length > 3)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              l10n.bubbleMoreFiles(files.length - 3),
              style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
      ],
    );
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return "${size.toStringAsFixed(1)} ${suffixes[i]}";
  }
}

/// Linux Overlay manager
class LinuxMessageBubbleOverlay {
  static OverlayEntry? _currentOverlay;

  static void show(BuildContext context, MessageNotification notification) {
    debugPrint('LinuxMessageBubbleOverlay: Showing bubble');
    // Remove existing overlay if any
    hide();

    _currentOverlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 30, 
          right: 30,
          width: 450, 
          child: LinuxMessageBubble(notification: notification, onDismiss: hide),
        );
      },
    );

    try {
      Overlay.of(context).insert(_currentOverlay!);
      debugPrint('LinuxMessageBubbleOverlay: Overlay inserted');
    } catch (e) {
      debugPrint('LinuxMessageBubbleOverlay: Error inserting overlay: $e');
    }
  }

  static void hide() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
