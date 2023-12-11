import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jaleskhair/login/server/login_server.dart';
import 'package:jaleskhair/unit/unit.dart';

class BorrowBookApi {
  Dio dio =  Dio(
    BaseOptions(
      baseUrl: remotehost,
      connectTimeout:  Duration(seconds: serverurl),
      receiveTimeout:  Duration(seconds: serverurl),
    ),
  );

  AuthApi authApi = AuthApi();

  Future<dynamic> BorrowLocalBook(Map<String,dynamic> data,dynamic token) async
  {
    try{
      debugPrint("get1");
      debugPrint(data.toString());
      Response response = await dio.post('/api/borrow_local_book',
          data: data,
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          }));
      debugPrint("get2");
      if(response.statusCode == 200) {
        debugPrint("get3");
        return response.data['message'];
      }
      else {
        debugPrint("get4");
        return null;
        // return "you can't borrow";
      }
    }on DioError catch(e){
      if(e.response!.statusCode == 401){
        return 500;
      }
      if(e.response!=null)
        debugPrint(e.response.toString());
      else
        debugPrint(e.message);
      debugPrint("get5");
      return null;
    }
  }
}