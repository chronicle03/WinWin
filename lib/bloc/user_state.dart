part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserPostLoading extends UserState {}

class UserPostSuccess extends UserState {}

class UserPostError extends UserState {
  final String code;

  UserPostError(this.code);

}