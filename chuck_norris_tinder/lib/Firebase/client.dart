import 'package:chuck_norris_tinder/ChuckApi/Models/chuck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreClient {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late final CollectionReference<Map<String, dynamic>> _jokesCollection;

  FireStoreClient() {
    _jokesCollection = db.collection("jokes");
  }

  Future saveJoke(Future<Chuck> chuckFuture) async {
    Chuck chuck = await chuckFuture;
    final jokeRef = _jokesCollection.doc();
    await jokeRef.set(chuck.toJson());
  }

  Stream<List<Chuck>> getAllJokes() {
    return _jokesCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Chuck.fromJson(doc.data())).toList());
  }
}
