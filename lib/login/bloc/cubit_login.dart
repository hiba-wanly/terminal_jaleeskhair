import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jaleskhair/login/bloc/state_login.dart';
import 'package:jaleskhair/login/datalayer/login_data_model.dart';
import 'package:jaleskhair/login/datalayer/login_model.dart';
import 'package:jaleskhair/login/server/login_server.dart';
import 'package:jaleskhair/unit/unit.dart';
import 'package:jaleskhair/userInterface/datalayer/library_information.dart';
import 'package:jaleskhair/userInterface/server/library_information_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(AuthState initialState) : super(initialState);

  static AuthCubit get(context) => BlocProvider.of(context);

  AuthApi authApi = AuthApi();

  late LoginModel loginModel;


  Login(LoginDataModel data) async {
    emit(AuthLoadingState());
    Map<String , dynamic> info = await data.LoginDataToJson();
    dynamic response = await authApi.Login(info);
    if(response != null){
      if(response == "error"){
        emit(AuthLoadedErrorState(message: "لا يمكن تسجيل الدخول"));
      }
      else {
        this.loginModel = LoginModel.fromJson(response);
        if (loginModel.result == "success") {
          emit(AuthLoadedState(loginModel: loginModel));
        }
        else {
          emit(AuthLoadedErrorState(message: "لا يمكن تسجيل الدخول"));
        }
      }
    }
    else{
      emit(AuthLoadedErrorState(message: "لا يمكن تسجيل الدخول"));
    }

  }

  Logout() async {
    emit(AuthLoadingState());
    String? token = await authApi.getToken();
    debugPrint(token);
    dynamic response = await authApi.Logout(token);
    if(response != null){
      if(response == 500){
        emit(NoTokenState());
      }
      else{
        if(response.toString() == "Logged out"){
          emit(LogoutLoaddedState(message: response.toString()));
        }
      }

    }
    else {
      emit(AuthLoadedErrorState(message: "لا يمكن تسجيل الخروج "));
    }
  }


}