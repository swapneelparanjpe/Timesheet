import 'package:timesheet/models/users.dart';
import 'package:timesheet/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);
    print(user);

    // return home or authenticate
    return user == null ? Authenticate() : Home();
  }
}
