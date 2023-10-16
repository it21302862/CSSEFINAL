class SiteModel {
  String? id;
  String name;
  String createdBy;
  String location;

  SiteModel({
    this.id,
    required this.name,
    required this.createdBy,
    required this.location,
  });

  factory SiteModel.fromMap(Map<String, dynamic> map) {
    return SiteModel(
      id: map['id'],
      name: map['name'],
      createdBy: map['createdBy'],
      location: map['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'location': location,
    };
  }
}
