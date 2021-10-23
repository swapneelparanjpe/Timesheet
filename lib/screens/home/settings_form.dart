import 'package:timesheet/models/users.dart';
import 'package:timesheet/services/database.dart';
import 'package:timesheet/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:timesheet/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> projects = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentProjects;
  int? _currentStrengthHours;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);

    return StreamBuilder<UserEmployeeData>(
      stream: DatabaseService(uid: user!.uid).userEmployeeData,
      builder: (context, snapshot) {

        UserEmployeeData? userEmployeeData = snapshot.data;
        if (snapshot.hasData) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Update your timesheet details for today",
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userEmployeeData!.name,
                  decoration: textInputDecoration.copyWith(hintText: "Name"),
                  validator: (value) =>
                  value!.isEmpty ? "Please enter a name" : null,
                  onChanged: (value) => setState(() => _currentName = value),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  items: projects.map((project) {
                    return DropdownMenuItem(
                      value: project,
                      child: Text("$project projects"),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _currentProjects = value.toString()),
                  value: _currentProjects ?? userEmployeeData.projects,
                  decoration: textInputDecoration,
                ),
                SizedBox(height: 30.0),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    child: Text("Number of hours worked")),
                Slider(
                  min: 0.0,
                  max: 1800.0,
                  divisions: 18,
                  label: ((_currentStrengthHours ?? userEmployeeData.strengthHours)/100).round().toString(),
                  value: (_currentStrengthHours ?? userEmployeeData.strengthHours).toDouble(),
                  onChanged: (value) =>
                      setState(() => _currentStrengthHours = value.round()),
                  activeColor: Colors.deepPurple[800],
                  inactiveColor: Colors.deepPurple[100],
                ),
                SizedBox(height: 40.0),
                RaisedButton(
                    color: Colors.deepPurple[400],
                    child: Text(
                      "Update",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userEmployeeData.name,
                            _currentProjects ?? userEmployeeData.projects,
                            _currentStrengthHours ?? userEmployeeData.strengthHours
                        );
                        Navigator.pop(context);
                      }
                    }
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}
