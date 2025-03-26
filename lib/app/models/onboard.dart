import 'dart:convert';

List<OnboardModel> onboardModelsFromJson(String str) => List<OnboardModel>.from(
    json.decode(str).map((x) => OnboardModel.fromJson(x)));

class OnboardModel {
  final String image;
  final String title;
  final String subtitle;
  final String description;

  OnboardModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  factory OnboardModel.fromJson(Map<String, dynamic> json) => OnboardModel(
        title: json["title"] ?? '',
        subtitle: json["subtitle"] ?? '',
        image: json["image"] ?? '',
        description: json["description"] ?? '',
      );
}
