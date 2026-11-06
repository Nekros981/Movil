import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class TracksScreen extends StatefulWidget {
  const TracksScreen({super.key});

  @override
  State<TracksScreen> createState() => _TracksScreenState();
}

class _TrackData {
  const _TrackData({
    required this.id,
    required this.title,
    required this.assetPath,
  });

  final String id;
  final String title;
  final String assetPath;
}

class _TracksScreenState extends State<TracksScreen> {
  static const _tracks = <_TrackData>[
    _TrackData(
      id: 'sunrise',
      title: 'Sunrise Over High Fields',
      assetPath: 'audio/Sunrise_Over_High_Fields.mp3',
    ),
    _TrackData(
      id: 'across',
      title: 'Across the Silent Lands',
      assetPath: 'audio/Across_the_Silent_Lands.mp3',
    ),
  ];

  final AudioPlayer _player = AudioPlayer();
  String? _activeTrackId;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.onPlayerStateChanged.listen((state) {
      if (!mounted) {
        return;
      }
      setState(() => _isPlaying = state == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggleTrack(_TrackData track) async {
    if (_activeTrackId == track.id && _isPlaying) {
      await _player.pause();
      return;
    }

    if (_activeTrackId == track.id && !_isPlaying) {
      await _player.resume();
      return;
    }

    await _player.stop();
    setState(() => _activeTrackId = track.id);
    await _player.play(AssetSource(track.assetPath));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.screen,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        Text('PISTAS', style: AppTypography.overline),
        const SizedBox(height: AppSpacing.xs),
        Text('Música del juego', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Reproduce las pistas oficiales de Campus Quest.',
          style: AppTypography.body,
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final track in _tracks) ...[
          _TrackRow(
            title: track.title,
            isActive: _activeTrackId == track.id && _isPlaying,
            onTap: () => _toggleTrack(track),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _TrackRow extends StatelessWidget {
  const _TrackRow({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: AppTypography.cardTitle),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isActive ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
