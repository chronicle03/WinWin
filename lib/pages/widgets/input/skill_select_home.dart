import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/pages/constant.dart';

import '../../../bloc/skill_bloc.dart';
import '../../../data/models/skill_model.dart';
import '../../../data/singleton/user_data.dart';

class SkillSelectHome extends StatefulWidget {
  final Function(List<String>) onUserSkillsChanged;

  SkillSelectHome(this.onUserSkillsChanged, {super.key});
  @override
  _SkillSelectHomeState createState() => _SkillSelectHomeState();
}

class _SkillSelectHomeState extends State<SkillSelectHome> {

  late SkillBloc _skillBloc;
  TextEditingController createSkillController = TextEditingController(text: '');
  ScrollController _scrollController = ScrollController();

  List<String> selectedSkills = [];
  List<SkillModel> skills = [];

  @override
  void initState() {
    super.initState();
    UserData.loadUser();
    // print("userSkills: ${widget.user.ability![0].skills![0].name}");
    skills = SkillBloc.skillList;
    skills.sort((a, b) => a.name!.compareTo(b.name!));

  }

  void toggleSkill(String skill) {
    setState(() {
      if (selectedSkills.contains(skill)) {
        selectedSkills.remove(skill);
      } else {
        selectedSkills.add(skill);
      }
    });
    widget.onUserSkillsChanged(selectedSkills);
  }

  // @override
  // void dispose() {
  //   _skillBloc.close(); // Tutup SkillBloc saat komponen dihancurkan
  //   super.dispose();
  // }

  void _showSkillDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Select Skills'),
              content: Container(
                height: 200,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      ...skills.map((skill) {
                        return SkillCheckbox(
                          skill: skill.name!,
                          isChecked: selectedSkills.contains(skill.name!),
                          onChanged: toggleSkill,
                        );
                      }),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      // Dialog dismissed
      // print('Selected skills: $selectedSkills');
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget skills(String value) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
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

    return InkResponse(
      highlightShape: BoxShape.circle,
      onTap: () {
        _showSkillDialog();
      },
      splashColor: Colors.black.withOpacity(0.1), // Warna efek splash
      radius: 32,
      // borderRadius:
      //     BorderRadius.circular(10), // Membuat tepi menjadi lingkaran
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: -3,
            ),
          ],
        ),
        child: SvgPicture.asset(
          'assets/svg/icon_filter.svg',
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}

class SkillCheckbox extends StatefulWidget {
  final String skill;
  final bool isChecked;
  final ValueChanged<String> onChanged;

  SkillCheckbox({
    required this.skill,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  _SkillCheckboxState createState() => _SkillCheckboxState();
}

class _SkillCheckboxState extends State<SkillCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.skill),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
          widget.onChanged(widget.skill);
        });
      },
    );
  }
}
