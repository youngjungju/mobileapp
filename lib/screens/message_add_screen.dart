import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobileapp/widgets/message_add_item_form.dart';

class MessageAddScreen extends StatelessWidget {
  MessageAddScreen({Key? key, required User user, required String receiver})
      : _user = user, _receiver = receiver,
        super(key: key);

  final User _user;
  final String _receiver;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _companyFocusNode = FocusNode();

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
          title: Text('메세지 전송'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: MessageAddItemForm(
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              companyFocusNode: _companyFocusNode,
              user: _user,
              receiver: _receiver
            ),
          ),
        ),
      ),
    );
  }
}
