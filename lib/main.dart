import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const COUNT = 'Count';
int? counter;
Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void setState(VoidCallback fn) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(COUNT) == null) {
      counter = 0;
    } else {
      counter = prefs.getInt(COUNT)!;
    }

    log(counter.toString());
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
//increment=========================
                ElevatedButton(
                    onPressed: () async {
                      final _sharedPref = await SharedPreferences.getInstance();
                      //log(_sharedPref.getInt(COUNT) as String);
                      setState(() {
                        _sharedPref.setInt(COUNT, counter! + 1);
                      });
                    },
                    child: Row(
                      children: [Icon(Icons.plus_one), Text(' Increment')],
                    )),
//decrement=========================
                ElevatedButton(
                    onPressed: () async {
                      final _sharedPref = await SharedPreferences.getInstance();
                      setState(() {
                        _sharedPref.setInt(COUNT, counter! - 1);
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.exposure_minus_1),
                        Text(' decrement')
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
