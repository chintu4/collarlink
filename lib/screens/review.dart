import 'package:collarlink/api/api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Review extends StatelessWidget {
  final dynamic review;
  const Review({Key? key, required this.review});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService.firestore.collection('reviews').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return ListView.builder(
              itemCount: (snapshot.data as QuerySnapshot).docs.length,
              itemBuilder: (context, index) {
                return Text(
                    (snapshot.data as QuerySnapshot).docs[index]['review']);
              },
            );
          }
          return Text("hello World");
        });
  }
}

//     );
//   }
// }
