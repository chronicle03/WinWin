import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/data/models/user_model.dart";
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

import "../main_page.dart";
import "../widgets/loading_button.dart";

class EditProfilePage extends StatefulWidget {
  const EditProfilePage();

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String message = "null";
  bool isChecked = false;
  String? selectedDate;
  List<UserModel>? user;
  UserModel? loggedInUser = UserData.user;
  List<String> userSkill = [];
  String? genderSelect;
  int _selectedGenderIndex = 0;

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

  void initState(){
    super.initState();
    UserData.loadUser();
    if (loggedInUser!.gender == 'female'){
      _selectedGenderIndex = 1;
    }else{
      _selectedGenderIndex = 0;
    }
  }

  void _handleGenderSelection(int? index) {
    print("index: $index" );
    setState(() {
      if(index == 0){
        genderSelect = 'male';
      }
      else if(index == 1){
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

  @override
  Widget build(BuildContext context) {
    // UserModel loggedInUser! =
    //     ModalRoute.of(context)!.settings.arguments as UserModel;
    TextEditingController nameController =
        TextEditingController(text: loggedInUser!.name);
    TextEditingController jobStatusController =
        TextEditingController(text: loggedInUser!.jobStatus);
    TextEditingController bioController =
        TextEditingController(text: loggedInUser!.bio);
    TextEditingController locationController =
        TextEditingController(text: loggedInUser!.location);
    TextEditingController phoneNumberController =
        TextEditingController(text: '');
    TextEditingController emailController = TextEditingController(text: '');
    TextEditingController passwordController = TextEditingController(text: '');
   
    // Access the properties of the logged-in user
    String? username = loggedInUser!.username;
    String? email = loggedInUser!.email;
    String? profilePhotoPath = loggedInUser!.profilePhotoPath;

    handleUpdate(String message, UserState state) {
      print("userSkill edit: $userSkill");
      print("message: $message");

      BlocProvider.of<UserBloc>(context).add(UserPostUpdate(
          nameController.text,
          emailController.text,
          phoneNumberController.text,
          selectedDate ?? loggedInUser!.birthdate!,
          locationController.text,
          genderSelect != null ? genderSelect! : loggedInUser!.gender! ,
          jobStatusController.text,
          bioController.text,
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
        if (state is UserPostSuccess){
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
            color: Colors.green,
            icon: Icons.check,
            message: "Success update!!",
          ));
        }
        
      }
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(2))),
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
      return Container(
        child: InkWell(
          onTap: () {
            // Open the gallery here
            // You can use a package like image_picker to handle the gallery selection
            // Example: https://pub.dev/packages/image_picker
          },
          child: profilePhotoPath != null
              ? ClipOval(
                  child: Image.network(
                    baseUrlImage + profilePhotoPath,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/photoProfile.png',
                  height: 100,
                  width: 100,
                ),
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
                                  enable: false,),
                              JobStatusInput(jobStatusController, loggedInUser!),
                              SkillSelect(
                                  loggedInUser!,
                                  userSkill,
                                  updateUserSkills),
                              BioInput(bioController, loggedInUser!),
                              const SizedBox(height: 10),
                              state is UserPostLoading? LoadingButton() : buttonSaveChanges(message, state),
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
