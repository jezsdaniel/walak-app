import 'package:flutter/material.dart';

import 'package:walak/core/theme/theme.dart';

class ProfileOption extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color primaryColor;
  final void Function() onTap;

  const ProfileOption({
    Key? key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.primaryColor = WColors.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: WShadows.elevation4,
          color: WColors.surface,
        ),
        child: Icon(
          icon,
          color: primaryColor,
        ),
      ),
      title: Text(
        title,
        style: wText.subtitle1!.copyWith(
          color: primaryColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: wText.caption!.copyWith(
                color: WColors.textMediumEmphasis,
              ),
            )
          : null,
      onTap: () {
        onTap();
      },
    );
  }
}
