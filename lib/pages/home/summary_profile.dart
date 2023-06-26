import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/pages/constant.dart';
import 'package:winwin/pages/widgets/painter.dart';
import 'package:intl/intl.dart';

class SummaryProfileWidget extends StatelessWidget {
  final UserModel user;
  late DateTime dateOfBirth;
  late DateTime now;
  late Duration ageDuration;
  late int ageYears;
  SummaryProfileWidget({super.key, required this.user}) {
    dateOfBirth = DateFormat('yyyy-MM-dd').parse(user.birthdate!);
    now = DateTime.now();
    ageDuration = now.difference(dateOfBirth);
    ageYears = ageDuration.inDays ~/ 365;
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

  Widget content() {
    return Container(
      margin: EdgeInsets.only(top: 40, right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: appBarColor,
      ),
      child: Stack(
        children: [
          ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: user.profilePhotoPath != null
                  ? Image.network(
                      "http://192.168.100.242:8000${user.profilePhotoPath!}",
                      width: double.infinity,
                      height: 390,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/rose.jpg",
                      width: double.infinity,
                      height: 390,
                      fit: BoxFit.cover,
                    )),
          Positioned(
            top: 1,
            child: Container(
              margin: EdgeInsets.only(top: 350),
              child: CustomPaint(
                painter: MyPainter(),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: appBarColor,
                    margin: EdgeInsets.only(top: 150),
                    width: 356,
                    height: 0, // Adjust the height to match the desired layout
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 276,
                height: 205,
                margin: EdgeInsets.only(top: 380, left: 35, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.birthdate != null
                              ? "${user.name!}, ${ageYears}th"
                              : user.name!,
                          style: textPrimaryStyle.copyWith(
                            fontSize: 17,
                            fontWeight: semibold,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svg/icon_male.svg',
                          width: 18,
                          height: 18,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/icon_location_blue.svg',
                          width: 10,
                          height: 10,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          user.location != null ? "${user.location!}" : " ",
                          style: iconTextStyle.copyWith(
                            fontSize: 11,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      user.bio != null ? user.bio! : "No bio",
                      style: iconTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: user.ability!
                          .map((ability) => skills(ability.skills![0].name!))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return content();
  }
}
