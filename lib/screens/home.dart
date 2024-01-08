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
          ],
        ),
      ),
      body: Column(
        children: [
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
                  title: Text('Message'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Search'),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Profile'),
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
      ),
    );
  }
}
