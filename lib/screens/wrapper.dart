import 'package:brew_crew/models/thisuser.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ThisUser>(context);

    //return Home() or Authenticate()
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
