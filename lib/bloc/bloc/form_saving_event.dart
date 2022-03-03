part of 'form_saving_bloc.dart';

abstract class FormSavingEvent {}

class UserNameChanged extends FormSavingEvent {
  final String userName;
  UserNameChanged(this.userName);
}

class BabyPrematureChanged extends FormSavingEvent {
  final int babyPremature;
  BabyPrematureChanged(this.babyPremature);
}

class BabyRelationshipChanged extends FormSavingEvent {
  final String babyRelationship;
  BabyRelationshipChanged(this.babyRelationship);
}

class NoteChanged extends FormSavingEvent {
  final String note;
  NoteChanged(this.note);
}

class SubmitForm extends FormSavingEvent {}

class SubmitFormSleeping extends FormSavingEvent {
  final Duration duration;
  final String color;
  SubmitFormSleeping(this.duration, this.color);
}

class SubmitFormSaveBaby extends FormSavingEvent {
  final String babyBirthDay;
  final String babySex;
  final String babyImagePath;
  SubmitFormSaveBaby(this.babyBirthDay, this.babySex, this.babyImagePath);
}
