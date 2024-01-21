import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  var names = ["Carpenter", "Electrician", "Load Lifter", "Plumber"];
  var location = ["Somajiguda", "Suraram", "Dundigal",];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 173, 136, 209),
        title: Text(
          "Home",
          style: TextStyle(fontSize: 30),
        ),
        leading: Icon(Icons.menu_open),
        actions: [
          Icon(
            Icons.call,
            size: 50,
          )
        ],
      ),
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
