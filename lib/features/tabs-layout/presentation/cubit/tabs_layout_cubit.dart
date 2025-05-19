import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mint_test/features/tabs-layout/domain/repositories/resources_repository.dart';

import '../../domain/entities/slot_category.dart';
import '../../domain/entities/slot_class.dart';
import 'tabs_layout_state.dart';

class TabsLayoutCubit extends Cubit<TabsLayoutState> {
  final ResourcesRepository _resourcesRepository;
  final List<SlotCategory> stackTabsHistory = [];

  TabsLayoutCubit(this._resourcesRepository) : super(TabsLayoutLoading());

  void getSlots(Function(SlotData) callback) async {
    emit(TabsLayoutLoading());
    try {
      final slot = await _resourcesRepository.getData();
      callback(slot);
      final firstGroupName = slot.slotGroups.first.slotGroupName;
      stackTabsHistory.add(_getEnumProperty(firstGroupName));
      emit(TabsLayoutLoaded(slots: slot));
    } catch (e) {
      emit(TabsLayoutError(message: e.toString()));
    }
  }

  void handleTabChange(String tabName) {
    if (tabName != stackTabsHistory.last.name) {
      stackTabsHistory.add(_getEnumProperty(tabName));
    }
  }

  SlotCategory _getEnumProperty(String propertyName) {
    return SlotCategory.values.firstWhere(
      (element) => element.name == propertyName,
    );
  }

  void handleBack(TabController tabController) {
    if (stackTabsHistory.length > 1) {
      stackTabsHistory.removeLast();
    }
    tabController.animateTo(
      SlotCategory.values
          .firstWhere((element) => element == stackTabsHistory.last)
          .index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
