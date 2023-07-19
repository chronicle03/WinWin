import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winwin/bloc/user_bloc.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winwin/data/repository/user_repository.dart';
import 'package:winwin/data/singleton/user_data.dart';
import 'package:winwin/pages/about.dart';
import 'package:winwin/pages/constant.dart';
import 'package:winwin/pages/home/home_page.dart';
import 'package:winwin/pages/landing/landing_page.dart';
import 'package:winwin/pages/profile/edit_profile.dart';

import '../widgets/avatar_custom.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  // late UserBloc _userBloc;
  UserModel? user = UserData.user; // Add this variable

  @override
  void initState() {
    super.initState();
    // updateUser();
    UserData.loadUser();
    user = UserData.user;
  }

//   void updateUser() async {
//   await UserData.loadUser(); // Memuat data pengguna yang terbaru
//   setState(() {
//     user = UserData.user; // Perbarui nilai user dengan data pengguna yang terbaru
//   });
// }

  @override
  Widget build(BuildContext context) {
    void handleLogout() {
      BlocProvider.of<UserBloc>(context).add(UserPostLogout());
    }

    // print("user home: ${user!.email}");
    String? profilePhotoPath = user?.profilePhotoPath;
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserPostSuccess) {
            EasyLoading.dismiss();
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is UserPostLoading) {
            EasyLoading.show(status: '');
          } else if (state is UserPostError) {
            print("${state.code}");
          }
          return Container(
            color: Color(0xff30444F),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profilePhotoPath != null
                            ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: appBarColor,
                              width: 5.0,
                            ),
                          ),
                              child: ClipOval(
                                  child: Image.network(
                                    baseUrlImage + profilePhotoPath,
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            )
                            : AvatarCustom(
                                user: user!,
                                width: 60,
                                height: 60,
                                color: appBarColor,
                                fontSize: 18,
                              ),
                        SizedBox(width: 8.0),
                        Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(user!.username!,
                                      style: textColor1TextStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  SizedBox(width: 4.0),
                                  user?.gender != null
                                      ? SvgPicture.asset(
                                          'assets/svg/icon_male.svg',
                                          width: 18,
                                          height: 18,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(user!.phoneNumber!,
                                  style: textColor1TextStyle.copyWith(
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Center(
                      child: Container(
                        width: 450,
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Profile and Security',
                                style: textButtonTextStyle.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(height: 16.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/edit-profile',
                                    arguments: user!);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icon_person.png',
                                        width: 22,
                                        height: 22,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Profile Settings',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Color(0xff30444F),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/icon_arrow_right.png',
                                    width: 26,
                                    height: 26,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text('General',
                                style: textButtonTextStyle.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => About()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icon_help.png',
                                        width: 32,
                                        height: 32,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'About WinWin',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Color(0xff30444F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'assets/icon_arrow_right.png',
                                  width: 26,
                                  height: 26,
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icon_sticky_note.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'Terms & Conditions',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Color(0xff30444F),
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/icon_arrow_right.png',
                                  width: 26,
                                  height: 26,
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icon_privacy.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'Privacy Policy',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Color(0xff30444F),
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/icon_arrow_right.png',
                                  width: 26,
                                  height: 26,
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icon_logout.png',
                                  width: 32,
                                  height: 32,
                                ),
                                SizedBox(width: 4.0),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      handleLogout();
                                    },
                                    child: Text(
                                      'Logout',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Color(0xff30444F),
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
                    SizedBox(height: 16.0),
                    // Center(
                    //   child: Container(
                    //     width: 450,
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         // Aksi yang dilakukan saat tombol "Delete Account" ditekan
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         primary: Colors.yellow,
                    //         onPrimary: Colors.black,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(12.0),
                    //         ),
                    //       ),
                    //       child: Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 16.0),
                    //         child: Text(
                    //           'Delete Account',
                    //           style: GoogleFonts.poppins(
                    //             fontSize: 18,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
