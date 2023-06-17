part of 'user_bloc.dart';

abstract class UserEvent {}

class UserPostRegister extends UserEvent{
  final String name;
  final String email;
  final String username;
  final String phoneNumber;
  final String birthdate;
  final String password;
  final String confirmPassword;
  final String isChecked;

  UserPostRegister(
    this.name,
    this.email,
    this.username,
    this.phoneNumber,
    this.birthdate,
    this.password, 
    this.confirmPassword,
    this.isChecked
  );
}
