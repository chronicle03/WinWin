import 'package:winwin/data/models/ability_model.dart';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? emailVerifiedAt;
  String? birthdate;
  String? phoneNumber;
  String? bio;
  String? location;
  String? jobStatus;
  String? profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? token;
  List<AbilityModel>? ability;

  UserModel(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.birthdate,
      this.phoneNumber,
      this.bio,
      this.location,
      this.jobStatus,
      this.profilePhotoPath,
      this.token,
      this.createdAt,
      this.updatedAt,
      this.ability});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    birthdate = json['birthdate'];
    phoneNumber = json['phone_number'];
    bio = json['bio'];
    location = json['location'];
    jobStatus = json['job_status'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['ability'] != null) {
      ability = <AbilityModel>[];
      json['ability'].forEach((v) {
        ability!.add(new AbilityModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['birthdate'] = this.birthdate;
    data['phone_number'] = this.phoneNumber;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['job_status'] = this.jobStatus;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.ability != null) {
      data['ability'] = this.ability!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}