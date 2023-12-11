import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jaleskhair/login/server/login_server.dart';
import 'package:jaleskhair/unit/unit.dart';

class LibraryInformationServer{
  Dio dio =  Dio(
    BaseOptions(
      baseUrl: remotehost,
      connectTimeout:  Duration(seconds: serverurl),
      receiveTimeout:  Duration(seconds: serverurl),
    ),
  );

  AuthApi authApi = AuthApi();

  Future<dynamic> GetLibraryInformation(dynamic libraryid,dynamic token) async
  {
    try{
      debugPrint("get1");
      Response response = await dio.get('/api/library_information/${libraryid}',
          options: Options(
              headers: {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token'
              }
          )
      );
      debugPrint("get2");
      if(response.statusCode == 200) {
        debugPrint("get3");
        return response.data;
      }
      else {
        debugPrint("get4");
        return null;
      }
    }on DioError catch(e){
      if(e.response!.statusCode == 401){
        return 500;
      }
      debugPrint(e.response!.statusCode.toString());
      if(e.response!=null)
        debugPrint(e.response!.statusMessage.toString());
      else
        debugPrint(e.message);
      debugPrint("get5");
      return null;
    }
  }
}