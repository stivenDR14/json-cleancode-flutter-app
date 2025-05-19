import 'package:flutter/material.dart';
import 'package:mint_test/core/constants/theme/app_theme.dart';

import '../../config/di/locator.dart';
import '../constants/localization/localization_class.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationClass = locator<LocalizationsClass>();

    return Center(
      child: Column(
        children: [
          SizedBox(height: AppTheme.itemSpacing),
          Text(
            localizationClass.messages()['empty_state'],
            style: AppTheme.eventNameStyle,
          ),
        ],
      ),
    );
  }
}
