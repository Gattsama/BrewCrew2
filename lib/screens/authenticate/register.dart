import 'package:brew_crew/shared/loadingWidget.dart';
import 'package:flutter/material.dart';
import '../../services/AuthService.dart';
import 'package:brew_crew/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
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
                    label: Text('Sign In'))
              ],
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Register for Brew Crew'),
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(height: 15.0),
                    Flexible(
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Enter an Email' : null,
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
                        validator: (value) => value.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
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
                        //SING INTO FIREBASE with username and password
                        if (_formkey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .registerWithEmailAndPasswd(email, password);

                          if (result == null) {
                            setState(() => error = 'please supply valid email');
                            loading = false;
                            print(error);
                          }
                        }
                      },
                      color: Colors.pink[400],
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                        child: Text('Sign in Anon'),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          await _auth.signinAnon();
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
