import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'fragment_holder.dart';

class EditPage extends StatefulWidget {
  final StudentData student;

  const EditPage({super.key, required this.student});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController id;
  late TextEditingController name;
  late TextEditingController book;

  late DateTime dueDate;

  @override
  void initState() {
    super.initState();

    id = TextEditingController(text: widget.student.id.toString());
    name = TextEditingController(text: widget.student.name);
    book = TextEditingController(text: widget.student.bookName);

    dueDate = widget.student.dueDate;
  }

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

  void updateStudent() async {
    widget.student.id = int.parse(id.text);
    widget.student.name = name.text;
    widget.student.bookName = book.text;
    widget.student.dueDate = dueDate;

    await saveData();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1C3A66),
        title: const Text(
          "Edit Student",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
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

            ElevatedButton(
              onPressed: updateStudent,
              child: const Text("Update"),
            ),
          ],
        ),
      ),),
    );
  }

}