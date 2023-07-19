import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/user_model.dart';
import '../constant.dart';
import '../widgets/avatar_custom.dart';

class SummaryProfileWidget extends StatefulWidget {
  final UserModel userModel;

  const SummaryProfileWidget({required this.userModel});

  @override
  State<SummaryProfileWidget> createState() => _SummaryProfileWidgetState();
}

class _SummaryProfileWidgetState extends State<SummaryProfileWidget> {
  ageCount(String birthdate) {
    DateTime dateOfBirth = DateFormat('yyyy-MM-dd').parse(birthdate);
    DateTime now = DateTime.now();
    Duration ageDuration = now.difference(dateOfBirth);
    int ageYears = ageDuration.inDays ~/ 365;

    return ageYears;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          widget.userModel.profilePhotoPath != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              baseUrlImage + widget.userModel.profilePhotoPath!,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 400,
            ),
          )
              : Container(
                margin: EdgeInsets.only(bottom: 150),
                child: Center(
                  child: AvatarCustom(
                    user: widget.userModel, width: 200, height: 200, color: appBarColor, fontSize: 60,),
                ),
              ),
          Container(
            margin: EdgeInsets.only(top: 360),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/background.png',
                fit: BoxFit.fill,
                height: 410,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 400),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ageCount(widget.userModel.birthdate!) != 0
                        ? Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.userModel.name!}, ${ageCount(widget.userModel.birthdate!)}th',
                        style: textButtonTextStyle.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                        : Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.userModel.name!}',
                        style: textButtonTextStyle.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    widget.userModel.gender == 'male'
                        ? Image.asset(
                      'assets/icon_male.png',
                      height: 18,
                    )
                        : widget.userModel.gender == 'female'
                        ? Image.asset(
                      'assets/icon_female.png',
                      height: 18,
                    )
                        : const SizedBox(),
                  ],
                ),
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
                          widget.userModel.location != null
                              ? Text(
                            '${widget.userModel.location!}',
                            style: iconTextStyle.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                              : Text(
                            "Indonesia",
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: widget.userModel.bio != null
                      ? Text(
                    widget.userModel.bio!,
                    style: textColor2TextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                  )
                      : Text(
                    "no bio",
                    style: textColor2TextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.userModel.ability!.length != 0
                    ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: widget.userModel.ability!
                          .map((ability) =>
                          skills(ability.skills![0].name!)).toList(),
                  ),
                ),
                    )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}