class UserModel {
  String userId;
  String deviceId;
  String name;
  String fatherName;
  String email;
  String phoneNumber;
  String photoURL;
  String address;
  String userQrCode;
  String fbToken;
  bool isDisabled;
  String createdAt;

  UserModel({
    required this.userId,
    required this.deviceId,
    required this.name,
    required this.fatherName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.address,
    required this.userQrCode,
    required this.fbToken,
    required this.isDisabled,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        deviceId: json["deviceId"] ?? '',
        name: json["displayName"] ?? '',
        fatherName: json["fatherName"] ?? '',
        email: json["email"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        photoURL: json["photoURL"] ?? '',
        address: json["address"] ?? '',
        userQrCode: json["userQrCode"] ?? '',
        fbToken: json["fbToken"] ?? '',
        isDisabled: json["isDisabled"] ?? false,
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "deviceId": deviceId,
        "displayName": name,
        "fatherName": fatherName,
        "email": email,
        "phoneNumber": phoneNumber,
        "photoURL": photoURL,
        "address": address,
        "userQrCode": userQrCode,
        "fbToken": fbToken,
        "isDisabled": isDisabled,
        "createdAt": createdAt,
      };
}
