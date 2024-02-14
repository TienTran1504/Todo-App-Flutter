import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/option_time/option_time.dart';

class OptionTimeNotifier extends StateNotifier<OptionTimeState> {
  OptionTimeNotifier() : super(const OptionTimeState.initial());

  void setOption(int option) {
    state = state.copyWith(option: option);
  }
}
