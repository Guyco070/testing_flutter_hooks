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
const imageHeight = 300.0;

extension Normalize on num {
  num normalized(
    num selfRangeMin,
    num selfRangeMax, [
      num normalizedRangeMin = 0.0,
      num normalizedRangeMax = 1.0,
    ]) => (normalizedRangeMax - normalizedRangeMin) *
          ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizedRangeMin;
}

class HomePage extends HookWidget {
  const HomePage({super.key,});

  @override
  Widget build(BuildContext context) {
    final opaacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0
    );
    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0
    );
    final controller = useScrollController();
    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(imageHeight - controller.offset, 0.0);
        final normalized = newOpacity.normalized(0.0, imageHeight).toDouble();
        opaacity.value = normalized;
        size.value = normalized;
       });
       return null;
    }, [controller]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: size,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: opaacity,
              child: Image.network(
                url,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: 100, 
              itemBuilder: (context, index) => ListTile(
              title: Text("Person ${index + 1}"),
            )),
          )
        ],
      )
    );
  }
}
