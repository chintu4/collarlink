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
              var task = snapshot.data!.docs[index].data();
              var taskId = snapshot.data!.docs[index].id;

              return ListTile(
                title: Text(task!['title'] ?? "tasks"),
                subtitle: Text(task['description'] ?? "description"),
                onTap: () {
                  // When tapped, navigate to a new screen to show more details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailsScreen(taskId: taskId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class TaskDetailsScreen extends StatelessWidget {
  final String taskId;

  TaskDetailsScreen({required this.taskId});

  @override
  Widget build(BuildContext context) {
    // Fetch additional details for the specific task using taskId
    // ...

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future:
            FirebaseFirestore.instance.collection('tasks').doc(taskId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading task details'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var taskDetails = snapshot.data!.data();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: ${taskDetails!['title']}'),
                Text('Description: ${taskDetails['description']}'),
                // Add more details as needed
              ],
            ),
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
