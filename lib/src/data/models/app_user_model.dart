import '../../domain/entities/app_user.dart';

/// AppUserModel is the data model for [AppUser]
class AppUserModel {
  String name;
  String email;
  String? image;

  AppUserModel({
    required this.name,
    required this.email,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
    };
  }

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] as String?,
    );
  }

  factory AppUserModel.fromDomain(AppUser appUser) {
    return AppUserModel(
      name: appUser.name,
      email: appUser.email!,
      image: appUser.image,
    );
  }

  AppUser toDomain() {
    return AppUser(
      email: email,
      name: name,
      image: image,
    );
  }
}
