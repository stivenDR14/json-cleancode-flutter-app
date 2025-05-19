import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/tabs-layout/domain/repositories/resources_repository.dart';
import '../../features/tabs-layout/presentation/cubit/tabs_layout_cubit.dart';
import '../di/locator.dart';

abstract class ProviderSetup {
  static List<SingleChildWidget> getProviders() {
    return [
      BlocProvider(
        create: (context) => TabsLayoutCubit(locator<ResourcesRepository>()),
      ),
    ];
  }
}
