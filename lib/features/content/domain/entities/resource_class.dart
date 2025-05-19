class Resource {
  final String firstName;
  final String name;
  final String userId;
  final String photo;
  final List<String> certificates;

  Resource({
    required this.firstName,
    required this.name,
    required this.userId,
    required this.photo,
    required this.certificates,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      firstName: json['firstName'] ?? '',
      name: json['name'] ?? '',
      userId: json['userId'] ?? '',
      photo: json['photo'] ?? '',
      certificates: (json['certificates'] as List? ?? []).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'name': name,
      'userId': userId,
      'photo': photo,
      'certificates': certificates,
    };
  }
}
