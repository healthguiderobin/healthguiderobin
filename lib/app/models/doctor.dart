class DoctorModel {
  final String id;
  final String image;
  final String name;
  final String institution;
  final String email;
  final String contact;
  final String degree;
  final String experience;
  final String address;
  final String speciality;

  DoctorModel({
    required this.id,
    required this.image,
    required this.name,
    required this.institution,
    required this.email,
    required this.contact,
    required this.degree,
    required this.experience,
    required this.address,
    required this.speciality,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      institution: json['institution'] ?? '',
      email: json['email'] ?? '',
      contact: json['contact'] ?? '',
      degree: json['degree'] ?? '',
      experience: json['experience'] ?? '',
      address: json['address'] ?? '',
      speciality: json['speciality'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'institution': institution,
      'email': email,
      'contact': contact,
      'degree': degree,
      'experience': experience,
      'address': address,
      'speciality': speciality,
    };
  }
}
