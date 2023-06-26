import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff30444F),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'About',
          style: TextStyle(decoration: TextDecoration.none),
        ),
        elevation: 0, // Menghapus bayangan pada AppBar
        backgroundColor: Colors.transparent, // Membuat AppBar transparan
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/logo.png',
              width: 250,
              height: 200,
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'WinWin is a mobile-based application to hone and develop skills in all fields by exchanging skills between users (teach each other voluntarily). The purpose of this application is to help users to hone any abilities'
                    'according to what is listed on the profile between users by exchanging skills (bartering skills or teaching each other) for free. With the WinWin App, users are'
                    'expected to be able to get connections or network with people who have similar abilities or interests, produce exchanges of information, knowledge and new abilities,'
                    'help plan and organize skills exchange activities, as well as provide feedback and self-evaluation.',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center, // Mengatur perataan teks menjadi tengah
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Our Team',
                  style: GoogleFonts.poppins(
                    color: Color(0xffE7D31F),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/img_alvin.png'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Alvin Fandi \n Syahrizal',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/img_tija.png'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Martiza Aurelia \n Ahmad',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/img_sayyid.png'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Muhammad Sayyid \n Rifqi',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/img_yajid.png'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Muhammad Yazid \n Baihaqi',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/img_raisa.png'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Raisa Akilah \n Araend',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




