
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/data/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserModel? user;
  static UserModel? loggedInUser;
  static List<UserModel> userList = [];
  String? token;
  final UserRepositoryImpl userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UserPostRegister) {
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 0), () async {
            user = await userRepository.register(
              event.name,
              event.email,
              event.username,
              event.phoneNumber,
              event.birthdate,
              event.password,
              event.confirmPassword,
              event.isChecked,
              event.skills
            );

            emit(UserPostSuccess());
          });
        } catch (e) {
          // print(e);
          var err = e.toString().replaceAll('Exception: ', '');
          emit(UserPostError(err));
        }
      }

      if (event is UserPostUpdate) {
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 0), () async {
            user = await userRepository.update(
              name: event.name,
              email: event.email,
              phoneNumber: event.phoneNumber,
              birthdate: event.birthdate,
              location: event.location,
              gender: event.gender,
              jobStatus: event.jobStatus,
              bio: event.bio,
              skills: event.skills,
              photoProfilePath: event.photoProfilePath,
            );

            emit(UserPostSuccess());
          });
        } catch (e) {
          // print(e);
          var err = e.toString().replaceAll('Exception: ', '');
          emit(UserPostError(err));
        }
      }

      if (event is UserPostResendEmailVerify) {
        emit(UserPostLoading());
        try {
          //  print("event email: ${event.email}");
          await Future.delayed(const Duration(seconds: 0), () async {
            // print("event email: ${event.email}");
            await userRepository.resendEmail(event.email);
            emit(UserPostSuccess());
          });
        } catch (e) {
          // print(e);
          var err = e.toString().replaceAll('Exception: ', '');
          emit(UserPostError(err));
        }
      }

      if (event is UserPostLogin) {
        // print("start");
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 0), () async {
            user = await userRepository.login(
              event.email,
              event.password,
            );
            token = user!.token;
            loggedInUser =user;

            emit(UserPostLoginSuccess(user!));
          });
        } catch (e) {
          emit(UserPostError(e.toString().replaceAll('Exception: ', '')));
        }
        // print("user bloc: $user");
      }

      if (event is UserPostForgotPassword) {
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 0), () async {
            await userRepository.forgotPassword(
              event.email,
            );
            emit(UserPostSuccess());
          });
        } catch (e) {
          emit(UserPostError(e.toString().replaceAll('Exception: ', '')));
        }
      }

      if (event is GetUsers) {
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 0), () async {
            userList.clear();
            userList = await userRepository.getUsers();
          });
          emit(GetUsersLoaded(userList));
        } catch (e) {
          emit(UserPostError(e.toString().replaceAll('Exception: ', '')));
        }
      }

      if (event is UserPostLogout) {
        // print("token bloc: $token");
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 0), () async {
            // print("start0");
            await userRepository.logout();
          });
          // print("user list bloc: ${userList[0].favorite![0].userFavoriteId}");
          emit(UserPostSuccess());
        } catch (e) {
          emit(UserPostError(e.toString().replaceAll('Exception: ', '')));
        }
      }
    });
  }
}
