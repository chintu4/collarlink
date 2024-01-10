import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
