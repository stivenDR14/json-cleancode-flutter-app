import '../../../content/domain/entities/resource_class.dart';
import 'slot_category.dart';

class SlotData {
  final String categoryName;
  final String eventName;
  final List<SlotGroup> slotGroups;

  SlotData({
    required this.categoryName,
    required this.eventName,
    required this.slotGroups,
  });

  factory SlotData.fromJson(Map<String, dynamic> json) {
    return SlotData(
      categoryName: json['categoryName'] ?? '',
      eventName: json['eventName'] ?? '',
      slotGroups:
          (json['slotGroups'] as List? ?? [])
              .map((group) => SlotGroup.fromJson(group))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'eventName': eventName,
      'slotGroups': slotGroups.map((group) => group.toJson()).toList(),
    };
  }
}

class SlotGroup {
  final String slotGroupName;
  final List<Resource> resources;

  SlotGroup({required this.slotGroupName, required this.resources});

  factory SlotGroup.fromJson(Map<String, dynamic> json) {
    return SlotGroup(
      slotGroupName: json['slotGroupName'].toString().toLowerCase() ?? '',
      resources:
          (json['resources'] as List).isNotEmpty
              ? (json['resources'] as List)
                  .map((resource) => Resource.fromJson(resource))
                  .toList()
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotGroupName': slotGroupName,
      'resources': resources.map((resource) => resource.toJson()).toList(),
    };
  }
}
