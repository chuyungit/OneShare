import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:oneshare/models/share_model.dart';
import 'package:oneshare/services/discovery_service.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ShareModel>().startScanning();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ShareModel>().startScanning();
            },
          ),
        ],
      ),
      body: Consumer<ShareModel>(
        builder: (context, model, child) {
          if (model.peers.isNotEmpty) {
            return _buildDeviceList(model);
          } else {
            return _buildSearchingState(model);
          }
        },
      ),
    );
  }

  Widget _buildSearchingState(ShareModel model) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SearchingText(),
          const SizedBox(height: 16),
          if (model.me != null)
            Text(
              "Your device: ${model.me!.name}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeviceList(ShareModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: model.peers.map((peer) {
            return _DeviceCard(
              peer: peer,
              onTap: () => _showSendOptions(context, peer, model),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showSendOptions(
    BuildContext context,
    DiscoveredDevice peer,
    ShareModel model,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (c) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.message_outlined),
            title: const Text('Send Text'),
            onTap: () {
              Navigator.pop(c);
              _sendText(context, peer, model);
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_present_outlined),
            title: const Text('Send File'),
            onTap: () {
              Navigator.pop(c);
              _sendFiles(context, peer, model);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _sendFiles(
    BuildContext context,
    DiscoveredDevice peer,
    ShareModel model,
  ) async {
    try {
      final success = await model.sendFiles(peer);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'File offer sent successfully!'
                  : 'Failed to send file offer or cancelled',
            ),
            backgroundColor: success ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _sendText(
    BuildContext context,
    DiscoveredDevice peer,
    ShareModel model,
  ) {
    final controller = TextEditingController();
    bool isSending = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            final characterCount = controller.text.length;
            final isOverLimit = characterCount > 2048;
            final canSend = characterCount > 0 && !isOverLimit && !isSending;

            return AlertDialog(
              title: Text('Message to ${peer.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    maxLines: 5,
                    enabled: !isSending,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Enter text...',
                      border: const OutlineInputBorder(),
                      helperText: '$characterCount / 2048 characters',
                      helperStyle: TextStyle(
                        color: isOverLimit ? Colors.red : null,
                      ),
                    ),
                  ),
                  if (isSending) ...[
                    const SizedBox(height: 16),
                    const LinearProgressIndicator(),
                    const SizedBox(height: 8),
                    const Text('Sending message...'),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isSending
                      ? null
                      : () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: canSend
                      ? () async {
                          setState(() => isSending = true);

                          try {
                            final success = await model.sendText(
                              peer,
                              controller.text,
                            );

                            if (dialogContext.mounted) {
                              Navigator.pop(dialogContext);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    success
                                        ? 'Message sent successfully!'
                                        : 'Failed to send message',
                                  ),
                                  backgroundColor: success
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              );
                            }
                          } catch (e) {
                            if (dialogContext.mounted) {
                              Navigator.pop(dialogContext);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      : null,
                  child: const Text('Send'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _SearchingText extends StatefulWidget {
  @override
  State<_SearchingText> createState() => _SearchingTextState();
}

class _SearchingTextState extends State<_SearchingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotsAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _dotsAnimation = IntTween(begin: 0, end: 3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headlineMedium?.copyWith(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Searching Device", style: style),
        AnimatedBuilder(
          animation: _dotsAnimation,
          builder: (context, child) {
            String dots = "";
            if (_dotsAnimation.value == 1) dots = ".";
            if (_dotsAnimation.value == 2) dots = "..";
            if (_dotsAnimation.value == 3) dots = "...";

            // Use a fixed width container or ensure the text doesn't constrain layout too much
            return SizedBox(width: 40, child: Text(dots, style: style));
          },
        ),
      ],
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final DiscoveredDevice peer;
  final VoidCallback onTap;

  const _DeviceCard({required this.peer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    String iconPath = 'assets/images/page.share/device_type/mobile.svg';
    if (peer.deviceType == 'desktop') {
      iconPath = 'assets/images/page.share/device_type/server.svg';
    }

    return Card(
      elevation: 2, // M3 default or low elevation
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    colorScheme.onSecondaryContainer,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                peer.name,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                "${peer.ip} • ${peer.osType}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
