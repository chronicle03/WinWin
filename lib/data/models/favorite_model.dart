class FavoriteModel {
  int? id;
  int? userId;
  int? userFavoriteId;
  String? createdAt;
  String? updatedAt;

  FavoriteModel(
      {this.id,
      this.userId,
      this.userFavoriteId,
      this.createdAt,
      this.updatedAt});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userFavoriteId = json['user_favorite_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_favorite_id'] = this.userFavoriteId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}