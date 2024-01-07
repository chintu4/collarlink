
### helloWorld
Iam today  writng a shot notes on experiment with firebase database
I have build a stream builder as following.

```dart
class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading tasks'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final task = snapshot.data!.docs[index];
              print(snapshot.data!.docs.length);
              return ListTile(
                title: Text(task['title'] ? "helo" : "fine"),
                subtitle: Text(task['description']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(task.id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
```
In this experiment i got document count by printing 
``` dart
print(snapshot.data!.docs.length);
```
### 2nd Experiment 

``` dart
return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final task = snapshot.data!.docs[index];
              print(snapshot.data!.docs.first);
            },
          );
```
#### 1
I have printed (snapshot.data!.docs.first)
I have got this in terminal :
`Instance of '_JsonQueryDocumentSnapshot'`
I need to get document data.

#### 2
##### firebase database
```dart 
// FirebaseFirestore.instance
    //     .collection('tasks')
    //     .doc('2zYHX3sHOXopfdZHJLH5')
    //     .update({'required': 200});

```
users /collections
  - 0 //documentId
    - wage : 100


``` dart
var docData = snapshot.data!.docs.first.data();
              print(docData);
```
##### output:
{wage: 100}

##### 2nd type of database 


```dart
var docData = snapshot.data!.docs[0].data();
              print(docData);
```
### output:
{wage: 100}

case1 and case2 i got same values as output

##### 2nd type of database
Question ? how to print geolocation value in firebase 
```dart
var docData = snapshot.data!.docs[1].data();
              print(docData['location'].latitude);
```
Above is the code for firebase
###### output:
90

complete data is
```{required: 200, location: Instance of 'GeoPoint', owner: DocumentReference<Map<String, dynamic>>(users/hC6gqx3vTWA71e2V20Ar), description: you need to work efficiently and daily.This is important work for me.Thank you., name: Daily Earner} ```

where  `location` field is: `Instance of 'GeoPoint'`
and `owner` field is of about `DocumentReference<Map<String, dynamic>>(users/hC6gqx3vTWA71e2V20Ar)`
about `DocumentReference`

Let us know the user name from firebase
 **Here's how to get the owner data in Flutter Firebase, given the structure you provided:**

1. **Access the Document Reference:**

   ```dart
   DocumentReference ownerRef = snapshot.data!.docs.first['owner'];
   ```

2. **Fetch Data from the Reference:**

   ```dart
   ownerRef.get().then((ownerSnapshot) {
       if (ownerSnapshot.exists) {
           Map<String, dynamic> ownerData = ownerSnapshot.data()!;
           // Access owner data fields here, e.g., ownerData['name'], ownerData['email'], etc.

           // Example:
           print('Owner name: ${ownerData['name']}');
       } else {
           // Handle the case where the owner document doesn't exist
           print('Owner document not found');
       }
   });
   ```

**Explanation:**

- **Access Document Reference:** The `owner` field is a `DocumentReference`, pointing to the owner's document in the "users" collection. Extract it using `snapshot.data!.docs.first['owner']`.
- **Fetch Data:** Use `ownerRef.get()` to retrieve data from the owner's document. It returns a `Future`, so handle it with `then()`.
- **Check Existence:** Ensure the owner document exists using `ownerSnapshot.exists`.
- **Access Data:** If it exists, access the data within `ownerSnapshot.data()!` as a `Map<String, dynamic>`.
- **Handle Missing Document:** Manage the case where the owner document is not found.

**Key Points:**

- Replace `snapshot` with your actual query snapshot variable.
- Adjust field names (`name`, `email`, etc.) based on your specific owner data structure.
- Consider error handling and loading states for a robust user experience.

### test 
```dart 
return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final task = snapshot.data!.docs[index];
              print(snapshot.data!.docs.first);
              // var docData = snapshot.data!.docs[1].data();
              // DocumentReference ownerRef = snapshot.data!.docs[1];

              // ownerRef.get().then((ownerSnapshot) {
              //   if (ownerSnapshot.exists) {
              //     Map<String, dynamic> ownerData =
              //         ownerSnapshot.data()! as Map<String, dynamic>;
              //     // Access owner data fields here, e.g., ownerData['name'], ownerData['email'], etc.

              //     // Example:
              //     print('Owner name: ${ownerData}');
              //   } else {
              //     // Handle the case where the owner document doesn't exist
              //     print('Owner document not found');
              //   }
              //   return Text("hello");
              // });
              // return Text("hello");
              return Text(task.id);
            },
          );
          ```
          task.id print all the document name .

