import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaleskhair/unit/unit.dart';

class NetworkController extends GetxController{
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnecttionStatus);
  }

  void _updateConnecttionStatus(ConnectivityResult connectivityResult){

    if(connectivityResult == ConnectivityResult.none){
      appbarcolor = Colors.red;
    }
    else{
      appbarcolor = primarycolor;
    }
  }
}