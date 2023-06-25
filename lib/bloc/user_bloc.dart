import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/data/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  late UserModel data;
  final UserRepositoryImpl userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<UserEvent>((event, emit) async{
      if (event is UserPostRegister) {
        emit(UserPostLoading());
        try {
          await Future.delayed(const Duration(seconds: 2), () async {
          data = await userRepository.register(
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
          await Future.delayed(const Duration(seconds: 2), () async {
          data = await userRepository.resendEmail(
            event.email
          );
          emit(UserPostSuccess());
        });
        } catch (e) {
          // print(e);
          emit(UserPostError(e.toString().replaceAll('Exception: ', '')));
        }
      }
    });
  }
}
