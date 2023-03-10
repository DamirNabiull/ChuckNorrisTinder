import 'package:chuck_norris_tinder/ChuckApi/Models/chuck.dart';
import 'package:flutter/material.dart';

class TinderCard extends StatelessWidget {
  final FadeInImage image;
  final Future<Chuck> chuck;

  const TinderCard({super.key, required this.chuck, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 550,
                    width: MediaQuery.of(context).size.width - 50,
                    child: FittedBox(fit: BoxFit.fill, child: image),
                  ),
                  const Spacer(),
                  FutureBuilder<Chuck>(
                      future: chuck,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width - 50,
                                height: MediaQuery.of(context).size.height / 3,
                                child: Text(
                                  snapshot.data!.jokeValue,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              )
                            : const CircularProgressIndicator();
                      }),
                  const Spacer()
                ],
              ),
            )));
  }
}
