import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class GetFavorites extends FavoriteEvent {
  final int userId;

  GetFavorites(this.userId);

  @override
  List<Object> get props => [userId];
}

class AddFavorite extends FavoriteEvent {
  final int userId;
  final int userFavoriteId;

  AddFavorite(this.userId, this.userFavoriteId);

  @override
  List<Object> get props => [userId, userFavoriteId];
}


/*part of 'favorite_bloc.dart';

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
}*/