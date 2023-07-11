import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/skill_model.dart';
import '../data/repository/skill_repository.dart';

part 'skill_event.dart';
part 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {

  static List<SkillModel> skillList = [];
  final SkillRepositoryImpl skillRepositoryImpl;

  SkillBloc(this.skillRepositoryImpl) : super(SkillInitial()) {
    on<SkillEvent>((event, emit) async {
      if (event is GetSkillEvent){
        print("start skill Bloc");
        emit(SkillLoadingState());
        try{
          await Future.delayed(Duration.zero, () async {
            skillList.clear();
            skillList = await skillRepositoryImpl.getSkills();
          });
          print("skillList: ${skillList.first}");
          emit(GetSkillLoaded(skillList));
        }catch (e) {
          print("error: $e");
          emit(SkillErrorState(e.toString().replaceAll('Exception: ', '')));
        }
      }
    });
  }
}
