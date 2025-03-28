import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jokesapp/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jokesapp/jokes_model.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(JokeAdapter());
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class JokeAdapter extends TypeAdapter<Joke> {
  @override
  final int typeId = 0;

  @override
  Joke read(BinaryReader reader) {
    return Joke(
      setup: reader.read(),
      punchline: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Joke obj) {
    writer.write(obj.setup);
    writer.write(obj.punchline);
  }
}
