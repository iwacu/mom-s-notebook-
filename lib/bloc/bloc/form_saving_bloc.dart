import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:momnotebook/bloc/form_submission/form_sub.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/babyTask.dart';
import 'package:momnotebook/models/user.dart';
import 'package:momnotebook/services/database/database_helper.dart';

part 'form_saving_event.dart';
part 'form_saving_state.dart';

class FormSavingBloc extends Bloc<FormSavingEvent, FormSavingState> {
  FormSavingBloc() : super(FormSavingState());
  @override
  Stream<FormSavingState> mapEventToState(
    FormSavingEvent event,
  ) async* {
    if (event is UserNameChanged) {
      yield state.copyWith(userName: event.userName);
    } else if (event is BabyPrematureChanged) {
      yield state.copyWith(babyPremature: event.babyPremature);
    } else if (event is BabyRelationshipChanged) {
      yield state.copyWith(babyRelationship: event.babyRelationship);
    } else if (event is NoteChanged) {
      yield state.copyWith(note: event.note);
    } else if (event is SubmitForm) {
      yield state.copyWith(formSubmissionStatus: FormSubmitting());
      //  read user from dbs
      var user = await DatabaseHelper.instance.getUser();
      if (user.object == null) {
        print('user object null');
        // save user to database
        var ui = await DatabaseHelper.instance
            .addUser(User(name: state.userName, babyId: 1));
        print('codecodeocodecoe $ui');
        yield state.copyWith(
            formSubmissionStatus:
                SubmissionSuccess(message: 'User added successfully'));
      } else {
        yield state.copyWith(
            formSubmissionStatus:
                SubmissionSuccess(message: 'User exist already'));
      }
    } else if (event is SubmitFormSaveBaby) {
      yield state.copyWith(formSubmissionStatus: FormSubmitting());
      await DatabaseHelper.instance.addBaby(Baby(
          picture: event.babyImagePath,
          babySex: event.babySex,
          name: state.userName,
          birthDay: event.babyBirthDay,
          premature: state.babyPremature,
          relationship: state.babyRelationship));
      var user = await DatabaseHelper.instance.getUser();
      var baby = await DatabaseHelper.instance.getBaby(user.object!.babyId);

      yield state.copyWith(
          formSubmissionStatus: SubmissionSuccessBaby(
              message: 'Baby added successfully', baby: baby.object!));
      // print(
      //     'relationship ${state.babyRelationship} ::: premature ${state.babyPremature} ::: sex ${event.babySex} ::: name ${state.userName} ::: birthday ${event.babyBirthDay} ');
    } else if (event is SubmitFormSleeping) {
      yield state.copyWith(formSubmissionStatus: FormSubmitting());
      // await DatabaseHelper.instance.addBabyTask(BabyTask(
      //     babyId: 1,
      //     taskName: 'sleeping',
      //     timeStamp: DateTime.now().toString(),
      //     note: state.note,
      //     resumeTime: '',
      //     qtyFood: '',
      //     qtyLeft: '',
      //     qtyRight: '',
      //     qtyFeeder: '',
      //     leftBreast: 1,
      //     rightBreast: 1,
      //     groupFood: '',
      //     pee: 1,
      //     poo: 1,
      //     durationH: event.duration.inHours.toString(),
      //     durationM: event.duration.inMinutes.toString(),
      //     durationS: event.duration.inSeconds.toString(),
      //     color: event.color));
      HomePageCubit().getBabyTasks();
      yield state.copyWith(
          formSubmissionStatus:
              SubmissionSuccess(message: 'added successfully'));
      // print(
      //     'notes ==> ${state.note} ::sleeping ==> H ${event.duration.inHours}: M ${event.duration.inMinutes}: S ${event.duration.inSeconds}');
    }
  }
}
