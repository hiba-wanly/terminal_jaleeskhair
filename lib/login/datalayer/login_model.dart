import 'package:jaleskhair/login/datalayer/user_model.dart';

class LoginModel {
  late UserModel user;
  late dynamic token;
  late dynamic library_name;
  late dynamic result;

  LoginModel.fromJson(Map<String, dynamic> json)  {
    user = UserModel.fromJson(json['user']);
    token = json['token'];
    library_name = json['library_name'];
    result = json['result'];
  }
}