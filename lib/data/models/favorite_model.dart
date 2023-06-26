class FavoriteModel {
  late int id;
  late String user_id;
  late String user_favorite_id;

  FavoriteModel({
    required this.id,
    required this.user_id,
    required this.user_favorite_id,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json, {bool iscreateFavorite = false, bool isgetFavorites = false}) {
    if (iscreateFavorite) {
      id = json['id'];
      user_id = json['user_id'];
      user_favorite_id = json['user_favorite_id'];
    }
    else if (isgetFavorites){
      user_id = json['user_id'];
    }
    else {
      user_id = json['user_id'];
      user_favorite_id = json['user_favorite_id'];
    }
  }

  Map<String, dynamic> toJson({bool iscreateFavorite = false}) {
    if (iscreateFavorite) {
      return {
        'id': id,
        'user_id': user_id,
        'user_favorite_id': user_favorite_id,
      };
    } else {
      return {
        'user_id': user_id,
        'user_favorite_id': user_favorite_id,
      };
    }
  }
}