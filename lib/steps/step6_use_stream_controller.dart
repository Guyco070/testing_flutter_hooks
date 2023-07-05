import 'dart:async';
import 'dart:math';

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
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}

const url = "https://my.alfred.edu/zoom/_images/foster-lake.jpg";

class HomePage extends HookWidget {
  const HomePage({super.key,});

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;

    controller = useStreamController<double>(
      onListen: () {
        controller.sink.add(0.0);
      });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: StreamBuilder<double>(
        stream: controller.stream,
        builder: (context, snapshot) {
          final rotation = snapshot.data ?? 0;
          return GestureDetector(
            onTap: (){
              controller.sink.add(rotation + 10);
            },
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(rotation / 360),
              child: Center(
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }
      )
    );
  }
}
