part of 'user_bloc.dart';

abstract class FavoriteEvent {}

class FavoritePostCreate extends FavoriteEvent{
  final String user_id;
  final String user_favorite_id;

  FavoritePostCreate(
    this.user_id,
    this.user_favorite_id
  );
}


class FavoriteGetFavorites extends FavoriteEvent{
  final String user_id;
  FavoriteGetFavorites(
    this.user_id
  );
}