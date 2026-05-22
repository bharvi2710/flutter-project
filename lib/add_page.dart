import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'fragment_holder.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController book = TextEditingController();

  DateTime dueDate = DateTime.now();

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        dueDate = picked;
      });
    }
  }

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = FragmentHolder.students.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList("students", data);
  }

  void addStudent() async {
    if (id.text.isEmpty || name.text.isEmpty || book.text.isEmpty) return;

    FragmentHolder.students.add(
      StudentData(
        id: int.parse(id.text),
        name: name.text,
        bookName: book.text,
        dueDate: dueDate,
        submitted: false,
      ),
    );

    await saveData();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1C3A66),
        title: const Text("Add Student", style: TextStyle(color: Colors.white)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(45),

        child: Column(
          children: [
            TextField(
              controller: id,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Student ID",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: book,
              decoration: const InputDecoration(
                labelText: "Book Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: pickDate,
              child: Text("${dueDate.day}/${dueDate.month}/${dueDate.year}"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: addStudent, child: const Text("Add")),
          ],
        ),
      ),
    );
  }
}