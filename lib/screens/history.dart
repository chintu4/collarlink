import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('History')),
        body: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Text("history");
            }));
  }
}
