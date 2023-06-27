import "package:flutter/material.dart";
import "package:winwin/pages/constant.dart";

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Widget profileDetails() {
      return Column(
        children: [
          Stack(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/user2.png',
                  fit: BoxFit.cover,
                  height: 550,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(height: 120, width: 25),
                      Positioned(
                        top: 0,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            "assets/icon_row_left.png",
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Profile Details",
                        style: textColor1TextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 433),
                child: Image.asset(
                  'assets/background.png',
                  fit: BoxFit.fill,
                  height: 410,
                  width: double.infinity,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 508),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Your Name 1, 22th',
                            style: textButtonTextStyle.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/icon_male.png',
                          height: 18,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icon_location_blue.png',
                                    height: 8,
                                    width: 6,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'West Jakarta, Indonesia',
                                    style: iconTextStyle.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20, left: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi, I am a programmer with more than 8 years',
                                    style: textColor2TextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'experience in software development. I have',
                                    style: textColor2TextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'expertise in several programming languages,',
                                    style: textColor2TextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'including Python, JavaScript, and Java. I have',
                                    style: textColor2TextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'experience in developing web and mobile',
                                    style: textColor2TextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'applications.',
                                    style: textColor2TextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20, left: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Job Status',
                                    style: textButtonTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Programmer',
                                    style: textColor2TextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20, left: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Skills',
                                    style: textButtonTextStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 7.0, right: 7.0),
                                        decoration: BoxDecoration(
                                          color: textColorButton,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text(
                                          '#program',
                                          style: textColor3TextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 7.0, right: 7.0),
                                        decoration: BoxDecoration(
                                          color: textColorButton,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text(
                                          '#application',
                                          style: textColor3TextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 7.0, right: 7.0),
                                        decoration: BoxDecoration(
                                          color: textColorButton,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text(
                                          '#IT',
                                          style: textColor3TextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          profileDetails(),
        ],
      ),
    );
  }
}