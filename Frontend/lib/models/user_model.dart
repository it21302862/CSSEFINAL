import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String role;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.role,
  });
  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      role: data['role'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
    );
  }
}

class SiteManagerModel extends UserModel {
  final String? siteId;
  final String? siteName;
  SiteManagerModel({
    super.id,
    required super.name,
    required super.email,
    required super.role,
    this.siteId,
    this.siteName,
  });
  factory SiteManagerModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return SiteManagerModel(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      role: data['role'],
      siteId: data['siteId'],
      siteName: data['siteName'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
    };
  }

  factory SiteManagerModel.fromMap(Map<String, dynamic> map) {
    return SiteManagerModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
      siteId: map['siteId'],
      siteName: map['siteName'],
    );
  }
}
