import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_disposer/stream_disposer.dart';

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
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Stream Disposer Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with StreamDisposer {
  int _counter1 = 0;
  int _counter2 = 0;
  int _counter3 = 0;

  @override
  void initState() {
    super.initState();

    addSubscriptions([
      listenCountStream(Duration(seconds: 1),
              (counter) => setState(() => _counter1 = counter)),
      listenCountStream(Duration(seconds: 2),
              (counter) => setState(() => _counter2 = counter)),
      listenCountStream(Duration(seconds: 3),
              (counter) => setState(() => _counter3 = counter)),
    ]);
  }

  @override
  void dispose() {
    super.clear();

    super.dispose();
  }

  StreamSubscription<int> listenCountStream(
      Duration duration,
      Function(int) listener,
      ) {
    final counterStream = Stream<int>.periodic(duration, (int i) => i);
    final result = counterStream.listen((int counter) => listener(counter));
    return result;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('counter1: $_counter1'),
          Text('counter2: $_counter2'),
          Text('counter3: $_counter3'),
        ],
      ),
    ),
  );
}
