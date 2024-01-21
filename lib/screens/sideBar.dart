import 'package:flutter/material.dart';
import 'package:collarlink/api/api.dart'; // Import your API file

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

