import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import '';

class APIS {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;

  // static Future<String> tasksData() async {
  //   var snapshot= FirebaseFirestore.instance.collection('tasks').doc('2zYHX3sHOXopfdZHJLH5').get();
  //   // Other code...
  //   return snapshot[snapshot];
  //   // return snapshot;
  // }
}
