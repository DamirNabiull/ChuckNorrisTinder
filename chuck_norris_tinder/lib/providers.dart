import 'package:chuck_norris_tinder/ChuckApi/client.dart';
import 'package:chuck_norris_tinder/ImageConstructor/image_constructor.dart';
import 'package:chuck_norris_tinder/Models/constants.dart';
import 'package:chuck_norris_tinder/Network/connectivity_provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod/riverpod.dart';
import 'package:chuck_norris_tinder/Firebase/client.dart';

final fireStoreProvider = Provider((ref) => FireStoreClient());
final apiProvider = Provider((ref) => ApiClient(Uri.https(apiHost, apiRoute)));
final imageProvider = Provider((ref) => ImageConstructor());
final connectionProvider = NotifierProvider<ConnectivityProvider, bool>(ConnectivityProvider.new);