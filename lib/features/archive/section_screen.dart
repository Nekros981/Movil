import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'wiki_sections.dart';

class SectionScreen extends StatefulWidget {
  const SectionScreen({required this.section, super.key});

  final WikiSection section;

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  int _selectedIndex = 0;

  List<WikiEntry> get _entries =>
      wikiEntriesBySection[widget.section.id] ?? const [];

  bool get _isInteractive => _entries.isNotEmpty;

  bool get _showThumbnails => widget.section.id == 'storyboard';

  WikiEntry? get _selectedEntry =>
      _entries.isEmpty ? null : _entries[_selectedIndex];

  String get _bodyIntro {
    if (_isInteractive && _selectedEntry != null) {
      return _selectedEntry!.intro ?? widget.section.intro;
    }
    return widget.section.intro;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: Text(widget.section.title, style: AppTypography.cardTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          0,
          AppSpacing.screen,
          AppSpacing.xl,
        ),
        children: [
          Text(widget.section.overline, style: AppTypography.overline),
          const SizedBox(height: AppSpacing.xs),
          Text(widget.section.title, style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          Text(_bodyIntro, style: AppTypography.body),
          const SizedBox(height: AppSpacing.xl),
          if (_isInteractive) ...[
            _HeroImage(assetPath: _selectedEntry!.imageAsset),
            const SizedBox(height: AppSpacing.lg),
            for (var i = 0; i < _entries.length; i++) ...[
              _EntryCard(
                index: i,
                entry: _entries[i],
                section: widget.section,
                selected: i == _selectedIndex,
                showThumbnail: _showThumbnails,
                onTap: () => setState(() => _selectedIndex = i),
              ),
              if (i < _entries.length - 1) const SizedBox(height: AppSpacing.sm),
            ],
          ] else
            _PlaceholderPanel(),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const _PlaceholderPanel(compact: true),
        ),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.index,
    required this.entry,
    required this.section,
    required this.selected,
    required this.showThumbnail,
    required this.onTap,
  });

  final int index;
  final WikiEntry entry;
  final WikiSection section;
  final bool selected;
  final bool showThumbnail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final indexLabel = (index + 1).toString().padLeft(2, '0');

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.card),
        side: BorderSide(
          color: selected
              ? section.color
              : AppColors.textPrimary.withValues(alpha: 0.08),
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showThumbnail) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    entry.imageAsset,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 72,
                      height: 72,
                      color: AppColors.placeholder,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_outlined,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              Text(
                indexLabel,
                style: GoogleFonts.manrope(
                  fontSize: showThumbnail ? 24 : 36,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  color: selected
                      ? section.color
                      : AppColors.textPrimary.withValues(alpha: 0.06),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    entry.title,
                    style: AppTypography.cardTitle.copyWith(
                      color: selected ? section.color : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderPanel extends StatelessWidget {
  const _PlaceholderPanel({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.placeholder,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(
          color: AppColors.textSecondary,
          style: BorderStyle.solid,
        ),
      ),
      child: Text(
        'Contenido en preparación',
        textAlign: TextAlign.center,
        style: AppTypography.label.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
