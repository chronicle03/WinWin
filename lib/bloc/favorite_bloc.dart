import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winwin/data/models/favorite_model.dart';
import 'package:winwin/data/repository/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  late FavoriteModel data;
  final FavoriteRepositoryImpl FavoriteRepository;

  FavoriteBloc(this.FavoriteRepository) : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit) async{
      if (event is FavoritePostCreate) {
        emit(CreateFavoriteLoading());
        try {
          await Future.delayed(const Duration(seconds: 0), () async {
          data = await FavoriteRepository.createFavorite(
            event.userId,
            event.userFavoriteId,
          );
          print(data.id);
          
          emit(CreateFavoriteSuccess());
        });
        } catch (e) {
          print(e);
          emit(CreateFavoriteError(e.toString().replaceAll('Exception: ', '')));
        }
      }
    });
  }
}