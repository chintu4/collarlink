import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_login/flutter_login.dart';
// import 'dashboard_screen.dart';
// import 'package:message/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth user = FirebaseAuth.instance;

    Future<void> loginWithEmailAndPassword(
        BuildContext context, String email, String password) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User user = userCredential.user!;
        print('Logged in: ${user.email}');
        // Perform any additional actions after successful login
      } catch (e) {
        print('Login failed: $e');
        Alert(context, e);
      }
    }

    Future<void> signUpWithEmailAndPassword(
        String email, String password) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User user = userCredential.user!;
        print('Signed up: ${user.email}');
        // Perform any additional actions after successful sign-up
      } catch (e) {
        print('Sign-up failed: $e');
        Alert(context, e);
        // Handle sign-up failure
      }
    }

    Future<String> uploadImage(File imageFile, String userId) async {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('users/$userId/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    }

    void saveImageUrl(String imageUrl, String userId) {
      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('users');
      DocumentReference userDocRef = usersRef.doc(userId);
      userDocRef.update({
        'imageUrl': imageUrl,
      }).then((value) {
        print('Image URL saved to Firestore for user $userId');
      }).catchError((error) {
        print('Failed to save image URL to Firestore for user $userId: $error');
      });
    }

    // signUpWithEmailAndPassword("chintusharma00014@gmail.com", 'chintu');

    loginWithEmailAndPassword(context, "chintusharma00014@gmail.com", "chintu");
    // ImagePicker.platform.

    // uploadImage('C:\Users\HP\OneDrive\Desktop\Documents\chintu_sharma\message\assets\images\UserImage.jpg',
    // user.currentUser?.uid ?? "Image not uploaded");

    String username =
        user.currentUser?.displayName ?? "No user logged in and username";
    String UserEmail = user.currentUser?.email ?? "No user logged in and email";
    String UserId = user.currentUser?.uid ?? "No user logged in and userid";
    String UserAbout = user.currentUser?.email ?? "No user logged in and about";
    String UserImage =
        user.currentUser?.photoURL ?? "No user logged in and image";
    username = "hello";

    print(username);
    print(UserEmail);
    print(UserId);
    print(UserAbout);
    print(UserImage);

    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(Icons.person, size: 34.0)
                    // Image.asset('assets/images/UserImage.jpg',
                    //     fit: BoxFit.cover), // Fills the clip area
                    ),
                    
              ],
            ),
          ),
        ));
  }

  Future<dynamic> Alert(BuildContext context, Object e) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Error'),
          content: Text('Failed to log in: $e'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? _imageFile;
  bool _isUploading = false;
  String? _uploadedImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 200,
                  )
                : Placeholder(
                    fallbackHeight: 200,
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadImage,
              child: _isUploading
                  ? CircularProgressIndicator()
                  : Text('Upload Image'),
            ),
            SizedBox(height: 20),
            _uploadedImageUrl != null
                ? Text('Image uploaded!\nURL: $_uploadedImageUrl')
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    try {
      if (_imageFile != null) {
        // Get the current user's ID
        String? userId = FirebaseAuth.instance.currentUser?.uid;

        // Upload the image to Firebase Storage
        String imageUrl = await uploadImage(_imageFile!, userId!);

        // Save the image URL in Firestore
        saveImageUrl(imageUrl, userId);

        setState(() {
          _uploadedImageUrl = imageUrl;
        });
      }
    } catch (error) {
      print('Error uploading image: $error');
      setState(() {
        _uploadedImageUrl = null;
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<String> uploadImage(File imageFile, String userId) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('users/$userId/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void saveImageUrl(String imageUrl, String userId) {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDocRef = usersRef.doc(userId);
    userDocRef.update({
      'imageUrl': imageUrl,
    }).then((value) {
      print('Image URL saved to Firestore for user $userId');
    }).catchError((error) {
      print('Failed to save image URL to Firestore for user $userId: $error');
    });
  }
}




// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   Duration get loginTime => const Duration(milliseconds: 2250);
//   Future <String?> _authUser()

  // Future<String?> _authUser(LoginData data) {
  //   debugPrint('Name: ${data.name}, Password: ${data.password}');
  //   return Future.delayed(loginTime).then((_) {
  //     if (!users.containsKey(data.name)) {
  //       return 'User not exists';
  //     }
  //     if (users[data.name] != data.password) {
  //       return 'Password does not match';
  //     }
  //     return null;
  //   });
  // }
  //
  // Future<String?> _signupUser(SignupData data) {
  //   debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
  //   return Future.delayed(loginTime).then((_) {
  //     return null;
  //   });
  // }
  //
  // Future<String> _recoverPassword(String name) {
  //   deb    return "";
  // });ugPrint('Name: $name');
  //   return Future.delayed(loginTime).then((_) {
  //     if (!users.containsKey(name)) {
  //       return 'User not exists';
  //     }
  //
  // }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: 'ECORP',
//       logo: const AssetImage('assets/images/ecorp-lightblue.png'),
//       onLogin: _authUser,
//       onSignup: _signupUser,
//       onSubmitAnimationCompleted: () {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//         ));
//       },
//       onRecoverPassword: _recoverPassword,
//     );
//   }
// }


//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                   hintText: 'Enter your username',
//                 ),
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   hintText: 'Enter your password',
//                 ),
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Handle login logic here
//                     print('Username: ${_usernameController.text}');
//                     print('Password: ${_passwordController.text}');
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
