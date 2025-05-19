import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/locator.dart';
import '../../../../core/constants/localization/localization_class.dart';
import '../../../../core/constants/theme/app_colors.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../content/presentation/pages/content.dart';
import '../../domain/entities/slot_category.dart';
import '../cubit/tabs_layout_cubit.dart';
import '../cubit/tabs_layout_state.dart';

class TabsLayout extends StatefulWidget {
  const TabsLayout({super.key});

  @override
  State<TabsLayout> createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout> with TickerProviderStateMixin {
  late TabController _tabController;
  final localizationClass = locator<LocalizationsClass>();
  late TabsLayoutCubit _tabsLayoutCubit;

  @override
  void initState() {
    super.initState();
    _tabsLayoutCubit = BlocProvider.of<TabsLayoutCubit>(context);

    _tabsLayoutCubit.getSlots((slotData) {
      _tabController = TabController(
        length: SlotCategory.values.length,
        animationDuration: const Duration(milliseconds: 600),
        vsync: this,
        initialIndex: SlotCategory.values.indexOf(
          SlotCategory.values.firstWhere(
            (e) => e.name == slotData.slotGroups.first.slotGroupName,
          ),
        ),
      );

      _tabController.addListener(_handleTabChange);
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      _tabsLayoutCubit.handleTabChange(
        SlotCategory.values[_tabController.index].name,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabsLayoutCubit, TabsLayoutState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case TabsLayoutLoading:
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        if (state is TabsLayoutLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.slots.categoryName),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => _tabsLayoutCubit.handleBack(_tabController),
              ),
              bottom: TabBar(
                isScrollable: true,
                controller: _tabController,
                dividerColor: AppColors.divider,
                indicatorColor: AppColors.tabIndicator,
                labelColor: AppColors.tabSelected,
                unselectedLabelColor: AppColors.tabUnselected,
                tabAlignment: TabAlignment.start,
                tabs:
                    SlotCategory.values
                        .map(
                          (group) =>
                              Tab(text: localizationClass.tabs()[group.name]),
                        )
                        .toList(),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  SlotCategory.values
                      .map(
                        (group) => Content(
                          eventName: state.slots.eventName,
                          resources:
                              state.slots.slotGroups
                                      .where(
                                        (slotGroup) =>
                                            slotGroup.slotGroupName ==
                                            group.name,
                                      )
                                      .isNotEmpty
                                  ? state.slots.slotGroups
                                      .where(
                                        (slotGroup) =>
                                            slotGroup.slotGroupName ==
                                            group.name,
                                      )
                                      .first
                                      .resources
                                  : [],
                        ),
                      )
                      .toList(),
            ),
          );
        }
        if (state is TabsLayoutError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        return const Scaffold(body: LoadingWidget());
      },
    );
  }
}
