import 'package:equatable/equatable.dart';

import '../data/models/favorite_model.dart';

class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();

  @override
  List<Object?> get props => [];
}

class FavoriteLoading extends FavoriteState {
  const FavoriteLoading();

  @override
  List<Object?> get props => [];
}

class FavoriteLoaded extends FavoriteState {
  final List<FavoriteModel> favorites;

  const FavoriteLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);

  @override
  List<Object?> get props => [message];
}



/*part of 'favorite_bloc.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class CreateFavoriteLoading extends FavoriteState {}

class CreateFavoriteSuccess extends FavoriteState {}

class CreateFavoriteError extends FavoriteState {
  final String code;

  CreateFavoriteError(this.code);

}

class FavoriteGetFavoritesLoading extends FavoriteState{}
class FavoriteGetFavoritesSuccess extends FavoriteState{}
class FavoriteGetFavoriteError extends FavoriteState{
  final String code;

  FavoriteGetFavoriteError(this.code);
}*/