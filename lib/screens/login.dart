import 'package:collarlink/api/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.red,
            ],
          ),
        ),
        child: Card(
          margin: EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Image.asset('assets/images/img_telegram_cloud.png'),
              ),
              Text(
                "CollarLink",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  color: Colors.teal[100],
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   image: AssetImage('assets/images/googleimage.png'),
                          //   fit: BoxFit.cover,
                          // ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await AuthService.stasignInWithGoogle();

                          // APIshandleSignIn(_googleSignIn);
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Text("Sign In with Google"),
                      ),
                      TextButton(
                        onPressed: () {
                          AuthService.signOut();

                          // APIshandleSignIn(_googleSignIn);
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text("sign out"),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // signup(context);
                    SnackBar(
                      content: Text('your have a tap'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}