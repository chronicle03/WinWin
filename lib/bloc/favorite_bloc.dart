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
          await Future.delayed(const Duration(seconds: 2), () async {
          data = await FavoriteRepository.createFavorite(
            event.user_id,
            event.user_favorite_id,
          );
          
          emit(CreateFavoriteSuccess());
        });
        } catch (e) {
          // print(e);
          emit(CreateFavoriteError(e.toString().replaceAll('Exception: ', '')));
        }
      }

      /*if (event is FavoriteGetFavorites) {
        emit(FavoriteGetFavoritesLoading());
        try {
          await Future.delayed(const Duration(seconds: 2), () async {
          data = await FavoriteRepository.FavoriteGetFavorites(
            event.user_id,
          );
          emit(FavoriteGetFavoritesSuccess());
        });
        } catch (e) {
          // print(e);
          emit(FavoriteGetFavoriteError(e.toString().replaceAll('Exception: ', '')));
        }
      }*/
    });
  }
}