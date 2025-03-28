import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jokesapp/jokes_model.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jokeState = ref.watch(jokeProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Jokes App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(jokeProvider.notifier).fetchJoke();
                },
                child: const Text('Show a new joke'),
              ),
              const SizedBox(height: 20),
              if (jokeState.isLoading)
                const CircularProgressIndicator()
              else if (jokeState.hasError)
                const Text('Error fetching joke')
              else if (jokeState.joke != null)
                Text(
                    '${jokeState.joke!.setup}, \n ${jokeState.joke!.punchline}')
              else
                const Text('No joke available'),
            ],
          ),
        ),
      ),
    );
  }
}
