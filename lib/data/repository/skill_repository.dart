import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/constant.dart';
import '../models/skill_model.dart';
import 'package:http/http.dart' as http;

abstract class SkillRepository {
  Future<SkillModel> create(
    String name,
  );
}

class SkillRepositoryImpl extends SkillRepository {
  List<SkillModel> skills = [];
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token ?? '';
  }

  @override
  Future<SkillModel> create(String name) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<List<SkillModel>> getSkills() async {
    print("start skill repo");
    final response = await http.get(Uri.parse('$baseUrl/skills'),
        headers: {'Accept': 'applcation/json'});

    print("response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['skills'];

      data.forEach((skillData) {
        SkillModel skill = SkillModel.fromJson(skillData);
        skills.add(skill);
      });

      print("skill length: ${data.length}");
      // print("users length after: ${skills.length}");
      return skills;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      throw Exception(responseData['data']['errors']);
    }
  }
}
