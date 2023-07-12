part of 'favorite_bloc.dart';

abstract class FavoriteEvent {}

class FavoritePostCreate extends FavoriteEvent{
  final int userId;
  final int userFavoriteId;

  FavoritePostCreate(
    this.userId,
    this.userFavoriteId
  );
}


class FavoriteGetFavorites extends FavoriteEvent{
  final String user_id;
  FavoriteGetFavorites(
    this.user_id
  );
}