part of 'favorite_bloc.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class CreateFavoriteLoading extends FavoriteState {}

class CreateFavoriteSuccess extends FavoriteState {}

class CreateFavoriteError extends FavoriteState {
  final String code;

  CreateFavoriteError(this.code);

}