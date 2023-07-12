import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/data/models/user_model.dart";
import "package:winwin/data/repository/skill_repository.dart";
import "package:winwin/data/repository/user_repository.dart";
import "package:winwin/data/singleton/user_data.dart";
import "package:winwin/pages/constant.dart";
import "package:winwin/pages/profile/profile_settings_page.dart";
import "package:winwin/pages/widgets/input/bio.dart";
import "package:winwin/pages/widgets/input/email.dart";
import "package:winwin/pages/widgets/input/fullname.dart";
import "package:winwin/pages/widgets/input/job_status.dart";
import "package:winwin/pages/widgets/input/location.dart";
import "package:winwin/pages/widgets/input/password.dart";
import "package:winwin/pages/widgets/input/phone_number.dart";
import "package:winwin/pages/widgets/input/skill_select.dart";
import "package:winwin/pages/widgets/snackbar.dart";
import 'dart:io';

import "../../bloc/favorite_bloc.dart";
import "../../bloc/skill_bloc.dart";
import "../../data/models/skill_model.dart";
import "../../data/repository/favorite_repository.dart";
import "../main_page.dart";
import "../widgets/loading_button.dart";

class EditProfilePage extends StatefulWidget {
  const EditProfilePage();

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late SkillBloc _skillBloc;
  String message = "null";
  bool isChecked = false;
  String? selectedDate;
  List<UserModel>? user;
  UserModel? loggedInUser = UserData.user;
  List<String> userSkill = [];
  String? genderSelect;
  int _selectedGenderIndex = 0;
  late SkillRepositoryImpl skillRepositoryImpl = SkillRepositoryImpl();

  void _fetchSkills() {// Cek apakah data sudah diambil sebelumnya
    _skillBloc = BlocProvider.of<SkillBloc>(context);
    _skillBloc.add(GetSkillEvent());// Set variabel flag ke true setelah mengambil data
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  void initState() {
    super.initState();
    UserData.loadUser();
    if (loggedInUser!.gender == 'female') {
      _selectedGenderIndex = 1;
    } else {
      _selectedGenderIndex = 0;
    }
  }

  void _handleGenderSelection(int? index) {
    print("index: $index");
    setState(() {
      if (index == 0) {
        genderSelect = 'male';
      } else if (index == 1) {
        genderSelect = 'female';
      }
      _selectedGenderIndex = index ?? 0;
    });
  }

  void updateUserSkills(List<String> skills) {
    setState(() {
      userSkill = skills;
    });
  }

  File? image;

  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      // image = File(pickedFile.path);
      setState(() {
        image = File(pickedFile.path);
        print("image: $image");
      });
    } else {
      print("no image selected!");
    }
  }

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController jobStatusController = TextEditingController(text:'');
  TextEditingController bioController = TextEditingController(text: '');
  TextEditingController locationController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  final FavoriteRepositoryImpl favoriteRepository = FavoriteRepositoryImpl();
  final UserRepositoryImpl userRepository = UserRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    String? username = loggedInUser!.username;
    String? email = loggedInUser!.email;
    String? profilePhotoPath = loggedInUser!.profilePhotoPath;

    handleUpdate(String message, UserState state) {
      BlocProvider.of<UserBloc>(context).add(UserPostUpdate(
          nameController.text,
          emailController.text,
          phoneNumberController.text,
          selectedDate ?? loggedInUser!.birthdate!,
          locationController.text,
          genderSelect ?? loggedInUser!.gender ?? '',
          jobStatusController.text,
          bioController.text,
          image != null ? image! : null,
          userSkill.toList()));

      if (message != "null") {
        Future.delayed(Duration(seconds: 2), () {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
            color: Colors.red,
            icon: Icons.warning,
            message: message,
          ));
        });
      } else {
        if (state is UserPostSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
            color: Colors.green,
            icon: Icons.check,
            message: "Success update!!",
          ));
        }
      }
      _fetchSkills();
    }

    Widget header() {
      return Column(
        children: [
          const SizedBox(height: 13),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider<FavoriteBloc>(
                                create: (context) => FavoriteBloc(favoriteRepository),
                              ),
                              BlocProvider<UserBloc>(
                                create: (context) => UserBloc(userRepository),
                              ),
                            ],
                            child: MainPage(currentIndex: 2),
                          ),
                        ),
                      ),
                  child: Image.asset(
                    "assets/icon_row_left.png",
                    width: 24,
                    height: 24,
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0)),
                Text(
                  "Profile Settings",
                  style: textColor1TextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    }

    Widget photoProfile() {
      print("image2: $image");
      return Container(
        child: InkWell(
          onTap: () {
            getImage();
          },
          child: profilePhotoPath != null && image == null
              ? ClipOval(
            child: Image.network(
              baseUrlImage + profilePhotoPath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          )
              : image != null
              ? ClipOval(
            child: Image.file(
              File(image!.path).absolute,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          )
              : Icon(Icons.person_sharp, color: Colors.black26, size: 30, ),
        ),
      );
    }

    Widget dateOfBirthInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date of Birth",
            style: textColor3TextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon_calendar.png',
                      width: 26,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        selectedDate ?? loggedInUser!.birthdate!,
                        style: textButtonTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: textColorButton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }

    Widget chooseGender() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Gender",
            style: textColor3TextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _handleGenderSelection(1),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.4,
                          child: Radio<int>(
                            value: 0,
                            groupValue: _selectedGenderIndex,
                            onChanged: _handleGenderSelection,
                            fillColor: MaterialStateProperty.all(iconColor),
                            activeColor: iconColor,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            style: textButtonTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintText: "Male",
                              hintStyle: textButtonTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () => _handleGenderSelection(1),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.4,
                          child: Radio<int>(
                            value: 1,
                            groupValue: _selectedGenderIndex,
                            onChanged: _handleGenderSelection,
                            fillColor: MaterialStateProperty.all(iconColor),
                            activeColor: iconColor,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            style: textButtonTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintText: "Female",
                              hintStyle: textButtonTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }

    Widget buttonSaveChanges(String message, UserState state) {
      return Container(
        width: double.infinity,
        height: 55,
        margin: const EdgeInsets.symmetric(vertical: 14),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () => handleUpdate(message, state),
          child: Text(
            "Save Changes",
            style: textButtonTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              header(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            if (state is UserPostError) {
                              setState(() {
                                message = state.code;
                              });
                            }
                          });
                        },
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: photoProfile()),
                              Text(
                                "Full Name",
                                style: textColor3TextStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              FullNameInput(
                                controller: nameController,
                                hintText: loggedInUser!.name,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              dateOfBirthInput(),
                              LocationInput(locationController, loggedInUser!),
                              chooseGender(),
                              Text(
                                "Phone Number",
                                style: textColor3TextStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              PhoneNumberInput(
                                  controller: phoneNumberController,
                                  hintText: loggedInUser!.phoneNumber),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Email",
                                style: textColor3TextStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              EmailInput(
                                  controller: emailController,
                                  hintText: loggedInUser!.email,
                                  enable: false),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Password",
                                style: textColor3TextStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              PasswordInput(
                                controller: passwordController,
                                hintText: '******',
                                enable: false,
                              ),
                              JobStatusInput(
                                  jobStatusController, loggedInUser!),
                              SkillSelect(
                                  userSkill, updateUserSkills),
                              BioInput(bioController, loggedInUser!),
                              const SizedBox(height: 10),
                              state is UserPostLoading
                                  ? LoadingButton()
                                  : buttonSaveChanges(message, state),
                              const SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
