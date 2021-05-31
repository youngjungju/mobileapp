import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_screen.dart';

class DetailScreen extends StatefulWidget {
  final String documentId;
  final User _user;

  const DetailScreen({Key? key, required User user, required String documentId})
      : _user = user,
        documentId = documentId,
        super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late User _user;
  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('hr_list')
            .doc(widget.documentId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            var noteInfo = snapshot.data;
            String docID = widget.documentId;
            String title = noteInfo?.get('title');
            String description = noteInfo?.get('description');
            String writer = noteInfo?.get('writer');
            return Scaffold(
              backgroundColor: Colors.indigo,
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.indigo,
                  title: Text("인재 정보"),
                  centerTitle: true,
                  actions: [
                    if (_user.uid == writer)
                      IconButton(
                          onPressed: () {
                            print("Edit Button");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditScreen(
                                currentTitle: title,
                                currentDescription: description,
                                documentId: docID,
                              ),
                            ));
                          },
                          icon: Icon(Icons.edit)),
                  ]),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 20.0,
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          bottom: 24.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24.0),
                            Text(
                              '제목',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(child: Text(title)),
                            SizedBox(height: 24.0),
                            Text(
                              '자기소개서',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(child: Text(description)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.orange,
              ),
            ),
          );
        });
  }
}
