import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jokesapp/models/jokes_model.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '${jokeState.joke!.setup}, ${jokeState.joke!.punchline}',
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  const Text('No joke available'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
