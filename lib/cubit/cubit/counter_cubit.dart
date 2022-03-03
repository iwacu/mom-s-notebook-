import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final int counter;
  CounterCubit(this.counter)
      : super(CounterState(
          countValue: counter == 0 ? 0 : counter,
        ));

  void increment() => emit(CounterState(countValue: state.countValue + 1));
  void decrement() => emit(CounterState(
      countValue: state.countValue == 0 ? 0 : state.countValue - 1));
}
