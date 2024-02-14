import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final String search;

  const SearchState({
    required this.search,
  });

  const SearchState.initial({
    this.search = '',
  });

  SearchState copyWith({
    String? search,
  }) {
    return SearchState(
      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props => [search];
}
