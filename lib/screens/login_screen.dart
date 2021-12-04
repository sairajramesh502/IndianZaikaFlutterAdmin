import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika_admin/screens/home_screen.dart';
import 'package:indian_zaika_admin/services/firebase_services.dart';
import 'package:indian_zaika_admin/widgets/button.dart';

class MyHomePage extends StatefulWidget {
  static const String id = 'login-screen';
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final FirebaseServices _firebaseServices = FirebaseServices();
  String email = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Colors.amber.withOpacity(.3),
        animationDuration: const Duration(milliseconds: 500));

    Future<void> _login() async {
      progressDialog.show();
      _firebaseServices.getAdminCredentials().then((value) {
        value.docs.forEach((doc) async {
          if (doc.get('username') == email) {
            if (doc.get('password') == password) {
              UserCredential userCredential =
                  await FirebaseAuth.instance.signInAnonymously();
              progressDialog.dismiss();

              Navigator.pushReplacementNamed(context, HomeScreen.id);
              return;
            } else {
              progressDialog.dismiss();
              _firebaseServices.showMyDialog(
                context: context,
                title: 'Invalid Password',
                message: 'The Password You have enterred is Incorrect',
              );
            }
          } else {
            progressDialog.dismiss();
            _firebaseServices.showMyDialog(
              context: context,
              title: 'Invalid UserName',
              message: 'The UserName You have enterred is Incorrect',
            );
          }
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
      ),
      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.amber, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 0.5]),
              ),
              child: Center(
                child: SizedBox(
                  height: screenHeight / 1.5,
                  width: screenHeight / 1.8,
                  child: Card(
                    elevation: 5,
                    shape: Border.all(color: Colors.amber),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      'images/LogoProfile.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Indian Zaika Admin',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Username';
                                        }
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'User Name',
                                        contentPadding:
                                            EdgeInsets.only(left: 10),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Password';
                                        }
                                        if (value.length < 7) {
                                          return 'Minimum 7 Characters';
                                        }
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Password',
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: ButtonGlobal(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _login();
                                              }
                                            },
                                            buttonText: 'Login')),
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
