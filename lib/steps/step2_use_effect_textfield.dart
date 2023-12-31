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

class HomePage extends HookWidget {
  const HomePage({super.key,});

  @override
  Widget build(BuildContext context) {

    final controller = useTextEditingController();
    final text = useState("");

    useEffect(() {
      controller.addListener(() {
        text.value = controller.text;
      });
      return null;
    }, [controller]);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('You typed: ${text.value}'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
        ],
      ),
    );
  }
}
