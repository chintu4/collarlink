// import 'dart:js';

import 'package:flutter/material.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const TextFieldWithLabel({
    Key? key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type Text ${this.labelText} "),
            ),
          ),
        ],
      ),
    );
  }
}

//simple info box to display message to user
class infoBox extends StatelessWidget {
  const infoBox({Key? key, required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${this.title}"),
      insetPadding: EdgeInsets.all(8.0),
      actions: [Text("ok")],
    );
  }
}

//take useruser inputs form by showdialog container ok and cancel
//will be used in the profile screen
// class ChangeInput extends StatefulWidget {
//   @override
//   _ChangeInputState createState() => _ChangeInputState();
// }

class ChangeInput extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    Future<void> editField(String field) async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit ${field}'),
          );
        },
      );
    }

    return AlertDialog(
      title: Text('Change Input'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(hintText: 'Enter text'),
          onChanged: (String value) {
            _inputText = value;
          },
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_inputText);
          },
        ),
      ],
    );
  }
}

class TextBox extends StatelessWidget {
  final String title;
  // final String form_data;
  final String sectionName;
  final Function()? onPressed;

  const TextBox(
      {super.key,
      required this.title,
      required this.sectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(this.title),
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[500]),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.edit,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
