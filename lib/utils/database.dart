import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('hr_list');

class Database {
  static String? userUid;

  static Future<void> addItem({
    required String title,
    required String description,
    required String city,
    required String writerEmail,
  }) async {
    DocumentReference documentReferencer =
    _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "city" : city,
      "writer": userUid,
      "writerEmail": writerEmail,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String city,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
    _mainCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "city": city,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }


  static Stream<QuerySnapshot> readItems() {
    CollectionReference hrListCollection =
    _mainCollection;

    return hrListCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
    _mainCollection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}

