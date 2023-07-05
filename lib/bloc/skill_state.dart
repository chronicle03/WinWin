part of 'skill_bloc.dart';

@immutable
abstract class SkillState {}

class SkillInitial extends SkillState {}

class SkillLoadingState extends SkillState {}

class GetSkillLoaded extends SkillState {
  GetSkillLoaded(List<SkillModel> skillList);
}

class SkillErrorState extends SkillState {
  final String code;

  SkillErrorState(this.code);
}
