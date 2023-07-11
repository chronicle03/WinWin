import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:winwin/data/singleton/user_data.dart';
import 'package:winwin/pages/constant.dart';

abstract class UserRepository {
  Future<UserModel> register(
      String name,
      String email,
      String username,
      String phoneNumber,
      String birthdate,
      String password,
      String confirmPassword,
      String isChecked,
      List<String>? skills,);
}

class UserRepositoryImpl extends UserRepository {
  String baserUrl = "http://localhost:8000/api";
  // String baserUrl = "http://192.168.100.241:8000/api";
  // String baserUrl = "http://localhost:8000/api";
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
      String isChecked,
      List<String>? skills,) async {
    final response = await http.post(Uri.parse('$baseUrl/register'), body: {
      "name": name,
      "email": email,
      "username": username,
      "phone_number": phoneNumber,
      "birthdate": birthdate,
      "password": password,
      "confirm_password": confirmPassword,
      "is_checked": isChecked,
      if (skills != null) "skills": skills.join(","),
    });
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
    final response = await http.post(Uri.parse('$baseUrl/email/resend'), body: {
      "email": email,
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      return data;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      throw Exception(responseData['data']['errors']);
    }
  }

  Future<UserModel> login(String email, password) async {
    final response = await http.post(Uri.parse('$baseUrl/login'), body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = data['token_type'] + " " + data['access_token'];
      setToken(user.token);
      await UserData.updateUser(
          user); // save data user yang sudah login ke shared preference

      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      throw Exception(responseData['data']['errors']);
    }
  }

  Future ForgotPassword(String email) async {
    final response =
        await http.post(Uri.parse('$baseUrl/forgotpassword'), body: {
      "email": email,
    });
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

    final response = await http.get(Uri.parse('$baseUrl/users'),
        headers: {'Accept': 'applcation/json'});
    String token = await getToken();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['users'];

      data.forEach((userData) {
        UserModel user = UserModel.fromJson(userData);
        users.add(user);
      });
      return users;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      throw Exception(responseData['data']['errors']);
    }
  }

  Future<UserModel> update({
    String? name,
    String? email,
    String? phoneNumber,
    String? birthdate,
    String? location,
    String? gender,
    String? jobStatus,
    String? bio,
    File? photoProfilePath,
    List<String>? skills,
  }) async {
    String token = await getToken();

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/users/update'));
    request.headers['Authorization'] = token;
    request.headers['content-type'] = 'multipart/form-data';
    Map<String, String> requestBody = {};

    if (photoProfilePath != null) {
      var stream = http.ByteStream(Stream.castFrom(photoProfilePath.openRead()));
      stream.cast();
      var length = await photoProfilePath.length();
      var multipartFile = http.MultipartFile(
        'profile_photo_path',
        stream,
        length,
        filename: photoProfilePath.path.split('/').last,
      );

      request.files.add(multipartFile);
    }

    if (name != null && name.isNotEmpty) {
      requestBody["name"] = name;
    }
    if (email != null && email.isNotEmpty) {
      requestBody["email"] = email;
    }
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      requestBody["phone_number"] = phoneNumber;
    }
    if (birthdate != null && birthdate.isNotEmpty) {
      requestBody["birthdate"] = birthdate;
    }
    if (location != null && location.isNotEmpty) {
      requestBody["location"] = location;
    }
    if (gender != '' && gender!.isNotEmpty) {
      requestBody["gender"] = gender;
    }
    if (jobStatus != null && jobStatus.isNotEmpty) {
      requestBody["job_status"] = jobStatus;
    }
    if (bio != null && bio.isNotEmpty) {
      requestBody["bio"] = bio;
    }
    if (skills != null && skills.isNotEmpty) {
      String skillsString = skills.join(",");
      requestBody["skills"] = skillsString;
    }

    request.fields.addAll(requestBody);

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      await UserData.updateUser(user);
      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> errors = responseData['data']['errors'].values.toList();

      String firstError = errors[0][0];
      throw Exception(firstError);
    }
  }
}
