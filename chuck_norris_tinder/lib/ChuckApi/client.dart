import 'dart:convert';
import 'package:chuck_norris_tinder/ChuckApi/Models/chuck.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ApiClient {
  final client = http.Client();
  final Uri apiUrl;
  late Chuck _chuck;

  ApiClient(this.apiUrl);

  Future<Chuck> getData() async {
    Chuck chuck;
    try {
      var response = await client.get(apiUrl);
      chuck = Chuck.fromJson(jsonDecode(response.body));
      _chuck = chuck;
    } catch (e) {
      chuck = Chuck("get Api error", "get Api error");
    }

    return chuck;
  }

  Future<void> openBrowser() async {
    if (!await launchUrl(Uri.parse(_chuck.jokeUrl))) {
      throw Exception('Could not launch $_chuck.jokeUrl');
    }
  }
}
