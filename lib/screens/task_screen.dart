import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collarlink/api/api.dart';

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
                title: Text(task['taskName'] ?? "unknown tasks"),
                subtitle: Text(task['description'] ?? "unknown description"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await AuthService.firestore
                        .collection('tasks')
                        .doc(taskId)
                        .delete();
                  },
                ),
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
                TaskDetailRow('Title', taskDetails!['taskName']),
                TaskDetailRow('Required Number', taskDetails['selectedNumber']),
                TaskDetailRow('Description', taskDetails!['description']),
                TaskDetailRow('Location', taskDetails['location']),
                TaskDetailRow('Type of Work', taskDetails!['typeOfWork']),
                TaskDetailRow('Amount', taskDetails!['amount']),
                TaskDetailRow('Mason', taskDetails!['mason']),
                TaskDetailRow('Labour', taskDetails!['labour']),

                // TaskDetailRow('Pay for Travel', taskDetails['payForTravel']),
                Divider(),
                UserDetailsStream(uid: taskDetails['uid']),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApplyScreen(taskId: taskId),
                        ),
                      );
                    },
                    child: Text("Apply"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TaskDetailRow extends StatelessWidget {
  final String label;
  final dynamic value;

  TaskDetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('$label:'),
          SizedBox(width: 8.0),
          Flexible(
            child: Text(
              '$value',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class UserDetailsStream extends StatelessWidget {
  final String uid;

  UserDetailsStream({required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        var userDocument = snapshot.data;
        String name = userDocument!['name'];
        String email = userDocument['email'];

        return Column(
          children: [
            TaskDetailRow('Name', name),
            TaskDetailRow('Email', email),
          ],
        );
      },
    );
  }
}

// class ApplyScreen extends StatelessWidget {
//   final String taskId;

//   ApplyScreen({required this.taskId});

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool willingToTakeTask = false;
//   List<String> names = [''];
//   TimeOfDay selectedTime = TimeOfDay.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Apply'),
//         centerTitle: true,
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16.0),
//           children: <Widget>[
//             SwitchListTile(
//               title: const Text('Willing to take this task?'),
//               value: willingToTakeTask,
//               onChanged: (bool value) {
//                 willingToTakeTask = value;
//               },
//             ),
//             ...names
//                 .map((name) => TextFormField(
//                       initialValue: name,
//                       onChanged: (value) {
//                         int index = names.indexOf(name);
//                         names[index] = value;
//                       },
//                     ))
//                 .toList(),
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 names.add('');
//               },
//             ),
//             TextButton(
//               onPressed: () async {
//                 selectedTime = (await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.now(),
//                     )) ??
//                     TimeOfDay.now();
//               },
//               child: Text('Select Time'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   FirebaseFirestore.instance
//                       .collection('tasks')
//                       .doc(taskId)
//                       .update({
//                     'applied': AuthService.currentUser?.uid,
//                     'names': names,
//                     'willingToTakeTask': willingToTakeTask,
//                     'startTime': DateTime(
//                             DateTime.now().year,
//                             DateTime.now().month,
//                             DateTime.now().day,
//                             selectedTime.hour,
//                             selectedTime.minute)
//                         .toIso8601String(),
//                   });
//                 }
//                 Navigator.of(context).pop();
//               },
//               child: Text('Apply'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ApplyScreen extends StatefulWidget {
  final String taskId;

  ApplyScreen({required this.taskId});

  @override
  _ApplyScreenState createState() => _ApplyScreenState(taskId: taskId);
}

class _ApplyScreenState extends State<ApplyScreen> {
  final String taskId;

  _ApplyScreenState({required this.taskId});

  bool switchValue = false;
  List<TextEditingController> textControllers = [TextEditingController()];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool willingToTakeTask = false;
  List<String> names = [''];
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Switch(
              value: switchValue,
              onChanged: (newValue) {
                setState(() {
                  switchValue = newValue;
                });
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: textControllers.length,
              itemBuilder: (context, index) {
                return TextFormField(
                  controller: textControllers[index],
                  decoration: InputDecoration(labelText: 'Name $index'),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  textControllers.add(TextEditingController());
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                names = textControllers
                    .map((controller) => controller.text)
                    .toList();
                if (_formKey.currentState!.validate()) {
                  FirebaseFirestore.instance
                      .collection('tasks')
                      .doc(taskId)
                      .update({
                    'applied': AuthService.currentUser?.uid,
                    'names': names,
                    'willingToTakeTask': willingToTakeTask,
                    'startTime': DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      selectedTime.hour,
                      selectedTime.minute,
                    ).toIso8601String(),
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
