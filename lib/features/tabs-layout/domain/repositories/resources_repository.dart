import '../entities/slot_class.dart';

abstract class ResourcesRepository {
  Future<SlotData> getData();
}
