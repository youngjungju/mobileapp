import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection("message");

class Message{
  static Future<void> addItem({
    required String title,
    required String description,
    required String company,
    required String writer,
    required String receiver,
  }) async {
    DocumentReference documentReferencer =
    _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "company" : company,
      "writer": writer,
      "receiver": receiver,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Added to the Message"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String company,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
    _mainCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "company": company,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the Message"))
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
        .whenComplete(() => print('Note item deleted from the Message'))
        .catchError((e) => print(e));
  }
}

