import 'package:equatable/equatable.dart';

/// user entity
class AppUser extends Equatable {
  final String name;
  final String? email;
  final String? image;

  const AppUser({
    required this.name,
    required this.email,
    this.image,
  });

  /// override props to compare objects
  @override
  List<Object?> get props => [
        name,
        email,
        image,
      ];

  /// copyWith method to create a copy of the object
  AppUser copyWith({
    String? name,
    String? email,
    String? image,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }
}
