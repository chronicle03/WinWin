import 'dart:convert';

import 'package:winwin/data/models/favorite_model.dart';
import 'package:http/http.dart' as http;

abstract class FavoriteRepository {
  Future<FavoriteModel> createFavorite(
      String user_id,
      String user_favorite_id);
}

class FavoriteRepositoryImpl extends FavoriteRepository {
  String baseUrl = "http://localhost:8000/api";

  @override
  Future<FavoriteModel> createFavorite(
      String user_id,
      String user_favorite_id) async {
    final response = await http.post(Uri.parse('$baseUrl/favorites'), body: {
      "user_id": "user_id",
      "user_favorite_id": "user_favorite_id"
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      FavoriteModel favorites = FavoriteModel.fromJson(data['user']);
      return favorites;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> errors = responseData['data']['errors'].values.toList();

      String firstError = errors[0][0];
      // print("error:"firstError); // Output: The username has already been taken.

      throw Exception(firstError);
    }
  }
}

/*Future getFavorite(String email) async {
    
    final response = await http.post(Uri.parse('$baserUrl/favorites'), body: {
      "user_id": "user_id"
    });
    print("response body: ${response.body} ");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      FavoriteModel user =
          FavoriteModel.fromJson(data['user'], isResendEmailVerify: true);
      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
    
      throw Exception(responseData['data']['errors']);
    }
  }*/