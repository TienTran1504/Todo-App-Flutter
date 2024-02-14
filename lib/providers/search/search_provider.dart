import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/search/search.dart';
import 'package:todoapp/providers/search/search_notifier.dart';

final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});
