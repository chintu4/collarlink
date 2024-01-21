import 'dart:developer';

import 'package:collarlink/api/api.dart';
import 'package:collarlink/screens/contract.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';


//contractor Screen
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> images = [
    'assets/images/Group 6.png',
    'assets/images/Group 7.png',
    'assets/images/Group 8.png',
    'assets/images/Group 9.png',
    'assets/images/Group 10.png',
    'assets/images/Group 11.png',
  ];
  final List<String> images2 = [
    'assets/images/img_image_13.png',
    'assets/images/img_rectangle_257.png',
    'assets/images/img_rectangle_257.png',
  ];
  List Screen = ['carpenter', 'mechanic', 'carpenter', 'mechanic', 'mason'];

  String aValue = '';
  int currentIndex = 0;
  String role = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    AuthService.getPreference("role").then((value) {
      role = value;
    });
    // String role = await AuthService.getPreference("role");
    log(role);
    if (role != 'worker') {
      setState(() {
        aValue = role;
      });
    }
    log(role);
    if (role == '') {
      log("empty string");
    }
    // aValue = "nothing;
  }

  @override
  Widget build(BuildContext context) {
    // AuthService.savePreference("role", "worker");
    //handle to respectue teacher

    void _handleTap(int k) {
      log(k.toString());
      log(Screen[k]);

      Get.to(() => ContractScreen(typeOfPerson: Screen[k]));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Collarlink'),
        backgroundColor: Color.fromARGB(255, 184, 108, 255),
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
              title: Text('History'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/history');
              },
            ),
            ListTile(
              title: Text('Recent Post'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/recentPost');
              },
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
      body: Container(
        color: const Color.fromARGB(255, 250, 225, 255),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color.fromARGB(255, 184, 108, 255),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.phone,
                      size: 36,
                    ),
                    onPressed: () {},
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.yellow[400],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text(
                          'To Post a Job',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/createTask');
                        },
                        // style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
          Container(
            // child: Text("Type of work" ,style: TextStyle(),),
            margin: EdgeInsets.only(top: 20),
          ),
          // CarouselSlider(
          //   items: images.map((e) => Image(image: AssetImage(e))).toList(),
          //   options: CarouselOptions(
          //       autoPlay: true,
          //       onPageChanged: (index, reason) {
          //         OnTap() {
          //           log("tapped on $index");
          //         }
          //       } // or false to disable autoplay
          //       /}/ TODO:implement on tap feature

          //       ),
          CarouselSlider(
            items: List.generate(images.length, (index) {
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: Image.asset(images[index]),
              );
            }),
            // ... other CarouselSlider properties
            options: CarouselOptions(
                // ... carousel options
                ),
          ),
        ]),
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
                context, '/chatHomeScreen'); // Navigate to the search screen
          }
        },
      ),
    );
  }
}

// //try the superpass of the screen
// class ContractorHomeScreen extends StatelessWidget {
//   const ContractorHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Text("Contractor Home"),
//           Text("Contractor Home"),
//           Text("Contractor Home"),
//           Text("Contractor Home"),
//           Text("Contractor Home"),
//           Text("Contractor Home"),
//           Text("Contractor Home"),
//           Text("Contractor Home"),
//           Text("Contractor Home"),
//         ],
//       ),
//     );
//   }
// }
// 

