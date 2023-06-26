import 'package:winwin/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winwin/pages/about.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/rose.jpg'),
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
                                'Your Name',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4.0),
                              Image.asset(
                                'assets/icon_female_white.png',
                                width: 16,
                                height: 16,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '(+62) 812 3456 7890',
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
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(height: 20.0),
                        Text(
                          'General',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                                    color: Color(0xff30444F), ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => About()),
                                );
                              },
                              child: Image.asset(
                                'assets/icon_arrow_right.png',
                                width: 26,
                                height: 26,
                              ),
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
