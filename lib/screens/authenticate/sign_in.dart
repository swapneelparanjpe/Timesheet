import 'package:timesheet/services/auth.dart';
import 'package:timesheet/shared/constants.dart';
import 'package:timesheet/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ required this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          elevation: 0.0,
          title: Text("Sign In"),
          actions: [
            FlatButton.icon(
                icon: Icon(
                    Icons.person_add,
                    color: Colors.white
                ),
                label: Text(
                    "Register",
                    style: TextStyle(color: Colors.white)
                ),
                onPressed: () async {
                  widget.toggleView();
                }
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/timesheet_bg.png"),
                    fit: BoxFit.cover
                )
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 60.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: "Email"
                    ),
                    validator: (value) =>
                    value!.isEmpty
                        ? "Enter an email"
                        : null,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: "Password"
                    ),
                    validator: (value) =>
                    value!.length <= 8
                        ? "Enter a stronger password (8+ characters)"
                        : null,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.deepPurple[400],
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = "Couldn't sign in. Please try again";
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0
                    ),
                  ),
                ],
              ),
            )
        ),
      );
    }
  }
}
