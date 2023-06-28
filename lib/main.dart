import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}


extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform
  ]) => map(
    transform ?? (e) => e,
  ).where((element) => element != null).cast();
}

void testIt() {
  final values = [1, 2, null, 3,];
  print(CompactMap(values).compactMap()); // non null values
  print(CompactMap(values).compactMap((e) => e == null ? null : "$e YEHHH")); // non null values + replace values
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

    // // testing the compactMap
    // testIt();

    // // will load the image then call build function again 
    // final image = useFuture(
    //   NetworkAssetBundle(Uri.parse(url))
    //   .load(url)
    //   .then((data) => data.buffer.asUint8List())
    //   .then((data) => Image.memory(data))
    // );

    // to avoid rebuilding on every load of the image (ignoring second build)
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(url))
      .load(url)
      .then((data) => data.buffer.asUint8List())
      .then((data) => Image.memory(data))
    );

    final snapshot = useFuture(future);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          // image.data // can be null
          snapshot.data
        ].compactMap().toList(),
      )
    );
  }
}
