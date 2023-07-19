import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winwin/pages/widgets/avatar_custom.dart';

import '../data/models/user_model.dart';
import 'constant.dart';

class MatchingPage extends StatefulWidget {

  UserModel userLogged;
  UserModel userMatch;

  MatchingPage(this.userLogged, this.userMatch);

  @override
  State<MatchingPage> createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("image url  ${widget.userMatch.profilePhotoUrl}");
    print("image url  ${widget.userMatch.profilePhotoPath}");

    return Scaffold(
      body: Container(
        color: Color(0xff30444F),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 36,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: widget.userLogged.profilePhotoPath != null ? CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(baseUrlImage + widget.userLogged.profilePhotoPath!),
                        ): AvatarCustom(
                          user: widget.userLogged!,
                          width: 38,
                          height: 38,
                          color: appBarColor,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Icon(
                        Icons.arrow_forward_sharp,
                        size: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 36,
                        width: 30,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: widget.userMatch.profilePhotoPath != null ?
                            NetworkImage(baseUrlImage + widget.userMatch.profilePhotoPath!): NetworkImage(widget.userMatch.profilePhotoUrl!),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Hooray! You've matched with ${widget.userMatch.name}!",
                  style: GoogleFonts.poppins(
                    color: Color(0xffEBECEE),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Join the conversation about exchanging abilities, or simply greet with a friendly 'Hi!' to get started.",
                  style: textSecondaryTextStyle.copyWith(
                      fontSize: 15, fontWeight: medium),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
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
                        onPressed: () {
                          _launchInBrowser(
                              Uri.parse('https://wa.me/62${widget.userMatch.phoneNumber}'));
                        },
                        child: Text(
                          "Send a Message",
                          style: textButtonTextStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            titlePadding:
                                EdgeInsets.zero, // Hapus padding pada title
                            title: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16), // Atur padding secara horizontal
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(12),
                                color: Colors.orange
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 24,
                                    width: 6,
                                    color: Colors
                                        .white, // Ubah warna garis menjadi putih
                                    margin: EdgeInsets.only(right: 8),
                                  ),
                                  Icon(
                                    Icons.warning,
                                    color: Colors
                                        .white, // Ubah warna ikon menjadi putih
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Keep Swapping',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Ubah warna teks menjadi putih
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    'Are you sure about continuing the skill swapping?',
                                    style: textPrimaryStyle.copyWith(
                                      fontWeight: semibold,
                                      fontSize: 13
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Aksi yang ingin dilakukan ketika tombol "Yes" ditekan
                                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                                        // Lanjutkan tindakan Anda di sini
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        minimumSize: Size(120, 50),
                                      ),
                                      child: Text('Yes'),
                                    ),
                                    SizedBox(width: 16),
                                    OutlinedButton(
                                      onPressed: () {
                                        // Aksi yang ingin dilakukan ketika tombol "No" ditekan
                                        Navigator.pop(context);
                                        // Lanjutkan tindakan Anda di sini
                                      },
                                      style: OutlinedButton.styleFrom(
                                        primary: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        side:
                                            BorderSide(color: Colors.black),
                                        minimumSize: Size(120, 50),
                                      ),
                                      child: Text('No'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: BorderSide(
                          color: Color(0xff5B8291),
                          width: 1.0,
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            'Keep Swapping',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Color(0xffE7D31F),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
