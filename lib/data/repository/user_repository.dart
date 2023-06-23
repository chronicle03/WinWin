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
   //String baserUrl = "http://192.168.100.241:8000/api";
  
  //String baserUrl = "http://192.168.231.46:8000/api";

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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user'], isRegister: true);
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
    final response = await http.post(Uri.parse('$baserUrl/email/resend'), body: {
      "email": email,
    });
    print("response body: ${response.body} ");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user =
          UserModel.fromJson(data['user'], isResendEmailVerify: true);
      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
    
      throw Exception(responseData['data']['errors']);
    }
  }

  Future Login(String email, username, phoneNumber, password) async{
   final response = await http.post(Uri.parse('$baserUrl/login'), body: {
      "email": email, "username": username, "phonenumber": phoneNumber,
    });
    print("response body: ${response.body} ");
    if (response.statusCode == 200) {//logic login
      var data = jsonDecode(response.body)['data'];
      UserModel user =
          UserModel.fromJson(data['user'], isLogin: true);
      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
    
      throw Exception(responseData['data']['errors']);
    }
  }

  Future ForgotPassword(String email) async{
   final response = await http.post(Uri.parse('$baserUrl/forgotpassword'), body: {
      "email": email,
    });
    print("response body: ${response.body} ");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user =
          UserModel.fromJson(data['user'], isForgotPassword: true);
      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
    
      throw Exception(responseData['data']['errors']);
    }
  }
}
