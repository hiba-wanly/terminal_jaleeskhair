import 'package:jaleskhair/login/datalayer/login_model.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {
  final LoginModel loginModel;
  AuthLoadedState({required this.loginModel});
}

class AuthLoadedErrorState extends AuthState {
  final String message ;
  AuthLoadedErrorState({required this.message});
}

class LogoutLoaddedState extends AuthState {
  final String message;
  LogoutLoaddedState({required this.message});
}
class NoTokenState extends AuthState {}