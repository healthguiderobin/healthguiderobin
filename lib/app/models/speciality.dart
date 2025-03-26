class SpecialityModel {
  final String id;
  final String logo;
  final String name;

  SpecialityModel({
    required this.id,
    required this.logo,
    required this.name,
  });

  factory SpecialityModel.fromJson(Map<String, dynamic> json) {
    return SpecialityModel(
      id: json['id'] ?? '',
      logo: json['logo'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'name': name,
    };
  }
}
