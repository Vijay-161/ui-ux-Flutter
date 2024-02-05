
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/constants/hive_table_constants.dart';

part 'auth_hive_model.g.dart';
final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);
@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? image;

  @HiveField(2)
  final String fullName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final String address;

  @HiveField(7)
  final String username;

  @HiveField(8)
  final String password;

  AuthHiveModel(
      {String? id,
      required this.image,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.gender,
      required this.address,
      required this.username,
      required this.password})
      : id = id ?? const Uuid().v4();

  AuthHiveModel.empty()
      : this(
          id: '',
          image: '',
          fullName: '',
          email: '',
          phone: '',
          gender: '',
          address: '',
          username: '',
          password: '',
        );
  UserEntity toEntity() => UserEntity(
      image: image,
      id: id,
      fullName: fullName,
      email: email,
      phone: phone,
      gender: gender,
      address: address,
      username: username,
      password: password);

  AuthHiveModel toHiveModel(UserEntity entity) => AuthHiveModel(
      id: const Uuid().v4(),
      image: entity.image ?? '',
      fullName: entity.fullName,
      email: entity.email,
      phone: entity.phone,
      gender: entity.gender,
      address: entity.address,
      username: entity.username,
      password: entity.password);

  List<AuthHiveModel> toHiveModelList(List<UserEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'id: $id, fullname: $fullName, phone: $phone, gender: $gender, address: $address, username: $username';
  }
}
