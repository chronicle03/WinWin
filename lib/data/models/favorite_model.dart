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
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    userId = json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null;
    userFavoriteId = json['user_favorite_id'] != null ? int.tryParse(json['user_favorite_id'].toString()) : null;
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