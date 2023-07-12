import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/favorite_model.dart';

class FavoriteService {
  Future<List<FavoriteModel>> getFavorites(int userId) async {
    // URL backend untuk mendapatkan data favorit
    final String url = 'http://localhost:8000/api/favorites';

    try {
      // Melakukan permintaan GET ke backend
      final response = await http.get(Uri.parse(url));

      // Memeriksa kode status respons
      if (response.statusCode == 200) {
        // Parsing data JSON menjadi daftar FavoriteModel
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<FavoriteModel> favorites = [];

        for (final item in responseData) {
          final favorite = FavoriteModel.fromJson(item);
          favorites.add(favorite);
        }

        return favorites;
      } else {
        // Jika respons tidak berhasil, lemparkan Exception dengan pesan error
        throw Exception('Failed to load favorites');
      }
    } catch (error) {
      // Jika terjadi kesalahan saat melakukan permintaan, lemparkan Exception dengan pesan error
      throw Exception('Error: $error');
    }
  }

  Future<void> addFavorite(int userId, int userFavoriteId) async {
    // URL backend untuk menambahkan favorit
    final String url = 'http://localhost:8000/api/favorites';

    try {
      // Melakukan permintaan POST ke backend dengan body request
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'userFavoriteId': userFavoriteId,
        }),
      );

      // Memeriksa kode status respons
      if (response.statusCode != 201) {
        // Jika respons tidak berhasil, lemparkan Exception dengan pesan error
        throw Exception('Failed to add favorite');
      }
    } catch (error) {
      // Jika terjadi kesalahan saat melakukan permintaan, lemparkan Exception dengan pesan error
      throw Exception('Error: $error');
    }
  }

  Future<void> removeFavorite(int favoriteId) async {
    // URL backend untuk menghapus favorit
    final String url = 'http://localhost:8000/api/favorites/$favoriteId';

    try {
      // Melakukan permintaan DELETE ke backend
      final response = await http.delete(Uri.parse(url));

      // Memeriksa kode status respons
      if (response.statusCode != 204) {
        // Jika respons tidak berhasil, lemparkan Exception dengan pesan error
        throw Exception('Failed to remove favorite');
      }
    } catch (error) {
      // Jika terjadi kesalahan saat melakukan permintaan, lemparkan Exception dengan pesan error
      throw Exception('Error: $error');
    }
  }
}
