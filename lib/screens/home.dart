import 'package:flutter/material.dart';
import 'package:message/api/api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List subject = ['Maths', 'Physics', 'Biology'];
  final List<Widget> _children = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
  final Index = 0;

  @override
  Widget build(BuildContext context) {
    // final name = APIS.tasksData() as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('CollarLink'),
        centerTitle: true,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.home_filled),
            ),
            ListTile(
              title: const Text(
                'History',
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                'Post',
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                'Feedback',
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                'Payments',
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                'logout',
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              title: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text("Rate App"),
                  // for (int i = 0; i < 5; i++)
                  Icon(Icons.star, color: Colors.amber),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
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
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: Index,
        onTap: (index) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => _children[index]));
        },
      ),
      body: TasksScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading tasks'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!.docs;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(task['title']),
                subtitle: Text(
                    'Wage: ${task['wage']} \n Location: ${task['location']}'),
                // Add more features like onTap for viewing details or navigation
              );
            },
          );
        },
      ),
    );
  }
}
