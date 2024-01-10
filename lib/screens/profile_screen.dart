// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:collarlink/api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

// import 'package:messaging_app/api/api.dart';
// import '../helper/dialogs.dart';
// import '../main.dart';
// import 'package:../../models/User.dart';
import 'package:collarlink/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  //user
  final currentUser = FirebaseAuth.instance.currentUser;
  //all Users
  final usersCollection = FirebaseFirestore.instance.collection("users");

  //creating a new user with in firestore.

  @override
  Widget build(BuildContext context) {
    // Use the id and email values as needed
    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Use the picked image file to update the profile picture
        // Update the Firestore document with the new image URL or upload to Firebase Storage
        // Replace the following print statement with your logic
        print('Picked image path: ${pickedFile.path}');
      }
    }

    Future<void> editField(String field) async {
      TextEditingController newValue = TextEditingController();

      await showDialog(
        // key: _formKey,
        context: context,
        builder: (context) {
          // key:_formKey;
          return AlertDialog(
            title: Text('Edit $field'),
            shadowColor: Colors.blueAccent,
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Enter new ${field}",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              controller: newValue,
            ),
            actions: [
              TextButton(
                child: Text("Save"),
                onPressed: () async {
                  if (newValue.text.length > 0) {
                    // Update the Firestore document
                    await usersCollection
                        .doc(currentUser?.uid)
                        .update({field: newValue.text}).then((_) {
                      // Success case
                      print('Document successfully updated');
                    }).catchError((error) {
                      // Error case
                      print('Error updating document: $error');
                    });
                  }
                  Navigator.of(context).pop(newValue.text);
                },
              ),
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop(context); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }

    print(currentUser?.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: usersCollection.doc(AuthService.currentUser?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data?.data();

            if (userData != null && userData is Map<String, dynamic>) {
              // Handle the case where userData is not null and is of type Map<String, dynamic>
              // Your logic here
            } else {
              // Handle the case where userData is null or is not of type Map<String, dynamic>
              return Center(child: Text("No data available"));
            }

            return Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                  Text(
                    userData['username'] ?? 'Unknown',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    currentUser?.email ?? 'Unknown',
                    // await FirebaseStorage.instanceFor("users").bucket().snapshot(),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  TextBox(
                    title: "UserName",
                    sectionName: userData['username'] ?? "Unknown",
                    onPressed: () => editField("username"),
                  ),
                  // SizedBox(height: 20),
                  TextBox(
                      title: "Email",
                      sectionName: userData['email'] ?? "Unknown",
                      onPressed: () => editField("email")),
                  TextBox(
                      title: "About",
                      sectionName: userData['About'] ?? "Unknown",
                      onPressed: () => editField("About")),
                ],
              ),
            );
          } else {
            return Center(
                child: Column(
              children: [
                Text(
                  "Your internet might be gone or slow",
                  style: TextStyle(fontSize: 20),
                ),
                CircularProgressIndicator(),
              ],
            ));
          }
        },
      ),
    );
  }
}

class EditProfile extends StatelessWidget {
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _about = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                // You can replace the AssetImage with NetworkImage for online avatars
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              SizedBox(height: 20),
              TextFieldWithLabel(labelText: "Name", controller: _name),
              TextFieldWithLabel(labelText: "About", controller: _about),
              TextFieldWithLabel(labelText: "Email", controller: _email),
              TextFieldWithLabel(labelText: "Username", controller: _username),
              TextFieldWithLabel(labelText: "Password", controller: _password),
              SizedBox(height: 20),
              ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ));
  }
}

// You can add more information or widgets here
// such as user bio, statistics, etc.

//load current user data
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var question = "Hello word my name is chitnu tsafasdfasdkfsdkfjas";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //adda snapbar();
        body: Center(
      child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Text(
                question,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                onPressed: () {},
                child: Text("he"),
              ),
            ]),
          ])),
    ));
  }
}

class what extends StatefulWidget {
  const what({super.key});

  @override
  State<what> createState() => _whatState();
}

class _whatState extends State<what> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService.firestore.collection('users').snapshots(),
        // ignore: unnecessary_brace_in_string_interps
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Access data using snapshot.data.documents
            // dynamic data = snapshot.data?.docs;
            // for (var i in data) {
            //   print(i.data());
            // }
            QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
            dynamic data = querySnapshot.docs ?? 'hello';
            return Scaffold(
              body: Column(
                children: <Widget>[
                  Text("Data: ${data.length}"),
                  TextButton(
                    child: Text("back"),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                    //hello
                    ,
                  )
                ],
              ),
            );
          } else {
            return Container(
              child: Text("No data in the 'users' collection."),
            );
          }
        });
  }
}
