import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../auth/auth_repository.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    required this.email,
    required this.authRepository,
    super.key,
  });

  final String email;
  final AuthRepository authRepository;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _name;
  String? _avatarUrl;
  bool _uploading = false;
  String? _avatarError;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    setState(() {
      _name = widget.authRepository.currentName();
      _avatarUrl = widget.authRepository.currentAvatarUrl();
    });
  }

  Future<void> _logout(BuildContext context) async {
    await widget.authRepository.logout();
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => LoginScreen(authRepository: widget.authRepository),
      ),
      (_) => false,
    );
  }

  String _initial() {
    final fromName = _name?.trim();
    if (fromName != null && fromName.isNotEmpty) {
      return fromName[0].toUpperCase();
    }
    final trimmed = widget.email.trim();
    if (trimmed.isEmpty) {
      return '?';
    }
    return trimmed[0].toUpperCase();
  }

  Future<void> _pickAndUploadAvatar() async {
    if (_uploading) {
      return;
    }

    setState(() => _avatarError = null);

    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image == null || !mounted) {
      return;
    }

    setState(() => _uploading = true);

    final bytes = await image.readAsBytes();
    final error = await widget.authRepository.uploadAvatar(bytes);

    if (!mounted) {
      return;
    }

    setState(() {
      _uploading = false;
      if (error != null) {
        _avatarError = error;
      } else {
        _avatarUrl = widget.authRepository.currentAvatarUrl();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _name ?? 'Sin nombre';

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.screen,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        Text('PERFIL', style: AppTypography.overline),
        const SizedBox(height: AppSpacing.xs),
        Text('Tu cuenta', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _uploading ? null : _pickAndUploadAvatar,
                  customBorder: const CircleBorder(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.sage,
                        backgroundImage: _avatarUrl != null
                            ? NetworkImage(_avatarUrl!)
                            : null,
                        child: _avatarUrl != null
                            ? null
                            : Text(
                                _initial(),
                                style: GoogleFonts.manrope(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white,
                                ),
                              ),
                      ),
                      if (_uploading)
                        const Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(0x66000000),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 28,
                                height: 28,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.surface,
                                width: 2,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.photo_camera_outlined,
                                size: 18,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Toca la foto para cambiarla',
                style: AppTypography.body,
              ),
            ],
          ),
        ),
        if (_avatarError != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Text(
              _avatarError!,
              textAlign: TextAlign.center,
              style: AppTypography.body.copyWith(color: AppColors.error),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: Text(
            displayName,
            textAlign: TextAlign.center,
            style: AppTypography.sectionTitle,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Center(
          child: Text(
            widget.email,
            textAlign: TextAlign.center,
            style: AppTypography.body,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        PrimaryButton(
          label: 'Cerrar sesión',
          onPressed: () => _logout(context),
        ),
      ],
    );
  }
}
