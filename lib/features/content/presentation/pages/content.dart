import 'package:flutter/material.dart';
import 'package:mint_test/core/constants/theme/app_theme.dart';

import '../../../../config/di/locator.dart';
import '../../../../core/constants/localization/localization_class.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../domain/entities/resource_class.dart';
import '../widgets/items.dart';
import '../widgets/search_bar.dart';

class Content extends StatelessWidget {
  final List<Resource> resources;
  final String eventName;
  Content({Key? key, required this.resources, required this.eventName})
    : super(key: key);

  final localizationClass = locator<LocalizationsClass>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          resources.isEmpty
              ? [const EmptyStateWidget()]
              : [
                Padding(
                  padding: EdgeInsets.all(AppTheme.pagePadding),
                  child: CustomSearchBar(onCleared: () {}),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.pagePadding,
                  ),
                  child: Row(
                    children: [
                      Text(
                        localizationClass.general()['event'],
                        style: AppTheme.eventLabelStyle,
                      ),
                      Text(eventName, style: AppTheme.eventNameStyle),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: resources.length,
                    itemBuilder: (context, index) {
                      final resource = resources[index];
                      return (Items(resource: resource));
                    },
                  ),
                ),
              ],
    );
  }
}
