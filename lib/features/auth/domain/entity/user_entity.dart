import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? image;
  final String fullName;
  final String email;
  final String phone;
  final String gender;
  final String address;
  final String username;
  final String password;

  UserEntity({
    this.id,
    this.image,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.address,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        fullName,
        email,
        phone,
        gender,
        address,
        username,
        password,
      ];
}
