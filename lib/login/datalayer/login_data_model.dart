class LoginDataModel {
  late dynamic username;
  late dynamic password;

  Future<Map<String,dynamic>> LoginDataToJson () async {
    return {
      'username':this.username,
      'password':this.password
    };
  }
}