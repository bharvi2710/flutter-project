import 'package:flutter/material.dart';
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
}

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  static List<StudentData> students = [
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

    StudentData(
      id: 104,
      name: "Sara",
      bookName: "Java",
      dueDate: DateTime(2026, 6, 12),
      submitted: false,
    ),
  ];

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color(0xFF1C3A66),

        title: const Text(
          "My Library",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),

        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddPage()),
              );

              setState(() {});
            },

            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),

      body: MyWidget(
        refresh: () {
          setState(() {});
        },
      ),
    );
  }
}
