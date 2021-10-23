import 'package:timesheet/models/employee.dart';
import 'package:timesheet/models/users.dart';
import 'package:timesheet/screens/home/employee_list.dart';
import 'package:timesheet/screens/home/settings_form.dart';
import 'package:timesheet/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet/services/database.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Employee>>.value(
      value: DatabaseService(uid: user!.uid).employees,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          elevation: 0.0,
          title: Text("Timesheet"),
          actions: [
            IconButton(
                icon: Icon(
                    Icons.edit,
                    color: Colors.white
                ),
                tooltip: "Edit data",
                onPressed: () => _showSettingsPanel(),
            ),
            IconButton(
                icon: Icon(
                    Icons.logout,
                    color: Colors.white
                ),
                tooltip: "Log out",
                onPressed: () async {
                  await _auth.signOut();
                }
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/timesheet_bg.png"),
              fit: BoxFit.cover
            )
          ),
            child: EmployeeList()
        ),
      ),
    );
  }
}
