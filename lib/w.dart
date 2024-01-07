import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore.instance
    //     .collection('tasks')
    //     .doc('2zYHX3sHOXopfdZHJLH5')
    //     .update({'required': 200});
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TasksScreen(),
      // MyWidget(),
    );
  }
}

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading tasks'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // final task = snapshot.data!.docs[index];
              // print(snapshot.data!.docs.first);
              // var docData = snapshot.data!.docs[1].data();
              DocumentReference ownerRef = snapshot.data!.docs[1]['owner'];

              ownerRef.get().then((ownerSnapshot) {
                if (ownerSnapshot.exists) {
                  Map<String, dynamic> ownerData =
                      ownerSnapshot.data()! as Map<String, dynamic>;
                  // Access owner data fields here, e.g., ownerData['name'], ownerData['email'], etc.

                  // Example:
                  print('Owner name: ${ownerData}');
                } else {
                  // Handle the case where the owner document doesn't exist
                  print('Owner document not found');
                }
              });
            },
          );
        },
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .doc('2zYHX3sHOXopfdZHJLH5')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> taskData =
              snapshot.data!.data() as Map<String, dynamic>;
          // Access and display task data here
          return Text('Task title: ${taskData['title']}');
        } else if (snapshot.hasError) {
          return Text('Error fetching data: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       drawer: Drawer(
//           child: ListView(padding: EdgeInsets.zero, children: [
//         // DrawerHeader(
//         //     decoration: BoxDecoration(
//         //   color: Colors.blue,
//         // )),
//         Text("item1")
//       ])),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[



//           ] 
   
//    )));
//   }
// }
