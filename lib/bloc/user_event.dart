part of 'user_bloc.dart';

abstract class UserEvent {}

class UserPostRegister extends UserEvent {
  final String name;
  final String email;
  final String username;
  final String phoneNumber;
  final String birthdate;
  final String password;
  final String confirmPassword;
  final String isChecked;

  UserPostRegister(this.name, this.email, this.username, this.phoneNumber,
      this.birthdate, this.password, this.confirmPassword, this.isChecked);
}

class UserPostUpdate extends UserEvent {
   String name;
   String email;
   String phoneNumber;
   String birthdate;
   String location;
   String gender;
   String jobStatus;
   List<String> skills;
   String bio;

  UserPostUpdate(
    this.name, 
    this.email, 
    this.phoneNumber,
    this.birthdate, 
    this.location, 
    this.gender, 
    this.jobStatus,
    this.bio,
    this.skills,
    
    );
}

class UserPostResendEmailVerify extends UserEvent {
  final String email;
  UserPostResendEmailVerify(this.email);
}

class UserPostLogin extends UserEvent {
  final String email;
  //final String username;
  //final String phoneNumber;
  final String password;

  UserPostLogin(
    this.email,
    //this.username,
    //this.phoneNumber,
    this.password,
  );
}

class UserPostForgotPassword extends UserEvent {
  final String email;

  UserPostForgotPassword(
    this.email,
  );
}

class GetUsers extends UserEvent {}
