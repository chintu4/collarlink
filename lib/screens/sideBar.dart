import 'package:collarlink/api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:collarlink/widgets/widgets.dart';

class RecentPost extends StatelessWidget {
  const RecentPost({Key? key});
//adding recent post of current

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recent Post"), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: AuthService.firestore
            .collection('users')
            .doc(AuthService.currentUser?.uid)
            .collection('recentPost')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(post['taskName']),
                  subtitle: Text(post['description']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await AuthService.firestore
                          .collection('users')
                          .doc(AuthService.currentUser?.uid)
                          .collection('recentPost')
                          .doc(post.id)
                          .delete();
                    },
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(post['taskName']),
                          content: Text('Description: ${post['description']}'),
                          actions: [
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}

class PostEditScreen extends StatelessWidget {
  final String taskId;

  PostEditScreen({required this.taskId});

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController selectedNumberController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController typeOfWorkController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController masonController = TextEditingController();
  final TextEditingController labourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task Details'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: AuthService.firestore.collection('tasks').doc(taskId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading task details'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var taskDetails = snapshot.data!.data();

          // Set initial values to controllers
          taskNameController.text = taskDetails!['taskName'];
          selectedNumberController.text =
              taskDetails['selectedNumber'].toString();
          descriptionController.text = taskDetails['description'];
          locationController.text = taskDetails['location'];
          typeOfWorkController.text = taskDetails['typeOfWork'];
          amountController.text = taskDetails['amount'].toString();
          masonController.text = taskDetails['mason'];
          labourController.text = taskDetails['labour'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWithLabel(
                    labelText: 'Title', controller: taskNameController),
                TextFieldWithLabel(
                    labelText: 'Required Number',
                    controller: selectedNumberController),
                TextFieldWithLabel(
                    labelText: 'Description',
                    controller: descriptionController),
                TextFieldWithLabel(
                    labelText: 'Location', controller: locationController),
                TextFieldWithLabel(
                    labelText: 'Type of Work',
                    controller: typeOfWorkController),
                TextFieldWithLabel(
                    labelText: 'Amount', controller: amountController),
                TextFieldWithLabel(
                    labelText: 'Mason', controller: masonController),
                TextFieldWithLabel(
                    labelText: 'Labour', controller: labourController),

                // TaskDetailRow('Pay for Travel', taskDetails['payForTravel']),
                Divider(),

                Center(
                  child: TextButton(
                    onPressed: () {
                      // Get updated values from controllers
                      String updatedTaskName = taskNameController.text;
                      int updatedSelectedNumber =
                          int.parse(selectedNumberController.text);
                      String updatedDescription = descriptionController.text;
                      String updatedLocation = locationController.text;
                      String updatedTypeOfWork = typeOfWorkController.text;
                      String updatedAmount = amountController.text;
                      String updatedMason = masonController.text;
                      String updatedLabour = labourController.text;

                      // TODO: Update Firestore with the updated values
                    },
                    child: Text("Apply"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Update'),
        icon: Icon(Icons.check),
        backgroundColor: Colors.red[400],
      ),
    );
  }
}

class TaskHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task History"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: AuthService.firestore
            .collection('users')
            .doc(AuthService.currentUser?.uid)
            .collection('recentPost')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading task history'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var taskHistory = (snapshot.data! as QuerySnapshot).docs;

          return ListView.builder(
            itemCount: taskHistory.length,
            itemBuilder: (context, index) {
              var task = taskHistory[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(task['taskName'] ?? 'Default value'),
                subtitle: Text(task['description'] ?? 'Default value'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TaskDetailsScreen(taskDetails: task),
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
  final Map<String, dynamic> taskDetails;

  TaskDetailsScreen({required this.taskDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${taskDetails['taskName']}"),
            Text("Required Number: ${taskDetails['selectedNumber']}"),
            Text("Description: ${taskDetails['description']}"),
            Text("Location: ${taskDetails['location']}"),
            Text("Type of Work: ${taskDetails['typeOfWork']}"),
            Text("Amount: ${taskDetails['amount']}"),
            Text("Mason: ${taskDetails['mason']}"),
            Text("Labour: ${taskDetails['labour']}"),
            Divider(),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
