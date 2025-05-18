import 'package:flutter/material.dart';
import '../../../../config/di/locator.dart';
import '../../../../config/router/app_router.dart';
import '../../../../core/constants/localization/localization_class.dart';
import '../../../content/presentation/pages/content.dart';
import '../../domain/entities/slot_category.dart';

class TabsLayout extends StatefulWidget {
  final SlotCategory initialCategory;

  const TabsLayout({super.key, this.initialCategory = SlotCategory.instructor});

  @override
  State<TabsLayout> createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout> with TickerProviderStateMixin {
  late TabController _tabController;
  late SlotCategory _currentCategory;
  final localizationClass = locator<LocalizationsClass>();

  @override
  void initState() {
    super.initState();
    _currentCategory = widget.initialCategory;
    _tabController = TabController(
      length: SlotCategory.values.length,
      vsync: this,
      initialIndex: _currentCategory.index,
    );
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging ||
        _tabController.index != _currentCategory.index) {
      setState(() {
        _currentCategory = SlotCategory.values[_tabController.index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('----'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => null,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: localizationClass.tabs()['instructor']),
            Tab(text: localizationClass.tabs()['trainee']),
            Tab(text: localizationClass.tabs()['observer']),
            Tab(text: localizationClass.tabs()['administration']),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: SlotCategory.values.map((category) => Content()).toList(),
      ),
    );
  }
}
