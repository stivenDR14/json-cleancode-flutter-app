import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../core/constants/localization/labels.dart';
import '../../core/constants/localization/localization_class.dart';
import '../../core/resources/json_reader.dart';

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

  locator.registerSingleton<LocalizationsClass>(localizationsClass);

  locator.registerSingleton<Dio>(dio);
}
