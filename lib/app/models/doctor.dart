class DoctorModel {
  final String id;
  final String image;
  final String name;
  final String institution;
  final String contact;
  final String degree;
  final String experience;
  final String address;
  final String specialityId;
  final String specialityName;
  final String discount;
  final String otDiscount;
  final String about;

  DoctorModel({
    required this.id,
    required this.image,
    required this.name,
    required this.institution,
    required this.contact,
    required this.degree,
    required this.experience,
    required this.address,
    required this.specialityId,
    required this.specialityName,
    required this.discount,
    required this.otDiscount,
    required this.about,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      institution: json['institution'] ?? '',
      contact: json['contact'] ?? '',
      degree: json['degree'] ?? '',
      experience: json['experience'] ?? '',
      address: json['address'] ?? '',
      specialityId: json['specialityId'] ?? '',
      specialityName: json['specialityName'] ?? '',
      discount: json['discount'] ?? '',
      otDiscount: json['otDiscount'] ?? '',
      about: json['about'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'institution': institution,
      'contact': contact,
      'degree': degree,
      'experience': experience,
      'address': address,
      'specialityId': specialityId,
      'specialityName': specialityName,
      'discount': discount,
      'otDiscount': otDiscount,
      'about': about,
    };
  }
}
