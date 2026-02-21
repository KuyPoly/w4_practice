import 'package:flutter/material.dart';

import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widget/theme_color_button.dart';

class SettingsScreen extends StatelessWidget {
  final ChangeTheme themeNotifer;
  const SettingsScreen({super.key, required this.themeNotifer});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: themeNotifer.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            "Settings",
            style: AppTextStyles.heading.copyWith(
              color: themeNotifer.theme.color,
            ),
          ),

          SizedBox(height: 50),

          Text(
            "Theme",
            style: AppTextStyles.label.copyWith(color: AppColors.textLight),
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ThemeColor.values
                .map(
                  (theme) => ThemeColorButton(
                    themeColor: theme,
                    isSelected: theme == themeNotifer.theme,
                    onTap: themeNotifer.onThemeChange,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
