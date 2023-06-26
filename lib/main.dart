import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}

Stream<String> getTime() => Stream.periodic(
  const Duration(seconds: 1),
  (_) => DateTime.now().toIso8601String(),
);

class HomePage extends HookWidget {
  const HomePage({super.key,});

  @override
  Widget build(BuildContext context) {

    final dateTime = useStream(getTime());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(dateTime.data ?? "Home Page"),
      ),
      body: Container(),
    );
  }
}