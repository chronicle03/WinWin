import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant.dart';

class MatchingPage extends StatelessWidget {
  const MatchingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff30444F),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(50.0),
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
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/john_mayer.jpg'),
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
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/rose.jpg'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Hooray! You've matched with someone!",
                  style: GoogleFonts.poppins(
                    color: Color(0xffEBECEE),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Join the conversation about exchanging abilities, or simply greet with a friendly 'Hi!' to get started.",
                  style: GoogleFonts.poppins(
                    color: Color(0xffE9E9EAD9),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(65.0),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 45.0),
                        child: Text(
                          'Send a Message!',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(65.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(65.0),
                          color: Color(0xff30444F),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                titlePadding: EdgeInsets.zero, // Hapus padding pada title
                                title: Container(
                                  color: Colors.orange, // Ubah warna latar belakang menjadi oranye
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Atur padding secara horizontal
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 24,
                                        width: 6,
                                        color: Colors.white, // Ubah warna garis menjadi putih
                                        margin: EdgeInsets.only(right: 8),
                                      ),
                                      Icon(
                                        Icons.warning,
                                        color: Colors.white, // Ubah warna ikon menjadi putih
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Keep Swapping',
                                        style: TextStyle(
                                          color: Colors.white, // Ubah warna teks menjadi putih
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
                                      margin: EdgeInsets.symmetric(vertical: 16),
                                      child: Text(
                                        'Are you sure about continuing the skill swapping?',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // Aksi yang ingin dilakukan ketika tombol "Yes" ditekan
                                            Navigator.pop(context);
                                            // Lanjutkan tindakan Anda di sini
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orange,
                                            minimumSize: Size(150, 50),
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
                                            side: BorderSide(color: Colors.black),
                                            minimumSize: Size(150, 50),
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
                              borderRadius: BorderRadius.circular(65.0),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 45.0),
                            child: Text(
                              'Keep Swapping',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Color(0xffE7D31F),
                            ),
                          ),
                        ),
                      ),
                    ),
                    )],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
