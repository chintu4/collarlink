import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class ContractScreen extends StatefulWidget {
  final String typeOfPerson;
  const ContractScreen({Key? key, required this.typeOfPerson})
      : super(key: key);

  @override
  State<ContractScreen> createState() =>
      _ContractScreenState(typeOfPerson: typeOfPerson);
}

class _ContractScreenState extends State<ContractScreen> {
  final String typeOfPerson;

  _ContractScreenState({required this.typeOfPerson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("demo"),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          // return Center(child: Text(snapshot.data!.docs[0]['name']));
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var user = snapshot.data!.docs[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['']),
                ),
                title: Text(user['name']),
                trailing: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        // Handle message icon tap
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        // Handle message icon tap
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
