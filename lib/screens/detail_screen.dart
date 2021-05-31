import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/utils/database.dart';
import 'edit_screen.dart';

class DetailScreen extends StatefulWidget {
  //TODO: ID만 받아와서 직접 참조하기
  final String documentId;

  DetailScreen({
    required this.documentId,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('hr_list').doc(widget.documentId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            var noteInfo = snapshot.data;
            String docID = widget.documentId;
            String title = noteInfo?.get('title');
            String description = noteInfo?.get('description');
            return Scaffold(
              backgroundColor: Colors.indigo,
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.indigo,
                  title: Text("인재 정보"),
                  centerTitle: true,
                  actions: [
                    //TODO: _isMine? 버튼 띄워주기 : 띄워주지 말기
                    IconButton(
                        onPressed: () {
                          print("Edit Button");
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditScreen(
                                  //TODO: ID만 넘겨주기
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
                  child: Column(
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
                              'Title',
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
                              'Description',
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
