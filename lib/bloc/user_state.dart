part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserRegisterLoading extends UserState {}

class UserRegisterSuccess extends UserState {}

class UserRegisterError extends UserState {
  final String code;

  UserRegisterError(this.code);

}