import 'package:chuck_norris_tinder/ChuckApi/Models/chuck.dart';
import 'package:chuck_norris_tinder/ChuckApi/client.dart';
import 'package:chuck_norris_tinder/ImageConstructor/image_constructor.dart';
import 'package:chuck_norris_tinder/Models/tinder_card.dart';
import 'package:flutter/material.dart';

void main() {
  // var apiClient = ApiClient(Uri.https('api.chucknorris.io', 'jokes/random'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final _imageConstructor = ImageConstructor();
  final _chuck = Chuck('jokeUrl', 'jokeId', 'jokeValue');
  late FadeInImage _image;
  late TinderCard _card;
  int _counter = 0;

  _MyHomePageState(){
    _image = _imageConstructor.getFadeInImage();
    _card = TinderCard(chuck: _chuck, image: _image);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _image = _imageConstructor.getFadeInImage();
      _card = TinderCard(chuck: _chuck, image: _image);
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
            _card,
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
