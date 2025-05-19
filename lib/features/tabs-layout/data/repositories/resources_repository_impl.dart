import 'package:dio/dio.dart';

import '../../domain/entities/slot_class.dart';
import '../../domain/repositories/resources_repository.dart';

class ResourcesRepositoryImpl implements ResourcesRepository {
  final Dio _dio;

  ResourcesRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<SlotData> getData() async {
    final response = await _dio.get('/2e6c-4365-4766-bc64');
    final data = response.data;
    return SlotData.fromJson(data);
  }
}
