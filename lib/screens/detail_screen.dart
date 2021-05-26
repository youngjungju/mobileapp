import 'package:flutter/material.dart';
import 'package:mobileapp/utils/database.dart';
import 'edit_screen.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String documentId;

  DetailScreen({
    required this.title,
    required this.description,
    required this.documentId,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
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
                    builder: (context) => EditScreen(
                      currentTitle: widget.title,
                      currentDescription: widget.description,
                      documentId: widget.documentId,
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
                    Container(child: Text(widget.title)),
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
                    Container(child: Text(widget.description)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
