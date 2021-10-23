import 'package:timesheet/models/employee.dart';
import 'package:flutter/material.dart';

class EmployeeTile extends StatelessWidget {

  final Employee employee;

  EmployeeTile({ required this.employee });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          tileColor: Colors.deepPurple[50],
          leading: AspectRatio(
            aspectRatio: 1,
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/time_icon.png'))),
              child: Text("${(employee.strengthHours/100).round()}"),
            ),
          ),


          // leading: CircleAvatar(
          //   radius: 25.0,
          //   backgroundImage: AssetImage("assets/time_icon.png"),
          // ),
          title: Text(employee.name),
          subtitle: Text("Working on ${employee.projects} project(s)"),
        ),
      ),
    );
  }
}
