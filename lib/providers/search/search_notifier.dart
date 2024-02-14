import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/search/search.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(const SearchState.initial());

  void setSearch(String search) {
    state = state.copyWith(search: search);
  }
}
