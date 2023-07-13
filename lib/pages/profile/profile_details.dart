import "package:flutter/material.dart";
import "package:winwin/pages/constant.dart";
import "package:winwin/data/models/user_model.dart";

class ProfileDetailsPage extends StatelessWidget {
  final UserModel? user;
  const ProfileDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Widget profileDetails() {
      var widget;
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Stack(
              children: [
                Expanded(
                  child: widget.user?.profilePhotoPath != null
                      ? Image.network(
                    '$baseUrlImage${user!.profilePhotoPath}',
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  )
                      : Icon(Icons.person_sharp, color: Colors.black26, size: 30),
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
                              '${widget.user!.name}, ${widget.user!.ageYears}th',
                              style: textButtonTextStyle.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (user!.gender == 'male')
                            Image.asset(
                              'assets/icon_male.png',
                              height: 18,
                            ),
                          if (user!.gender == 'female')
                            Image.asset(
                              'assets/icon_female.png',
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
                                      '${user!.location}',
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
                                      'Bio',
                                      style: textButtonTextStyle.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      user!.bio != null ? user!.bio! : "No bio",
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
                                      '${user!.jobStatus}',
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
                                      height: 30,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: widget.user!.ability!
                                            .map(
                                                (ability) => skills(ability.skills![0].name!))
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
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: profileDetails(),
      ),
    );
  }
}

