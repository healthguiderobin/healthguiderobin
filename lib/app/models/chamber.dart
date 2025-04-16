class ChamberModel {
  final String name;
  final String location;
  final String timings;
  final String days;
  final String exception;
  final String contact;
  final String note;

  ChamberModel({
    required this.name,
    required this.location,
    required this.contact,
    required this.note,
    required this.timings,
    required this.days,
    required this.exception,
  });

  factory ChamberModel.fromJson(Map<String, dynamic> json) {
    return ChamberModel(
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      contact: json['contact'] ?? '',
      note: json['note'] ?? '',
      timings: json['timings'] ?? '',
      days: json['days'] ?? '',
      exception: json['exception'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'contact': contact,
      'note': note,
      'timings': timings,
      'days': days,
      'exception': exception,
    };
  }
}
