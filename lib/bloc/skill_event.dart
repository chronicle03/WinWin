part of 'skill_bloc.dart';

abstract class SkillEvent {}

class SkillPostCreateEvent extends SkillEvent {
  final String name;

  SkillPostCreateEvent(this.name);
}

class GetSkillEvent extends SkillEvent {}
