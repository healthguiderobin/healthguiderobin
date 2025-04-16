class FAQModel {
  final String id;
  final String title;
  final String description;

  FAQModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) => FAQModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
