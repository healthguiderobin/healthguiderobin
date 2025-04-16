class HospitalModel {
  final String id;
  final String image;
  final String name;
  final String address;
  final String discountPrcntg;
  final String contact;

  HospitalModel({
    required this.id,
    required this.image,
    required this.name,
    required this.address,
    required this.discountPrcntg,
    required this.contact,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      discountPrcntg: json['discountPrcntg'] ?? '',
      contact: json['contact'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'address': address,
      'discountPrcntg': discountPrcntg,
      'contact': contact,
    };
  }
}
