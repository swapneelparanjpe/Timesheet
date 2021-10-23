import 'package:timesheet/models/employee.dart';
import 'package:timesheet/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {


  final CollectionReference employeesCollection = FirebaseFirestore.instance.collection("employees");
  final String uid;

  DatabaseService({ required this.uid });

  List<Employee> _employeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Employee(
          name: doc.get("name")?? "",
          projects: doc.get("projects")?? "0",
          strengthHours: doc.get("strengthHours") ?? 0
      );
    }).toList();
  }

  Stream<List<Employee>> get employees {
    return employeesCollection.snapshots().map(_employeeListFromSnapshot);
  }

  UserEmployeeData _userEmployeeDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserEmployeeData(
        uid: uid,
        name: snapshot.get("name"),
        projects: snapshot.get("projects"),
        strengthHours: snapshot.get("strengthHours")
    );
  }


  Stream<UserEmployeeData> get userEmployeeData {
    return employeesCollection.doc(uid).snapshots().map(_userEmployeeDataFromSnapshot);
  }


  Future updateUserData(String name, String projects, int strengthHours) async {
    return await employeesCollection.doc(uid).set({
        "name": name,
        "projects": projects,
        "strengthHours": strengthHours
    });
  }

}
