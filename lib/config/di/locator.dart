import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../core/constants/localization/labels.dart';
import '../../core/constants/localization/localization_class.dart';
import '../../core/resources/json_reader.dart';
import '../../features/tabs-layout/data/repositories/resources_repository_impl.dart';
import '../../features/tabs-layout/domain/repositories/resources_repository.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: JsonReader.getNameConfig('base_url'),
      responseType: ResponseType.json,
      contentType: 'application/json',
    ),
  );

  Map<String, dynamic> objectLabels = translations;
  LocalizationsClass localizationsClass = LocalizationsClass(objectLabels);
  ResourcesRepository resourcesRepository = ResourcesRepositoryImpl(dio: dio);

  locator.registerSingleton<LocalizationsClass>(localizationsClass);
  locator.registerSingleton<ResourcesRepository>(resourcesRepository);
  locator.registerSingleton<Dio>(dio);
}
