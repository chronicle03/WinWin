import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:winwin/data/models/favorite_model.dart';
import 'package:http/http.dart' as http;
import 'package:winwin/pages/constant.dart';

import '../models/user_model.dart';
import '../singleton/user_data.dart';

abstract class FavoriteRepository {
  Future<FavoriteModel> createFavorite(
      int userId,
      int userFavoriteId);
}

class FavoriteRepositoryImpl extends FavoriteRepository {
  // String baseUrl = "http://localhost:8000/api";

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token ?? '';
  }

  @override
  Future<FavoriteModel> createFavorite(
      int userId,
      int userFavoriteId) async {
    // print("userId: $userId");
    // print("userFavoriteId: $userFavoriteId");
    // print("starta");
    String token = await getToken();
    final response = await http.post(Uri.parse('$baseUrl/favorites'), body: {
      "user_id": userId.toString(),
      "user_favorite_id": userFavoriteId.toString()
    },
    headers: {"Authorization": token});
    // print("response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      FavoriteModel favorites = FavoriteModel.fromJson(data['users']['favorite'].last);
      UserModel user = UserModel.fromJson(data['users']);
      await UserData.updateUser(user);
      return favorites;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> errors = responseData['data']['errors'].values.toList();

      String firstError = errors[0][0];
      print("error: $firstError"); // Output: The username has already been taken.
      throw Exception(firstError);
    }
  }
}