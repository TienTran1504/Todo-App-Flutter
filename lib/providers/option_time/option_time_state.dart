import 'package:equatable/equatable.dart';

class OptionTimeState extends Equatable {
  final int option;

  const OptionTimeState({
    required this.option,
  });

  const OptionTimeState.initial({
    this.option = 0,
  });

  OptionTimeState copyWith({
    int? option,
  }) {
    return OptionTimeState(
      option: option ?? this.option,
    );
  }

  @override
  List<Object?> get props => [option];
}
