import 'package:chuck_norris_tinder/ChuckApi/client.dart';
import 'package:chuck_norris_tinder/ImageConstructor/image_constructor.dart';
import 'package:chuck_norris_tinder/Models/constants.dart';
import 'package:chuck_norris_tinder/Models/tinder_card.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'ChuckApi/Models/chuck.dart';

ApiClient apiClient = ApiClient(Uri.https(apiHost, apiRoute));
ImageConstructor chuckImageConstructor = ImageConstructor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  late Future<Chuck> _chuck;

  _MyHomePageState() {
    for (int i = 0; i < 2; i++) {
      _addChuckCard();
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  void _addChuckCard() {
    _swipeItems.add(SwipeItem(
        content: TinderCard(
          chuck: apiClient.getData(),
          image: chuckImageConstructor.getFadeInImage(),
        ),
        nopeAction: _addCard,
        likeAction: _addCard));
  }

  void _addCard() {
    setState(() {
      _addChuckCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Chuck Tinder")),
        ),
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
              Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                      child: SwipeCards(
                        matchEngine: _matchEngine,
                        itemBuilder: (BuildContext context, int index) {
                          return _swipeItems[index].content;
                        },
                        onStackFinished: _addCard,
                      ),
                    )),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      _matchEngine.currentItem!.nope();
                    },
                    icon: const Icon(
                      Icons.disabled_by_default,
                      color: Colors.black,
                      size: 35,
                      semanticLabel: 'Like',
                    ),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      _matchEngine.currentItem!.like();
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                      size: 35,
                      semanticLabel: 'Like',
                    ),
                    color: Colors.white,
                  ),
                ],
              )
            ],
          )),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
