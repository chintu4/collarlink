import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              // // DocumentReference ownerRef = snapshot.data!.docs[1]['owner'];

              // ownerRef.get().then((ownerSnapshot) {
              //   if (ownerSnapshot.exists) {
              //     Map<String, dynamic> ownerData =
              //         ownerSnapshot.data()! as Map<String, dynamic>;
              //     // Access owner data fields here, e.g., ownerData['name'], ownerData['email'], etc.

              //     // Example:
              //     print('Owner name: ${ownerData}');
              //   } else {
              //     // Handle the case where the owner document doesn't exist
              //     print('Owner document not found');
              //   }
              // });
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

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  // final String title;

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Create Task'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[])));
  }
}
