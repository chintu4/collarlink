import 'package:collarlink/screens/contactUs.dart';
import 'package:collarlink/screens/payments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collarlink/api/api.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '';

class WorkersScreen extends StatelessWidget {
  // WorkersScreen({super.key});

  var names = [
    "Carpenter",
    "Electrician",
    "Load Lifter",
  ];
  var location = [
    "Somajiguda",
    "Suraram",
    "Dundigal",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 173, 136, 209),
        title: Text(
          "Home",
          style: TextStyle(fontSize: 30),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Drawer(
                          child: ListView(
                            children: [
                              UserAccountsDrawerHeader(
                                accountName: Text('John Doe'),
                                accountEmail: Text('john.doe@example.com'),
                                currentAccountPicture: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://picsum.photos/200/200'),
                                ),
                              ),

                              ListTile(
                                title: Text('History'),
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/recentPost');
                                },
                              ),
                              ListTile(
                                title: Text('Recent Post'),
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/bookmark');
                                },
                              ),

                              ListTile(
                                title: Text('Payments'),
                                onTap: () {
                                  (Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentScreen()),
                                  ));
                                },
                              ),
                              // ListTile(
                              //   title: Text('Logout'),
                              //   onTap: () {
                              //     AuthService.signOut();
                              //     Navigator.pushReplacementNamed(context, '/login');
                              //   },

                              ListTile(
                                title: Row(
                                  children: [
                                    Text('Rate Us'),
                                    for (int i = 0; i < 5; i++)
                                      Icon(Icons.star,
                                          size: 15, color: Colors.amber),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        )));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.call,
              size: 50,
            ),
            onPressed: () {
              (Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactMePage())));
            },
          )
        ],
      ),
      drawer: Drawer(
          child: ListView(children: [
        DrawerHeader(
          child: Text('Drawer Header'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
      ])),
      backgroundColor: Color.fromRGBO(234, 213, 255, 1),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    size: 50,
                  ),
                  SizedBox(width: 16), // Add space between icon and title
                ],
              ),
              title: Text(names[index]),
              subtitle: Text(location[index]),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  Map<String, dynamic> postData = {
                    'taskName': 'To work',
                    'selectedNumber': 3,
                    'description': "Need Plumber for construction",
                    'location': "jubliee hills/hyderabad",
                    'typeOfWork': 'Wage Per Work',
                    // Add other fields as needed
                    'uid': AuthService.currentUser!.uid,

                    'amount': 5000,
                    'mason': 600,
                    'labour': 800,

                    'payForTravel': true,
                  };

                  try {
                    // Add the data to Firestore
                    // Optionally, you can call your AuthService method here if needed
                    await AuthService.pushPostScreenData(postData);

                    // Navigate to the next screen
                    Navigator.pushNamed(context, '/home');
                  } catch (e) {
                    // Handle any errors that occur during the Firestore operation
                    log('Error adding document to Firestore: $e');
                  }
                  AuthService.pushBookMarkData(postData);
                },
              ));
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 100,
            thickness: 1,
          );
        },
        itemCount: names.length,
      ),
    );
  }
}

class BookMarkScreen extends StatelessWidget {
  Future<List<DocumentSnapshot>> getBookmarks() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService.currentUser!.uid)
        .collection('bookmarks')
        .get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: getBookmarks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data![index];
                return ListTile(
                  title: Text(doc['title']),
                  subtitle: Text(doc['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
