import 'package:collarlink/screens/contactUs.dart';
import 'package:collarlink/screens/payments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                                      context, '/recentPost');
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
            trailing: Icon(Icons.add),
          );
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
