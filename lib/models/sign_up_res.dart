import 'package:json_annotation/json_annotation.dart';


part 'sign_up_res.g.dart';

@JsonSerializable()
class SignUpModel {
  final String? msg;
  final String? token;

  SignUpModel({ this.msg,this.token});



  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}
