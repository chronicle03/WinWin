import 'ability_model.dart';
import 'favorite_model.dart';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? gender;
  String? email;
  String? emailVerifiedAt;
  String? birthdate;
  String? phoneNumber;
  String? bio;
  String? location;
  String? jobStatus;
  String? token;
  String? profilePhotoPath;
  String? profilePhotoUrl;
  String? createdAt;
  String? updatedAt;
  List<AbilityModel>? ability;
  List<FavoriteModel>? favorite;

  UserModel(
      {this.id,
        this.name,
        this.username,
        this.gender,
        this.email,
        this.emailVerifiedAt,
        this.birthdate,
        this.phoneNumber,
        this.bio,
        this.location,
        this.jobStatus,
        this.profilePhotoPath,
        this.profilePhotoUrl,
        this.createdAt,
        this.updatedAt,
        this.ability,
        this.favorite});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    name = json['name'];
    username = json['username'];
    gender = json['gender'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    birthdate = json['birthdate'];
    phoneNumber = json['phone_number'];
    bio = json['bio'];
    location = json['location'];
    jobStatus = json['job_status'];
    profilePhotoPath = json['profile_photo_path'];
    profilePhotoUrl = json['profile_photo_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['ability'] != null) {
      ability = <AbilityModel>[];
      json['ability'].forEach((v) {
        ability!.add(new AbilityModel.fromJson(v));
      });
    }
    if (json['favorite'] != null) {
      favorite = <FavoriteModel>[];
      json['favorite'].forEach((v) {
        favorite!.add(new FavoriteModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['gender'] = gender;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['birthdate'] = birthdate;
    data['phone_number'] = phoneNumber;
    data['bio'] = bio;
    data['location'] = location;
    data['job_status'] = jobStatus;
    data['profile_photo_path'] = profilePhotoPath;
    data['profile_photo_url'] = profilePhotoUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (ability != null) {
      data['ability'] = ability!.map((v) => v.toJson()).toList();
    }
    if (favorite != null) {
      data['favorite'] = favorite!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}