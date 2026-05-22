import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyWidget.dart';
import 'add_page.dart';

class StudentData {
  int id;
  String name;
  String bookName;
  DateTime dueDate;
  bool submitted;

  StudentData({
    required this.id,
    required this.name,
    required this.bookName,
    required this.dueDate,
    required this.submitted,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "bookName": bookName,
      "dueDate": dueDate.toIso8601String(),
      "submitted": submitted,
    };
  }

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json["id"],
      name: json["name"],
      bookName: json["bookName"],
      dueDate: DateTime.parse(json["dueDate"]),
      submitted: json["submitted"],
    );
  }
}

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  static List<StudentData> students = [];

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> saveData() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    List<String> studentList = [];

    for (int i = 0;i < FragmentHolder.students.length;i++) {

      String student =jsonEncode(FragmentHolder.students[i].toJson(),);
      studentList.add(student);
    }

    prefs.setStringList(
      "students",
      studentList,
    );
  }

  
  Future<void> loadData() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    List<String>? studentList =
        prefs.getStringList("students");

    if (studentList != null) {

      FragmentHolder.students.clear();

      for (int i = 0;i < studentList.length;i++) {
        String studentString =studentList[i];

        Map<String, dynamic> studentMap=jsonDecode(studentString);

        StudentData student=StudentData.fromJson(studentMap);

        FragmentHolder.students.add(student);
      }
    }
     else {


      FragmentHolder.students = [

        StudentData(
          id: 101,
          name: "Dhanvi",
          bookName: "Harry Potter",
          dueDate: DateTime.now(),
          submitted: true,
        ),

        StudentData(
          id: 102,
          name: "Bharvi",
          bookName: "Flutter Basics",
          dueDate: DateTime.now(),
          submitted: false,
        ),

        StudentData(
          id: 103,
          name: "Maitri",
          bookName: "Flutter",
          dueDate: DateTime.now(),
          submitted: false,
        ),
      ];

      saveData();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        toolbarHeight: 75,

        backgroundColor:
            const Color(0xFF1C3A66),

        title: const Text(
          "My Library",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),

        actions: [

          IconButton(

            onPressed: () async {

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AddPage(),
                ),
              );

              saveData();

              setState(() {});
            },

            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: MyWidget(

        refresh: () {

          saveData();

          setState(() {});
        },
      ),
    );
  }
}