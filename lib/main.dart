import 'package:flutter/material.dart';
import 'package:selpar_selcuk_yamann_223301109/sayfalar/Anasayfa.dart';
import 'package:firebase_core/firebase_core.dart';
import 'arayuz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBqaJdMXJi1SXRdUHZEXNDcHLxvtGqRViA",
      authDomain: "selcukdeneme-93157.firebaseapp.com",
      projectId: "selcukdeneme-93157",
      storageBucket: "selcukdeneme-93157.appspot.com",
      messagingSenderId: "836105365839",
      appId: "1:836105365839:web:2c79b681fe5d8d8dd5fd3a",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {},
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Arayuz(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late final String title3 = 'selcukbaba';

  void _incrementCounter() {
    setState(() {
      _counter += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              '$_counter',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}