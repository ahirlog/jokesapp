import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jokesapp/providers/joke_notifier.dart';

final jokeProvider =
    StateNotifierProvider<JokeNotifier, JokeState>((ref) => JokeNotifier());

/// state class
class JokeState {
  final Joke? joke;
  final bool isLoading;
  final bool hasError;

  JokeState({
    this.joke,
    this.isLoading = false,
    this.hasError = false,
  });

  JokeState copyWith({
    Joke? joke,
    bool? isLoading,
    bool? hasError,
  }) {
    return JokeState(
      joke: joke ?? this.joke,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}

/// data class
class Joke {
  final String? type;
  final String setup;
  final String punchline;
  final int? id;

  Joke({
    this.type,
    required this.setup,
    required this.punchline,
    this.id,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      type: json['type'],
      setup: json['setup'],
      punchline: json['punchline'],
      id: json['id'],
    );
  }
}
