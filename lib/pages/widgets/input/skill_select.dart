import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:winwin/data/models/user_model.dart';
import 'package:winwin/pages/constant.dart';

class SkillSelect extends StatefulWidget {
  final UserModel user;
  List<String> userSkills;
  final Function(List<String>) onUserSkillsChanged;

  SkillSelect(this.user, this.userSkills, this.onUserSkillsChanged, {super.key});
  @override
  _SkillSelectState createState() => _SkillSelectState();
}

class _SkillSelectState extends State<SkillSelect> {
  List<String> selectedSkills = [];

  List<String> skills = [
    'coding',
    'math',
    'english',
    'public speaking',
    'communication',
    'driving',
    'desain',
    'ballet',
    'dance',
    'music',
    'football'
  ];

  @override
  void initState() {
    super.initState();
    print("userSkills: ${widget.user.ability![0].skills![0].name}");
    
    for (var entry in widget.user.ability!) {
      int index = 0; // Ganti dengan indeks yang sesuai
      if (entry.skills != null && index < entry.skills!.length) {
        widget.userSkills.add(entry.skills![index].name!);
      }
    }
    selectedSkills = selectedSkills + widget.userSkills;
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

  void _showSkillDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Skills'),
          content: Container(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: skills.map((skill) {
                  return SkillCheckbox(
                    skill: skill,
                    isChecked: selectedSkills.contains(skill),
                    onChanged: toggleSkill,
                  );
                }).toList(),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      // Dialog dismissed
      print('Selected skills: $selectedSkills');
    });
  }

  @override
  Widget build(BuildContext context) {
    // userSkills = widget.user.ability?.skills;
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
