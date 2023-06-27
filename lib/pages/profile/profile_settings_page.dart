import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:winwin/bloc/user_bloc.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winwin/pages/about.dart';
import 'package:winwin/pages/constant.dart';
import 'package:winwin/pages/profile/edit_profile.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  late UserBloc _userBloc;
  UserModel? loggedInUser; // Add this variable
  String baseUrl = "http://192.168.102.10:8000";

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    loggedInUser = UserBloc.loggedInUser; // Retrieve the logged-in user data
  }

  @override
  Widget build(BuildContext context) {
    String? profilePhotoPath = loggedInUser?.profilePhotoPath;
    return Scaffold(
      body: Container(
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
                        ? ClipOval(
                            child: Image.network(
                              baseUrl + profilePhotoPath,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            'assets/photoProfile.png',
                            height: 60,
                            width: 60,
                          ),
                    SizedBox(width: 8.0),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                loggedInUser!.name!,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4.0),
                              loggedInUser?.gender != null ?
                        SvgPicture.asset(
                          'assets/svg/icon_male.svg',
                          width: 18,
                          height: 18,
                        ) : SizedBox(),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            loggedInUser!.phoneNumber!,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
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
                        Text(
                          'Profile and Security',
                          style: textButtonTextStyle.copyWith(
                            fontSize: 17, fontWeight: FontWeight.w700,
                          )
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () { 
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilePage(loggedInUser!))
                                );
                              },
                              child: Row(
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
                            ),
                            Image.asset(
                              'assets/icon_arrow_right.png',
                              width: 26,
                              height: 26,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'General',
                          style: textButtonTextStyle.copyWith(
                            fontSize: 17, fontWeight: FontWeight.w700,
                          )
                        ),
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
                              child: Text(
                                'Logout',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Color(0xff30444F),
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
                Center(
                  child: Container(
                    width: 450,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi yang dilakukan saat tombol "Delete Account" ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Delete Account',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
