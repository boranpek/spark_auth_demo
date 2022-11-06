import '../../../core/base/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_request_model.g.dart';

@JsonSerializable()
class UserRequestModel extends BaseModel<UserRequestModel> {
  String id;
  final String? name;
  final String? email;
  final String? birthYear;
  final String? gender;
  final String? password;

  UserRequestModel({
    this.id = '',
    this.name,
    this.password,
    this.birthYear,
    this.email,
    this.gender,
  });

  factory UserRequestModel.fromJson(Map<String, dynamic> json) => _$UserRequestModelFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) {
    return _$UserRequestModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserRequestModelToJson(this);
  }
}
