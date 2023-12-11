import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {

  static final storage = new FlutterSecureStorage();

  Dio dio = Dio(
    BaseOptions(
      baseUrl: remotehost,
      connectTimeout:  Duration(seconds: serverurl),
      receiveTimeout:  Duration(seconds: serverurl),
    ),
  );
  
  Future<dynamic> Login(Map<String , dynamic> data) async
  {
    try {
      debugPrint("login1");
      Response response = await dio.post('/api/login', data: data);
      debugPrint("login2");
      if (response.data['result'] == "success") {
        debugPrint(response.data['token']);
        storeToken(response.data['token']);
        storeLibraryId(response.data['user']['library_id']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("save_token", response.data['token']);
        // SharedPreferences prefss = await SharedPreferences.getInstance();
        prefs.setString("library_name", response.data['library_name']);
        return response.data;
      }
      else {
        return response.data['result'];
      }
    } on DioError catch (e) {
       return null;
    }
  }

  Future<dynamic> Logout(dynamic token) async
  {
  try {
    debugPrint("login1");
  Response response = await dio.post('/api/logout',
      options: Options(headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }));
    debugPrint("login2");
  if (response.statusCode == 200) {
    storage.delete(key: 'token');
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("save_token");
  return response.data['result'];
  }
  else {
  return null;
  }
  } on DioError catch (e) {
    if(e.response!.statusCode == 401){
      return 500;
    }
  return null;
  }
  }


  storeToken(String token) async {
    await storage.write(key: 'token', value: token);
  }
  Future getToken () async {
    return await storage.read(key: 'token');
  }

  storeLibraryId(int id) async {
    await storage.write(key: 'libraryId', value: id.toString());
  }
  Future getLibraryId() async {
    return await storage.read(key: 'libraryId');
  }


}