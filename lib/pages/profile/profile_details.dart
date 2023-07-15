import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:intl/intl.dart";
import "package:winwin/pages/constant.dart";

import "../../data/models/user_model.dart";

class ProfileDetailsPage extends StatefulWidget {
  final UserModel user;
  late DateTime dateOfBirth;
  late DateTime now;
  late Duration ageDuration;
  late int ageYears;

  ProfileDetailsPage({Key? key, required this.user}) {
    dateOfBirth = DateFormat('yyyy-MM-dd').parse(user.birthdate!);
    now = DateTime.now();
    ageDuration = now.difference(dateOfBirth);
    ageYears = ageDuration.inDays ~/ 365;
  }

  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}
Widget skills(String value) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      color: Color(0xffE7D31F),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          "#${value}",
          style: textPrimaryStyle.copyWith(
            fontSize: 11,
            fontWeight: medium,
          ),
        ),
      ),
    ),
  );
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
                child: widget.user.profilePhotoPath != null
                    ? Image.network(
                  '$baseUrlImage${widget.user.profilePhotoPath}',
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                )
                    : Icon(Icons.person_sharp, color: Colors.black26, size: 500),
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
                            widget.ageYears != 0
                                ? "${widget.user.name!}, ${widget.ageYears}th"
                                : widget.user.name!,
                            style: textPrimaryStyle.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (widget.user.gender == 'male')
                        Image.asset(
                          'assets/icon_male_white.png',
                          width: 18,
                          height: 18,
                        ),
                        if (widget.user.gender == 'female')
                        Image.asset(
                           'assets/icon_female_white.png',
                          width: 18,
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
                                  widget.user.location != null
                                      ? SvgPicture.asset(
                                    'assets/svg/icon_location_blue.svg',
                                    width: 10,
                                    height: 10,
                                  )
                                      : Container(),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.user.location != null ? "${widget.user.location!}" : " ",
                                    style: iconTextStyle.copyWith(
                                      fontSize: 11,
                                      fontWeight: medium,
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
                                    widget.user.bio != null ? widget.user.bio! : "No bio",
                                    style: iconTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: medium,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
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
                                    '${widget.user.jobStatus}',
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
                                  Container(
                                    child: Wrap(
                                      spacing: 5,
                                      children: widget.user.ability!
                                          .map((ability) => skills(ability.skills![0].name!))
                                          .toList(),
                                    ),

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
        body: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
        child: Column(
        children: [
        profileDetails(),
        ],
      ),
        ),
    );
  }
}