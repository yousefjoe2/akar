import 'package:akar/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:akar/screens/adminscreens/adminhomescreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool showspinner = false;
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();

    _passwordcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorpurple3,
        title: Text('Login To My Account'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "please enter you email";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Fill Password Input';
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton(
                    color: colorpurple3,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      setState(() {
                        showspinner = true;
                      });
                      if (_formkey.currentState.validate()) {
                        var result = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailcontroller.text,
                                password: _passwordcontroller.text);
                        if (result != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminHomeScreen()));
                          setState(() {
                            showspinner = false;
                          });
                        }
                      }
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
