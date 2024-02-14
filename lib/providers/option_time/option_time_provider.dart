import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/option_time/option_time.dart';
import 'package:todoapp/providers/option_time/option_time_notifier.dart';

final optionProvider =
    StateNotifierProvider<OptionTimeNotifier, OptionTimeState>((ref) {
  return OptionTimeNotifier();
});
