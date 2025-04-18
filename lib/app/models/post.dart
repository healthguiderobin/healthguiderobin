class PostModel {
  final String id;
  final String title;
  final String body;
  final String videoThumb;
  final String videoLink;
  final List<String> imageList;
  final dynamic createdAt;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.videoThumb,
    required this.videoLink,
    required this.imageList,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      videoThumb: json['videoThumb'] ?? '',
      videoLink: json['videoLink'] ?? '',
      imageList: List<String>.from(json['imageList'] ?? []),
      createdAt: json['createdAt'],
    );
  }
}
