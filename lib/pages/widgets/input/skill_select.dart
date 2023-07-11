import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/pages/constant.dart';

import '../../../bloc/skill_bloc.dart';
import '../../../data/models/skill_model.dart';
import '../../../data/singleton/user_data.dart';

class SkillSelect extends StatefulWidget {
  List<String> userSkills;
  final Function(List<String>) onUserSkillsChanged;

  SkillSelect(this.userSkills, this.onUserSkillsChanged, {super.key});
  @override
  _SkillSelectState createState() => _SkillSelectState();
}

class _SkillSelectState extends State<SkillSelect> {

  late SkillBloc _skillBloc;
  TextEditingController createSkillController = TextEditingController(text: '');
  ScrollController _scrollController = ScrollController();

  UserModel? user = UserData.user;
  List<String> selectedSkills = [];
  List<SkillModel> skills = [];
  List<SkillModel> skillCreated = [];

  @override
  void initState() {
    super.initState();
    UserData.loadUser();
    // print("userSkills: ${widget.user.ability![0].skills![0].name}");
    if (user != null){
      for (var entry in user!.ability!) {
        int index = 0; // Ganti dengan indeks yang sesuai
        if (entry.skills != null && index < entry.skills!.length) {
          widget.userSkills.add(entry.skills![index].name!);
        }
      }
      selectedSkills = selectedSkills + widget.userSkills;
    }
    skills = SkillBloc.skillList + skillCreated;
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
                    Expanded(
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                controller: createSkillController,
                                style: TextStyle(color: Colors.blue, fontSize: 11),
                                decoration: const InputDecoration.collapsed(
                                  hintText: "add another skill",
                                  hintStyle: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                String newSkill = createSkillController.text;
                                if (newSkill.isNotEmpty) {
                                  setState(() {
                                    skillCreated.add(SkillModel(name: newSkill));
                                    skills = SkillBloc.skillList + skillCreated;
                                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                                      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

                                    });
                                    skills = SkillBloc.skillList + skillCreated;
                                  });
                                }
                                createSkillController.clear();
                              },
                              icon: Icon(Icons.add_circle),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
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
      print('Selected skills: $selectedSkills');
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

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 50,
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Optional: Set the button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Select Skills'),
                onPressed: _showSkillDialog,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: selectedSkills
                          .map((ability) => skills(ability))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
