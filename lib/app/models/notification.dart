class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String image;
  final dynamic createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        body: json["body"] ?? '',
        image: json["image"] ?? '',
        createdAt: json["createdAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "image": image,
        "createdAt": createdAt,
      };
}
