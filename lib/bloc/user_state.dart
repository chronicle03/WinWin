part of 'user_bloc.dart';

abstract class UserState {
}

class UserInitial extends UserState {}

class UserPostLoading extends UserState {}

class UserPostSuccess extends UserState {}

class UserPostError extends UserState {
  final String code;

  UserPostError(this.code);

  Map<String, dynamic>? get message => null;
}

class UserPostLoginSuccess extends UserState {
  final UserModel user;
  UserPostLoginSuccess(this.user);
  
  @override
  List<Object?> get props => [user];
}

class GetUsersLoaded extends UserState {
  final List<UserModel> users;
  GetUsersLoaded(this.users);
  
  @override
  List<Object?> get props => [users];
}