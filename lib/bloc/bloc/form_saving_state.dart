part of 'form_saving_bloc.dart';

class FormSavingState {
  final String userName;
  bool get isValidUsername => userName.isNotEmpty;

  final int babyPremature;
  bool get isValidbabyPremature => babyPremature.isEven;
  final String babyRelationship;
  final String note;
  bool get isValidbabyRelationship => babyRelationship.isNotEmpty;

  final FormSubmissionStatus formSubmissionStatus;
  FormSavingState(
      {this.babyPremature = 1,
      this.babyRelationship = '',
      this.userName = '',
      this.note = '',
      this.formSubmissionStatus = const InitialFormStatus()});
  FormSavingState copyWith({
    String? userName,
    int? babyPremature,
    String? babyRelationship,
    String? note,
    FormSubmissionStatus? formSubmissionStatus,
  }) {
    return FormSavingState(
      userName: userName ?? this.userName,
      babyPremature: babyPremature ?? this.babyPremature,
      babyRelationship: babyRelationship ?? this.babyRelationship,
      note: note ?? this.note,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }
}
