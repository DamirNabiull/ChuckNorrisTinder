import 'dart:convert';
import 'package:chuck_norris_tinder/ChuckApi/Models/chuck.dart';
import 'package:http/http.dart' as http;

class ApiClient{
  final client = http.Client();
  final Uri apiUrl;

  ApiClient(this.apiUrl);

  Future<Chuck?> getData() async {
    Chuck? chuck;
    try {
      var response = await client.get(apiUrl);
      chuck = Chuck.fromJson(jsonDecode(response.body));
    }
    catch (e) {
      chuck = null;
    }

    return chuck;
  }
}