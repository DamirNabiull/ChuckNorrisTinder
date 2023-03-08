import 'package:chuck_norris_tinder/ChuckApi/Models/chuck.dart';
import 'package:flutter/material.dart';

class TinderCard extends StatelessWidget {
  final FadeInImage image;
  final Chuck chuck;

  const TinderCard({
    super.key,
    required this.chuck,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: image,
    );
  }
}