part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserRegisterLoading extends UserState {}

class UserRegisterSuccess extends UserState {}

class UserRegisterError extends UserState {
  final String code;

  UserRegisterError(this.code);

}

class UserLoginLoading extends UserState{}
class UserLoginSuccess extends UserState{}
class UserLoginError extends UserState{
  final String code;

  UserLoginError(this.code);
}

class UserForgotPasswordLoading extends UserState{}
class UserForgotPasswordSuccess extends UserState{}
class UserForgotPasswordError extends UserState{
  final String code;

  UserForgotPasswordError(this.code);
}

 