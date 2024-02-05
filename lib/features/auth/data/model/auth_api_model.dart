import 'package:json_annotation/json_annotation.dart';
import 'package:shoe_store/features/auth/domain/entity/user_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? image;
  final String fullName;
  final String email;
  final String phone;
  final String gender;
  final String address;
  final String username;
  final String password;

  AuthApiModel(
      {this.id,
      this.image,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.gender,
      required this.address,
      required this.username,
      required this.password});

  AuthApiModel.empty()
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
        id: id,
        image: image,
        fullName: fullName,
        email: email,
        phone: phone,
        gender: gender,
        address: address,
        username: username,
        password: password,
      );

  AuthApiModel toApiModel(UserEntity entity) => AuthApiModel(
        id: id ?? '',
        image: entity.image,
        fullName: entity.fullName,
        email: entity.email,
        phone: entity.phone,
        gender: entity.gender,
        address: entity.address,
        username: entity.username,
        password: entity.password,
      );

  List<AuthApiModel> toApiModelList(List<UserEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

  List<UserEntity> toEntityList(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //ToJson
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  //From Json
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  @override
  String toString() {
    return 'id: $id, image: $image, fullName: $fullName, email: $email, phone: $phone, address: $address, username: $username';
  }
}
