import 'package:momnotebook/models/baby.dart';

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  final String message;

  SubmissionSuccess({required this.message});
}

class SubmissionSuccessBaby extends FormSubmissionStatus {
  final String message;
  final Baby baby;
  SubmissionSuccessBaby({required this.message, required this.baby});
}

class SubmissionFailed extends FormSubmissionStatus {
  final String exception;
  SubmissionFailed({required this.exception});
}
