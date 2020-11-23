import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import '../../services/AuthService.dart';
import 'package:brew_crew/shared/loadingWidget.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  //for loading screen widget
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign into Brew Crew'),
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 15.0),
                    Flexible(
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Please enter your password' : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: inputTextDecoration.copyWith(
                            hintText: 'Enter Email Address'),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Flexible(
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Please enter your password' : null,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: true,
                        decoration: inputTextDecoration.copyWith(
                            hintText: 'Enter Password'),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.signinUser(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Incorrect Sign In Credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                      color: Colors.pink[400],
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

// SAVED FOR POSSIBLE FUTURE USE, ANON SIGN InheritedNotifier
//
// RaisedButton(
// child: Text('Sign in Anon'),
// onPressed: () async {
// dynamic result = await _auth
//     .signinAnon(); //just sets AuthService.dart's return _userFromFirebaseUser to == result
// if (result == null) {
// print('it is null');
// } else {
// print(result.uid);
// print('we signed in !!!');
// }
// },
// ),
