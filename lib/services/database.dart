import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;

  DatabaseServices({this.uid});

  //collection reference
  CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //get Brews firestore stream
  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }
}
