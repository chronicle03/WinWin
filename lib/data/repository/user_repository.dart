import 'dart:convert';

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
      String isChecked);
}

// class UserData {
//   static UserModel? user;
// }

class UserRepositoryImpl extends UserRepository {
  setToken(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token!);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token ?? '';
  }

  // saveUser(UserModel user) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // Konversi UserModel menjadi bentuk JSON menggunakan toJson()
  //   String userJson = jsonEncode(user.toJson());

  //   // Simpan userJson di SharedPreferences
  //   prefs.setString('user', userJson);
  // }

  // Future<UserModel?> getUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // Ambil data user dari SharedPreferences berdasarkan key 'user'
  //   String? userJson = prefs.getString('user');
  //   print("userJson: $userJson");

  //   if (userJson != null) {
  //     // Jika data userJson ada, konversi kembali ke UserModel menggunakan fromJson()
  //     Map<String, dynamic> userData = jsonDecode(userJson);
  //     UserModel user = UserModel.fromJson(userData);
  //     return user;
  //   } else {
  //     // Jika data userJson tidak ada, kembalikan nilai null
  //     return null;
  //   }
  // }

  List<UserModel> users = [];

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
    final response = await http.post(Uri.parse('$baseUrl/register'), body: {
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
    final response = await http.post(Uri.parse('$baseUrl/email/resend'), body: {
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
    final response = await http.post(Uri.parse('$baseUrl/login'), body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = data['token_type'] + " " + data['access_token'];
      setToken(user.token);
      await UserData.updateUser(user); // save data user yang sudah login ke shared preference

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
    // print("users length: ${users.length}");

    final response = await http.get(Uri.parse('$baseUrl/users'),
        headers: {'Accept': 'applcation/json'});
    String token = await getToken();
    // print("token Get Users : $token");
    // print("response: ${response.body}");
    if (response.statusCode == 200) {
      // print("response code: ${response.statusCode}");
      var data = jsonDecode(response.body)['data']['users'];
      // print("data: ${data[0]['id']}");
      // users.clear();
      print("data length before: ${data.length}");
      print("users length before: ${users.length}");

      data.forEach((userData) {
        // print("add user model: ${userData}");

        UserModel user = UserModel.fromJson(userData);

        users.add(user);
      });
      print("data length after: ${data.length}");
      print("users length after: ${users.length}");
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
    List<String>? skills,
  }) async {
    String token = await getToken();
    print('start update');
    print("name: $name");
    print("token: $token");
    print("phoneNumber: $phoneNumber");
    print("birthdate: $birthdate");
    print("location: $location");
    print("gender: $gender");
    print("jobStatus: $jobStatus");
    print("skills: ${skills}");
    print("skills: ${skills.runtimeType}");
    print("bio: $bio");

    // Buat Map untuk menyimpan field-field yang diupdate
    Map<String, dynamic> requestBody = {};

    if (name != "") {
      requestBody["name"] = name;
    }
    if (email != "") {
      requestBody["email"] = email;
    }
    if (phoneNumber != "") {
      requestBody["phone_number"] = phoneNumber;
    }
    if (birthdate != "") {
      requestBody["birthdate"] = birthdate;
    }
    if (location != "") {
      requestBody["location"] = location;
    }
    if (gender != "") {
      requestBody["gender"] = gender;
    }
    if (jobStatus != "") {
      requestBody["job_status"] = jobStatus;
    }
    if (bio != "") {
      requestBody["bio"] = bio;
    }
    if (skills!.isNotEmpty) {
      String skillsString = skills.join(",");
      print("skillsString: $skillsString");
      requestBody["skills"] = skillsString;
    }

    final response = await http.post(
      Uri.parse('$baseUrl/users/update'),
      body: requestBody,
      headers: {"Authorization": token},
    );

    print("response: ${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      await UserData.updateUser(user);
      print("user data ability: ${user.ability!.length}");
      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> errors = responseData['data']['errors'].values.toList();

      String firstError = errors[0][0];
      // print("error:"firstError); // Output: The username has already been taken.

      throw Exception(firstError);
    }
  }
}
