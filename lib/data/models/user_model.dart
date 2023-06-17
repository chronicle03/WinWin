class UserModel{
  late int id;
  late String name;
  late String email;
  late String username;
  late String bio;
  late String location;
  late String phoneNumber;
  late String birthdate;
  late String profilePhotoUrl;
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.bio,
    required this.location,
    required this.phoneNumber,
    required this.birthdate,
    required this.profilePhotoUrl,
    this.token
  });

  UserModel.fromJson(Map<String, dynamic> json, {bool isRegister = false}) {
    if (isRegister) {
      id = json['id'];
      name = json['name'];
      username = json['username'];
      email = json['email'];
      phoneNumber = json['phone_number'];
      birthdate = json['birthdate'];
      profilePhotoUrl = json['profile_photo_url'];
      token = json['token'];
    } else {
      name = json['name'];
      email = json['email'];
      phoneNumber = json['phone_number'];
      birthdate = json['birthdate'];
    }
  }

  Map<String, dynamic> toJson({bool isRegister = false}) {
    if (isRegister) {
      return {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'phone_number': phoneNumber,
        'birthdate': birthdate,
        'profile_photo_url': profilePhotoUrl,
        'token': token,
      };
    } else {
      return {
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'birthdate': birthdate,
      };
    }
  }
}
