import 'package:collarlink/api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RecentPost extends StatelessWidget {
  const RecentPost({super.key});
//adding recent post of current

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recent Post"), centerTitle: true),
      body: StreamBuilder(
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
    );
  }
}
