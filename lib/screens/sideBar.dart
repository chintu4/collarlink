<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:collarlink/api/api.dart'; // Import your API file
=======

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collarlink/api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:collarlink/widgets/widgets.dart';
>>>>>>> origin/chintus

class RecentPost extends StatefulWidget {
  const RecentPost({Key? key}) : super(key: key);

  @override
  _RecentPostState createState() => _RecentPostState();
}

class _RecentPostState extends State<RecentPost> {
  int currentIndex = 0; // Initialize currentIndex

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 184, 108, 255),
      leading: Icon(Icons.menu),
      actions: [Icon(Icons.search)],
        title: Text("Recent Post"),
         centerTitle: true
         ),
      body: Container(
        color: const Color.fromARGB(255, 250, 225, 255),
        child: StreamBuilder(
          stream: AuthService.firestore
              .collection('users')
              .doc(AuthService.currentUser?.uid)
              .collection('recentPost')
              .snapshots(),
          builder: (context, snapshot) {
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
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('john.doe@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/200/200'),
              ),
            ),
            ListTile(
              title: Text('List'),
              onTap: () {},
            ),
            ListTile(
              title: Text('History'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Recent Post'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/recentPost');
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Payments'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                AuthService.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Text('Rate Us'),
                  for (int i = 0; i < 5; i++)
                    Icon(Icons.star, size: 15, color: Colors.amber),
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index; // Update the current index
          });

          if (currentIndex == 0) {
            Navigator.pushReplacementNamed(
                context, '/home'); // Navigate to the profile screen
          } 
          if (currentIndex == 1) {
            Navigator.pushNamed(
                context, '/profile'); // Navigate to the profile screen
          } 
          else if (currentIndex == 2) {
            Navigator.pushNamed(
                context, '/task'); // Navigate to the search screen
          }
        },
      ),
    );
  }
}

<<<<<<< HEAD
=======
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
>>>>>>> origin/chintus
