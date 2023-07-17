import 'package:winwin/data/models/skill_model.dart';

class AbilityModel {
  int? id;
  int? userId;
  int? skillsId;
  String? level;
  String? createdAt;
  String? updatedAt;
  List<SkillModel>? skills;

  AbilityModel(
      {this.id,
      this.userId,
      this.skillsId,
      this.level,
      this.createdAt,
      this.updatedAt,
      this.skills});

  AbilityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    userId = json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null;
    skillsId = json['skills_id'] != null ? int.tryParse(json['skills_id'].toString()) : null;
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['skills'] != null) {
      skills = <SkillModel>[];
      json['skills'].forEach((v) {
        skills!.add(new SkillModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['skills_id'] = this.skillsId;
    data['level'] = this.level;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}