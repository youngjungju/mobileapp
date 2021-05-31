import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobileapp/widgets/add_item_form.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.indigo,
          title: Text('추가'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddItemForm(
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              user: _user,
            ),
          ),
        ),
      ),
    );
  }
}
