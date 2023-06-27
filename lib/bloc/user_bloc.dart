
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/data/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserModel? user;
  static UserModel? loggedInUser;
  List<UserModel>? userList;
  String? token;
  final UserRepositoryImpl userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UserPostRegister) {
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 2), () async {
            user = await userRepository.register(
              event.name,
              event.email,
              event.username,
              event.phoneNumber,
              event.birthdate,
              event.password,
              event.confirmPassword,
              event.isChecked,
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
           print("event email: ${event.email}");
          await Future.delayed(const Duration(seconds: 2), () async {
            print("event email: ${event.email}");
            user = await userRepository.resendEmail(event.email);
            emit(UserPostSuccess());
          });
        } catch (e) {
          // print(e);
          emit(UserPostError(e.toString().replaceAll('Exception: ', '')));
        }
      }
      
      
      if (event is UserPostLogin) {
        // print("start");
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 2), () async {
            user = await userRepository.login(
              event.email,
              //event.username,
              //event.phoneNumber,
              event.password,
            );
            token = user!.token;
            loggedInUser =user;
            print("loggedInUser bloc login: ${loggedInUser!.email}");
            print("user bloc login: ${user!.email}");
            // print("user bloc: ${user!.name}");
            emit(UserPostLoginSuccess(user!));
          });
        } catch (e) {
          // print(e);
          emit(UserPostError(e.toString().replaceAll('Exception: ', '')));
        }
        // print("user bloc: $user");
      }

      if (event is UserPostForgotPassword) {
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 2), () async {
            user = await userRepository.ForgotPassword(
              event.email,
            );

            emit(UserPostSuccess());
          });
        } catch (e) {
          // print(e);
          emit(UserPostError(e.toString().replaceAll('Exception: ', '')));
        }
      }

      if (event is GetUsers) {
        
        // print("start");
        // print("token: $token");
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 2), () async {
            // print("start2");
            userList = await userRepository.getUsers();
          });
          // print("done");
          // print("user bloc: ${userList}");
          emit(GetUsersLoaded(userList!));
        } catch (e) {
          emit(UserPostError(e.toString().replaceAll('Exception: ', '')));
        }
      }
    });
  }
}
