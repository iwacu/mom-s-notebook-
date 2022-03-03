import 'package:bloc/bloc.dart';

part 'date_changer_state.dart';

class DateChangerCubit extends Cubit<DateChangerState> {
  final DateTime dateTime;
  DateChangerCubit({required this.dateTime})
      : super(DateChangerState(dateTime: dateTime));

  void changeDatetimeYear(int year) =>
      emit(DateChangerState(dateTime: DateTime(year)));

  void changeDay(DateTime time) => emit(DateChangerState(dateTime: time));
}
