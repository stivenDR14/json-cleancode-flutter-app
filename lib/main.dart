import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/di/locator.dart';
import 'config/provider/provider_setup.dart';
import 'config/router/app_router.dart';
import 'core/constants/localization/localization_class.dart';
import 'core/constants/theme/app_theme.dart';
import 'core/resources/json_reader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JsonReader.initialize();
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final localizationClass = locator<LocalizationsClass>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: ProviderSetup.getProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: localizationClass.general()['appTitle'],
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
