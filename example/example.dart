import 'package:flutter/material.dart';
import 'package:flutter_reanimated/flutter_reanimated.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ShareValue<double> _width;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _width = ShareValue(controller: _controller, initialValue: 100);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    _width.springTo(target: _counter % 2 == 0 ? 100 : 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Reanimated'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LayoutAnimated(
              child: Text(
                'You have pushed the button this many times:',
              ),
            ),
            LayoutAnimated(
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            AnimatedBuilder(
              animation: _width.animation,
              builder: (context, child) {
                return Container(
                  width: _width.value,
                  height: 100,
                  color: Colors.red,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
