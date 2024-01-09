import 'package:collarlink/api/api.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> images = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/300',
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collarlink'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
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
              title: Text('Post'),
              onTap: () {},
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
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.purple[100],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () {},
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'To Post a Job',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
          Text("Type of work"),
          CarouselSlider(
            items: images.map((e) => Image(image: NetworkImage(e))).toList(),
            options: CarouselOptions(
              autoPlay: true, // or false to disable autoplay
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Search tasks'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Search'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(currentIndex.toString()),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
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
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index; // Update the current index
          });

          if (currentIndex == 1) {
            Navigator.pushNamed(
                context, '/profile'); // Navigate to the profile screen
          } else if (currentIndex == 2) {
            Navigator.pushNamed(
              context,
              '/task',
            ); // Navigate to the search screen
          }
        },
      ),
    );
  }
}
