import 'dart:convert';

import 'package:winwin/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<UserModel> register(
      String name,
      String email,
      String username,
      String phoneNumber,
      String birthdate,
      String password,
      String confirmPassword,
      String isChecked);
}

class UserRepositoryImpl extends UserRepository {
  String baserUrl = "http://localhost:8000/api";
  // String baserUrl = "http://192.168.100.241:8000/api";
  // String baserUrl = "http://localhost:8000/api";
   //String baserUrl = "http://192.168.100.241:8000/api";
  
  //String baserUrl = "http://192.168.231.46:8000/api";

  Map<String, String> headers = {};
  @override
  Future<UserModel> register(
      String name,
      String email,
      String username,
      String phoneNumber,
      String birthdate,
      String password,
      String confirmPassword,
      String isChecked) async {
    final response = await http.post(Uri.parse('$baserUrl/register'), body: {
      "name": name,
      "email": email,
      "username": username,
      "phone_number": phoneNumber,
      "birthdate": birthdate,
      "password": password,
      "confirm_password": confirmPassword,
      "is_checked": isChecked
    });
    print("response: ${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = data['token_type'] + " " + data['access_token'];
      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> errors = responseData['data']['errors'].values.toList();

      String firstError = errors[0][0];
      // print("error:"firstError); // Output: The username has already been taken.

      throw Exception(firstError);
    }
  }

  Future resendEmail(String email) async {
    final response =
        await http.post(Uri.parse('$baserUrl/email/resend'), body: {
      "email": email,
    });
    print("response body: ${response.body} ");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
     
     print("data: $data");
      return data;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      throw Exception(responseData['data']['errors']);
    }
  }

  Future<UserModel> login(String email, password) async {
    final response = await http.post(Uri.parse('$baserUrl/login'), body: {
      "email": email,
      "password": password,
    });

    print("response body: ${response.body} ");
    // print("response body abilities: ${response.body} ");
    if (response.statusCode == 200) {
      //logic login
      var data = jsonDecode(response.body)['data'];
      // print("response body abilities: ${data['user']['ability']} ");
      UserModel user = UserModel.fromJson(data['user']);
      user.token = data['token_type'] + " " + data['access_token'];

      // print("data: ${data['user']}");
      // print("name: ${user.name}");
      // print("ability: ${user.abilities?[0].skills[0].name}");
      // updateCookie(response, user.token!);

      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      throw Exception(responseData['data']['errors']);
    }
  }

  Future ForgotPassword(String email) async {
    final response =
        await http.post(Uri.parse('$baserUrl/forgotpassword'), body: {
      "email": email,
    });
    print("response body: ${response.body} ");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      throw Exception(responseData['data']['errors']);
    }
  }

  Future<List<UserModel>> getUsers() async {
    // print("start getUsers repo");
    final response = await http.get(Uri.parse('$baserUrl/users'), headers: {
      'Authorization': "Bearer 5|jsKv12NXJuAaRzz4Br1NaGWNam9ip2vk7hnvWlwl",
      'Accept': 'applcation/json'
    });

    print("response: ${response.body}");
    if (response.statusCode == 200) {
      // print("response code: ${response.statusCode}");
      var data = jsonDecode(response.body)['data']['users'];
      // print("data: ${data[0]['id']}");
      List<UserModel> users = [];
      data.forEach((userData) {
        print("add user model: ${userData}");
        UserModel user = UserModel.fromJson(userData);
        // print("success add user model: ${user}");
        users.add(user);
      });
      return users;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      throw Exception(responseData['data']['errors']);
    }
  }
}
