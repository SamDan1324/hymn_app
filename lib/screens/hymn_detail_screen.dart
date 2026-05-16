import 'package:flutter/material.dart';
import '../models/hymn.dart';
import '../widgets/audio_play_button.dart';

class HymnDetailScreen extends StatelessWidget {
  final Hymn hymn;

  const HymnDetailScreen({required this.hymn});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hymn ${hymn.number}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AudioPlayButton(
              hymnNumber: hymn.number,
              audioUrl: hymn.audioUrl,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              hymn.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Hymn ${hymn.number}',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
            const Divider(height: 32, thickness: 1),
            ...hymn.lyrics.map((segment) {
              final isChorus = segment.type.toLowerCase() == 'chorus';
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (segment.label.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          segment.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isChorus
                                ? theme.colorScheme.primary
                                : theme.hintColor,
                          ),
                        ),
                      ),
                    Text(
                      segment.content,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        fontStyle:
                            isChorus ? FontStyle.italic : FontStyle.normal,
                        fontWeight:
                            isChorus ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
            if (hymn.lyrics.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: Text(
                    'Lyrics not available',
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
