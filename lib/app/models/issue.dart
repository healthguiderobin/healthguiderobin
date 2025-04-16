class IssueModel {
  final String issueId;
  final String title;
  final String body;
  final dynamic createdAt;
  final String response;
  final dynamic respondedAt;
  final String userId;
  final String userName;
  final String userImage;
  final String userPhone;

  IssueModel({
    required this.issueId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.response,
    required this.respondedAt,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.userPhone,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) => IssueModel(
        issueId: json["issueId"] ?? '',
        title: json["title"] ?? '',
        body: json["body"] ?? '',
        createdAt: json["createdAt"] ?? '',
        response: json["response"] ?? '',
        respondedAt: json["respondedAt"] ?? '',
        userId: json["userId"] ?? '',
        userName: json["userName"] ?? '',
        userImage: json["userImage"] ?? '',
        userPhone: json["userPhone"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "issueId": issueId,
        "title": title,
        "body": body,
        "createdAt": createdAt,
        "response": response,
        "respondedAt": respondedAt,
        "userId": userId,
        "userName": userName,
        "userImage": userImage,
        "userPhone": userPhone,
      };
}
