import 'package:chuck_norris_tinder/ChuckApi/Models/chuck.dart';
import 'package:chuck_norris_tinder/Models/tinder_card.dart';
import 'package:chuck_norris_tinder/favorites_screen.dart';
import 'package:chuck_norris_tinder/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';
import 'package:swipe_cards/swipe_cards.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 2; i++) {
      _addChuckCard();
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  void _addChuckCard() {
    var current = ref.read(apiProvider).getData();
    _swipeItems.add(SwipeItem(
        content: TinderCard(
          chuck: current,
          image: ref.read(imageProvider).getFadeInImage(),
        ),
        nopeAction: _addCard,
        likeAction: () => _addCardAndSave(current)));
  }

  void _addCard() {
    setState(() {
      _addChuckCard();
    });
  }

  void _addCardAndSave(Future<Chuck> chuck) {
    _addCard();
    ref.read(fireStoreProvider).saveJoke(chuck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("main-title".i18n()),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.favorite,
              ),
              tooltip: "go-next-tooltip".i18n(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const FavoritesScreen();
                  },
                ));
              },
            ),
          ],
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
                    ),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(apiProvider).openBrowser();
                    },
                    icon: const Icon(
                      Icons.language,
                      color: Colors.blue,
                      size: 35,
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
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
              const Spacer()
            ],
          )),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
