import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jokesapp/models/jokes_model.dart';

class JokeNotifier extends StateNotifier<JokeState> {
  JokeNotifier() : super(JokeState()) {
    _fetchJokeFromCache();
  }

  Future<void> fetchJoke() async {
    state = state.copyWith(isLoading: true, hasError: false);

    try {
      final response = await http
          .get(Uri.parse('https://official-joke-api.appspot.com/jokes/random'));
      if (response.statusCode == 200) {
        final joke = Joke.fromJson(jsonDecode(response.body));
        _storeJokeToCache(joke);
        state = state.copyWith(joke: joke, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false, hasError: true);
      }
    } catch (_) {
      state = state.copyWith(isLoading: false, hasError: true);
    }
  }

  Future<void> _fetchJokeFromCache() async {
    final box = await Hive.openBox<Joke>('jokes');
    final joke = box.getAt(0);
    state = state.copyWith(joke: joke);
  }

  Future<void> _storeJokeToCache(Joke joke) async {
    final box = await Hive.openBox<Joke>('jokes');
    await box.put(0, joke);
  }
}
