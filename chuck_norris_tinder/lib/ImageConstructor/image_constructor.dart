import 'dart:math';
import 'package:flutter/cupertino.dart';

class ImageConstructor {
  final _random = Random();
  final String _placeholder = 'assets/chuck_loading.jpeg';
  final List<String> _urls = [
    "https://kadet39.ru/wp-content/uploads/8/5/2/8523ea1473b95c9b1a44aa101f29d9cb.jpeg",
    "https://cdn.nwmgroups.hu/s/img/i/2003/20200310cguck-norris.jpg",
    "https://cdn.newsbusters.org/pictures/picture-239-1409700720.jpg"
  ];

  FadeInImage getFadeInImage() {
    var index = _random.nextInt(_urls.length);

    return FadeInImage.assetNetwork(
        placeholder: _placeholder, image: _urls[index]);
  }
}
