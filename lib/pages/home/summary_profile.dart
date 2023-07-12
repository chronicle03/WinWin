import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipeable_cards_stack/swipeable_cards_stack.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/pages/constant.dart';
import 'package:winwin/pages/profile/profile_details.dart';
import 'package:winwin/pages/widgets/painter.dart';
import 'package:intl/intl.dart';

class SummaryProfileWidget extends StatefulWidget {
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

  @override
  State<SummaryProfileWidget> createState() => _SummaryProfileWidgetState();
}

class _SummaryProfileWidgetState extends State<SummaryProfileWidget> {

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

  @override
  Widget build(BuildContext context) {
    print("user filter summary: ${widget.user.name}");
    Widget content() {
      return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileDetailsPage()));
        },
        child: Container(
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
                  child: widget.user.profilePhotoPath != null
                      ? Image.network(
                    "$baseUrlImage${widget.user.profilePhotoPath!}",
                    width: double.infinity,
                    height: 390,
                    fit: BoxFit.cover,
                  )
                      : Center(child: Icon(Icons.person_sharp, size: 300, color: Colors.black26, ))),
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
                        height:
                        0, // Adjust the height to match the desired layout
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
                              widget.ageYears != 0
                                  ? "${widget.user.name!}, ${widget.ageYears}th"
                                  : widget.user.name!,
                              style: textPrimaryStyle.copyWith(
                                fontSize: 17,
                                fontWeight: semibold,
                              ),
                            ),
                            widget.user.gender == 'male' ?
                            Image.asset(
                              'assets/icon_male_white.png',
                              width: 18,
                              height: 18,
                            ): widget.user.gender == 'female' ?
                            Image.asset(
                              'assets/icon_female_white.png',
                              width: 18,
                              height: 18,
                            ): Container(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        const SizedBox(
                          height: 12,
                        ),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          child: Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: widget.user.ability!
                                  .map(
                                      (ability) => skills(ability.skills![0].name!))
                                  .toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return content();
  }
}