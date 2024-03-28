import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberOfDaysCubit extends Cubit<int> {
  NumberOfDaysCubit() : super(0);

  void updateNumberOfDays(int numberOfDays, bool areDaysConsecutive) {
    if (areDaysConsecutive) {
      emit(numberOfDays);
    } else {
      // Handle the case where the days are not consecutive
      // For example, you might want to reset the progress bar
      emit(0);
    }
  }
}
