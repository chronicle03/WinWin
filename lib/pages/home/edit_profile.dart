import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:winwin/bloc/user_bloc.dart";
import "package:winwin/data/models/user_model.dart";
import "package:winwin/pages/constant.dart";

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserBloc _userBloc;
  UserModel? loggedInUser; // Add this variable
  
  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    loggedInUser = UserBloc.loggedInUser; // Retrieve the logged-in user data
  }

  String message = "null";
  bool isChecked = false;
  String? selectedDate;
  String baseUrl = "http://192.168.100.242:8000";

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

  int _selectedGenderIndex = 0;
  void _handleGenderSelection(int? index) {
    setState(() {
      _selectedGenderIndex = index ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    print("loggedInUser: $loggedInUser");
    // Access the properties of the logged-in user
    String? username = loggedInUser?.username;
    String? email = loggedInUser?.email;
    String? profilePhotoPath = loggedInUser?.profilePhotoPath;
    print("username: $username");
    print("email: $email");

    Widget header() {
      return Column(
        children: [
          const SizedBox(height: 13),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
          child: profilePhotoPath != null ?  ClipOval(
            child: Image.network(
              baseUrl+profilePhotoPath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ): Image.asset(
            'assets/photoProfile.png',
            height: 100,
            width: 100,
          ),
        ),
      );
    }

    Widget fullNameInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Full Name",
            style: textColor3TextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    "assets/icon_profile_default.png",
                    width: 26,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: TextFormField(
                    style: textButtonTextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration.collapsed(
                        hintText: loggedInUser!.name,
                        hintStyle: textButtonTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
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

    Widget locationInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Location",
            style: textColor3TextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_location_blue.png',
                    width: 26,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: TextFormField(
                    style: textButtonTextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration.collapsed(
                        hintText: loggedInUser!.location ??  "",
                        hintStyle: textButtonTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                ],
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

    Widget phoneNumberInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Phone Number",
            style: textColor3TextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_call.png',
                    width: 26,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: TextFormField(
                    style: textButtonTextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration.collapsed(
                        hintText: loggedInUser!.phoneNumber ??  "",
                        hintStyle: textButtonTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }

    Widget emailAddressInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Email Address",
            style: textColor3TextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_email.png',
                    width: 26,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: TextFormField(
                    style: textButtonTextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration.collapsed(
                        hintText: loggedInUser!.email ??  "",
                        hintStyle: textButtonTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }

    Widget passwordInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Password",
            style: textColor3TextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_password.png',
                    width: 35,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      child: TextFormField(
                    obscureText: true,
                    style: textButtonTextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration.collapsed(
                        hintText: "********",
                        hintStyle: textButtonTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                  Image.asset(
                    "assets/icon_eye_close.png",
                    width: 26,
                    height: 23,
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }

    Widget jobStatusInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Job Status",
            style: textColor3TextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_bag.png',
                    width: 26,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: TextFormField(
                    style: textButtonTextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration.collapsed(
                        hintText: loggedInUser!.jobStatus ??  "",
                        hintStyle: textButtonTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }

    Widget skillsInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Skills",
            style: textColor3TextStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            decoration: BoxDecoration(
                color: appBarColor, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_lamp.png',
                    width: 39,
                    height: 36,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                      child: TextFormField(
                    style: textButtonTextStyle.copyWith(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    decoration: InputDecoration.collapsed(
                        hintText: "Design, Fashion",
                        hintStyle: textButtonTextStyle.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }

    Widget bioInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Bio",
            style: textColor3TextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 151,
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
            decoration: BoxDecoration(
              color: appBarColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon_profile_free.png',
                        width: 26,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
                          textAlign: TextAlign.justify,
                          style: textButtonTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText:
                                loggedInUser!.bio ??  "",
                            hintStyle: textButtonTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), 
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }

    Widget buttonSaveChanges(String message) {
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
          onPressed: () {},
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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                header(),
                photoProfile(),
                fullNameInput(),
                const SizedBox(
                  height: 10,
                ),
                dateOfBirthInput(),
                locationInput(),
                chooseGender(),
                phoneNumberInput(),
                emailAddressInput(),
                passwordInput(),
                jobStatusInput(),
                skillsInput(),
                bioInput(),
                const SizedBox(height: 10),
                buttonSaveChanges(message),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
